import ranger.api
import ranger.api.commands

import subprocess
import tempfile
import json
import os


class utils():
    def probably_not_indexed(self, f, fname):
        # let's check if the file is indexed
        o = subprocess.check_output([
            'git-annex', 'status', f.path, '--json'
        ])
        try:
            status = json.loads(o)['status']
            if status == '?':
                self.fm.notify(
                    "'{}' is not indexed or was renamed. "
                    "You must commit the changes.".format(fname)
                    .encode('utf-8')
                )
                return
        except ValueError:
            self.fm.notify(
                "'{}' is probably not indexed.".format(fname)
                .encode('utf-8')
            )
            return


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


class ga_get(ranger.api.commands.Command, utils):
    """:ga_get

    Fetches current file from a different git-annex remote (or special remote).
    """

    def execute(self):
        for f in self.fm.thistab.get_selection():
            fname = f.basename.decode('utf-8')
            self.fm.notify(
                u"fetching'{}'...".format(fname).encode('utf-8')
            )
            try:
                o = subprocess.check_output([
                    'git-annex', 'get', f.path, '--json'])
            except subprocess.CalledProcessError as e:
                self.fm.notify(e.output, bad=True)
                continue

            try:
                data = json.loads(o)
                if data['success']:
                    self.fm.notify(
                        u"'{}' fetched successfully.".format(fname)
                        .encode('utf-8')
                    )
                else:
                    self.fm.notify(o.encode('utf-8'), bad=True)
            except ValueError:
                if self.probably_not_indexed(f, fname):
                    continue

                self.fm.notify('error: ' + repr(o), bad=True)

        self.fm.reload_cwd()


class ga_drop(ranger.api.commands.Command, utils):
    """:ga_drop

    Drops current file from this git-annex repository here
    (as long as it is present in <numcopies> other repositories).
    """

    def execute(self):
        for f in self.fm.thistab.get_selection():
            fname = f.basename.decode('utf-8')

            self.fm.notify(
                u"dropping '{}'...".format(fname).encode('utf-8')
            )
            try:
                o = subprocess.check_output([
                    'git-annex', 'drop', f.path, '--json'
                ])
            except subprocess.CalledProcessError as e:
                self.fm.notify(e.output, bad=True)
                continue

            try:
                data = json.loads(o)
                if data['success']:
                    self.fm.notify(
                        u"'{}' dropped successfully.".format(fname)
                        .encode('utf-8')
                    )
                else:
                    self.fm.notify(o.encode('utf-8'), bad=True)
            except ValueError:
                if self.probably_not_indexed(f, fname):
                    continue

                self.fm.notify('error: ' + repr(o), bad=True)

        self.fm.reload_cwd()
