import sublime
import sublime_plugin
import re

from .julia_unicode import latex_symbols, emoji_symbols

RE_COMMAND_PREFIX = re.compile(
    r".*(\\[\^_]+[a-zA-Z0-9=+\-()]*|\\[a-zA-Z]+|\\:[_a-zA-Z0-9+\-]+:*)$")

symbols = latex_symbols + emoji_symbols


class JuliaUnicodeMixin(object):
    def find_command_backward(self, view, pt):
        line_content = view.substr(view.line(pt))
        row, col = view.rowcol(pt)
        m = RE_COMMAND_PREFIX.match(line_content[:col])
        if m:
            return sublime.Region(pt - len(m.group(1)), pt)

    def look_command_backward(self, view, pt):
        ret = self.find_command_backward(view, pt)
        if ret:
            return view.substr(ret)


def normalize_completion(symbols):
    return sublime.CompletionList(
            (sublime.CompletionItem(
                trigger=s[0],
                completion=s[1],
                annotation=s[1],
                kind=(sublime.KIND_ID_AMBIGUOUS, s[1], "unicode"))
                for s in symbols if len(s[1]) == 1),
            flags=sublime.INHIBIT_WORD_COMPLETIONS | sublime.INHIBIT_EXPLICIT_COMPLETIONS)


class JuliaUnicodeListener(JuliaUnicodeMixin, sublime_plugin.EventListener):

    def should_complete(self, view, pt):
        if view.score_selector(pt, "source.julia") > 0:
            return True
        elif view.settings().get('is_widget') and \
                view.window().active_view().match_selector(pt, "source.julia"):
            return True
        else:
            return False

    def on_query_completions(self, view, prefix, locations):
        if not self.should_complete(view, locations[0]):
            return None

        prefix = self.look_command_backward(view, locations[0])
        if not prefix:
            return None

        ret = [s for s in latex_symbols if s[0].startswith(prefix)]
        if not ret:
            ret = [s for s in emoji_symbols if s[0].startswith(prefix)]

        return normalize_completion(ret)

    def on_text_changed_async(self, view, changes):
        # sublime ac is not case sensitive, this is a hack to hide auto complete panel when
        # there is an exact match
        if view.score_selector(0, "source.julia") <= 0:
            return
        if not changes:
            return
        if not view.is_auto_complete_visible():
            return
        prefix = self.look_command_backward(view, changes[0].b.pt + 1)
        if not prefix:
            return
        for s in symbols:
            if s[0] == prefix:
                view.run_command("hide_auto_complete")
                return

    def on_query_context(self, view, key, operator, operand, match_all):
        sel = view.sel()
        if len(sel) == 0 or not sel[0].empty():
            return

        pt = view.sel()[0].end()

        if not self.should_complete(view, pt):
            return None

        if key == 'julia_unicode_exact_match':
            prefix = self.look_command_backward(view, pt)
            for s in symbols:
                if s[0] == prefix:
                    return True
            return False

        return None


class JuliaUnicodeInsertCompletionCommand(JuliaUnicodeMixin, sublime_plugin.TextCommand):
    def run(self, edit):
        view = self.view
        for sel in view.sel():
            if not sel.empty():
                continue
            prefix = self.look_command_backward(view, sel.begin())
            if not prefix:
                return None
            for s in symbols:
                if s[0] == prefix:
                    view.replace(edit, sublime.Region(sel.begin() - len(s[0]), sel.begin()), s[1])
                    return
