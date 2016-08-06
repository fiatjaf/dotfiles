import ranger.api
import ranger.api.commands

import subprocess
import json


class ga_tag(ranger.api.commands.Command):
    """:ga_tag <tagname> [tagname...]

    Tags the current file with git-annex metadata.
    """

    def execute(self):
        if not self.arg(1):
            return

        for f in self.fm.thistab.get_selection():
            for tag in self.args[1:]:
                subprocess.check_output([
                    'git-annex', 'metadata', '-t', tag, f.path])

        self.fm.notify('tagged in git-annex!')
        # self.fm.reload_cwd()


class ga_set(ranger.api.commands.Command):
    """:ga_set <key>=<value> [<key>=<value>...]

    Sets the metadata key-value pair in git-annex for the current file.
    "=" can be "+=", "-=" or "?=".
    """

    def execute(self):
        if not self.arg(1):
            return

        for f in self.fm.thistab.get_selection():
            for pair in self.args[1:]:
                if '=' not in pair:
                    continue

                subprocess.check_output([
                    'git-annex', 'metadata', '-s', pair, f.path])

        self.fm.notify('set in git-annex!')
        # self.fm.reload_cwd()


class ga_whereis(ranger.api.commands.Command):
    """:ga_whereis

    Shows in which other git-annex repos the current file is.
    Doesn't show the present repo, since it should be clear from ranger.
    """

    def execute(self):
        f = self.fm.thisfile
        o = subprocess.check_output([
            'git-annex', 'whereis', f.path, '--json'])

        data = json.loads(o)
        places = data['whereis'] + data['untrusted']

        repos = []
        for repo in places:
            if not repo['here']:
                spl = repo['description'].split('[')
                name = spl[-1][:-1] if len(spl) > 1 else repo['description']
                repos.append(name)

        self.fm.notify(' | '.join(repos))
