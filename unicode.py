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

    def fix_completion(self, view, edit):
        for sel in view.sel():
            pt = sel.begin()
            if view.substr(sublime.Region(pt-3, pt-1)) == "\\:":
                view.replace(edit, sublime.Region(pt-3, pt-1), "")
            elif view.substr(sublime.Region(pt-4, pt-1)) == "\\:+":
                view.replace(edit, sublime.Region(pt-4, pt-1), "")
            elif view.substr(sublime.Region(pt-4, pt-1)) == "\\:-":
                view.replace(edit, sublime.Region(pt-4, pt-1), "")


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

        ret = [(s[0] + "\t" + s[1], s[1]) for s in latex_symbols if s[0].startswith(prefix)]
        if not ret:
            ret = [(s[0][1:] + "\t" + s[1], s[1]) for s in emoji_symbols if s[0].startswith(prefix)]

        return (ret, sublime.INHIBIT_WORD_COMPLETIONS | sublime.INHIBIT_EXPLICIT_COMPLETIONS)

    def on_query_context(self, view, key, operator, operand, match_all):

        sel = view.sel()
        if len(sel) == 0 or not sel[0].empty():
            return

        pt = view.sel()[0].end()

        if not self.should_complete(view, pt):
            return None

        if key == 'julia_unicode_only_one_match':
            prefix = self.look_command_backward(view, pt)
            count = 0
            for s in symbols:
                if s[0].startswith(prefix):
                    count = count + 1
            return (count == 1) == operand
        elif key == 'julia_unicode_has_matches':
            prefix = self.look_command_backward(view, pt)
            return (prefix is not None) == operand

        return None


class JuliaUnicodeAutoComplete(JuliaUnicodeMixin, sublime_plugin.TextCommand):
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


class JuliaUnicodeCommitComplete(JuliaUnicodeMixin, sublime_plugin.TextCommand):
    def run(self, edit):
        view = self.view
        view.run_command("commit_completion")
        self.fix_completion(view, edit)
