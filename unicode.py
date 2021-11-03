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
                kind=sublime.KIND_AMBIGUOUS)
                for s in symbols),
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

    def on_query_context(self, view, key, operator, operand, match_all):
        sel = view.sel()
        if len(sel) == 0 or not sel[0].empty():
            return

        pt = sel[0].end()
        if key == "active_view_is_julia":
            if view.settings().get('is_widget'):
                active_view = view.window().active_view()
                if active_view:
                    sel = active_view.sel()
                    if len(sel) >= 1:
                        return active_view.score_selector(sel[0].begin(), "source.julia") > 0

        elif key == 'julia_unicode_has_matches':
            prefix = self.look_command_backward(view, pt)
            return (prefix is not None) == operand

        return None


class JuliaUnicodeInsertBestCompletion(JuliaUnicodeMixin, sublime_plugin.TextCommand):
    def run(self, edit, next_completion=False):
        view = self.view
        if len(view.sel()) == 0 or not view.sel()[0].empty():
            return
        pt = view.sel()[0].end()

        if not next_completion:
            prefix = self.look_command_backward(view, pt)
            if prefix:
                exact_match = [s[1] for s in symbols if s[0] == prefix]
                self.completions = exact_match + \
                        list(set([s[1] for s in symbols if s[0].startswith(prefix) and s[0] != prefix]))
                for sel in reversed(view.sel()):
                    region = sublime.Region(sel.begin()-len(prefix), sel.begin())
                    view.replace(edit, region, self.completions[0])
        else:
            region = sublime.Region(view.sel()[0].begin()-1, view.sel()[0].begin())
            prev_char = view.substr(region)
            if prev_char in self.completions:
                prev_index = self.completions.index(prev_char)
                next_index = prev_index + 1 if prev_index < len(self.completions) - 1 else 0
                for sel in reversed(view.sel()):
                    pt = sel.begin()
                    if view.substr(sublime.Region(pt-1, pt)) == prev_char:
                        view.replace(edit, sublime.Region(pt-1, pt), self.completions[next_index])
