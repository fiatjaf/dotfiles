# generic
def partition_by(sel):
  reduce .[] as $item
    ( {}
    ; ($item | sel | tostring) as $res | .[$res] = (.[$res] // []) + [$item]
    )
;
def partition: partition_by(.);
def count_by(sel): partition_by(sel) | to_entries | map(.value = (.value | length)) | from_entries;

# nostr-related functions
def tags(tagName): .tags | map(select(.[0] == tagName));
def tag(tagName): tags(tagName) | .[0];
def tag_value(tagName): tag(tagName)[1];
def has_tag(tagName): (tags(tagName) | length) > 0;
def hasnt_tag(tagName): (tags(tagName) | length) == 0;
def has_tag_value(tagName; tagValue): tags(tagName) | map(select(.[1] == tagValue)) | length > 0;
