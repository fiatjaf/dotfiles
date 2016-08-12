import ranger.api
import ranger.core.linemode

import subprocess
import json


@ranger.api.register_linemode
class GitAnnexMetadataLinemode(ranger.core.linemode.LinemodeBase):
    name = 'git-annex-metadata'

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if not file.is_link:
            raise NotImplementedError

        try:
            o = subprocess.check_output([
                'git-annex', 'metadata',
                file.path, '--json'])
        except subprocess.CalledProcessError:
            raise NotImplementedError

        info = []

        try:
            meta = json.loads(o)
        except (UnicodeDecodeError, ValueError):
            return o

        meta.pop('command')
        meta.pop('file')
        meta.pop('key')
        meta.pop('success')
        meta.pop('note')
        meta.pop('lastchanged')

        for tag in meta.pop('tag', []):
            info.append(tag)

        for key in sorted(meta.keys()):
            if key.endswith('-lastchanged'):
                continue

            val = [v for v in meta[key] if v]
            if val:
                info.insert(0, key + ':' + '/'.join(val))

        return ' '.join(info)


@ranger.api.register_linemode
class GitAnnexWhereisLinemode(ranger.core.linemode.LinemodeBase):
    name = 'git-annex-whereis'

    @property
    def repositories(self):
        if self._repositories:
            return self._repositories

        try:
            o = subprocess.check_output([
                'git-annex', 'info', '--json'
            ])
        except subprocess.CalledProcessError:
            raise NotImplementedError

        info = json.loads(o)

        self._repositories = {}
        for repo in info['trusted repositories']:
            self._repositories[repo['uuid']] = repo
        for repo in info['semitrusted repositories']:
            self._repositories[repo['uuid']] = repo
        for repo in info['untrusted repositories']:
            self._repositories[repo['uuid']] = repo

        for uuid, repo in self._repositories.items():
            spl = repo['description'].split('[')
            name = spl[-1][:-1] if len(spl) > 1 else repo['description']
            self._repositories[uuid] = name

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if not file.is_link:
            raise NotImplementedError

        try:
            o = subprocess.check_output([
                'git-annex', 'whereis',
                file.path, '--json'])
        except subprocess.CalledProcessError:
            raise NotImplementedError

        data = json.loads(o)
        places = data['whereis'] + data['untrusted']
        repos = (self.repositories[r['uuid']] for r in places if not r['here'])

        if len(places) > 2:
            repos = [repo[:5] for repo in repos]
        else:
            repos = list(repos)

        return '[' + '|'.join(repos) + ']'
