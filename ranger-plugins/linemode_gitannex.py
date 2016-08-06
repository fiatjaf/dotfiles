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
