config.load_autoconfig(False)

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.position = "top"
c.url.auto_search = "dns"
c.url.default_page = "https://farside.link/whoogle"
c.url.start_pages = [c.url.default_page]
c.url.searchengines = {
    "DEFAULT": "https://farside.link/whoogle/search?q={}",
    "google": "https://google.com/search?q={}",
    "wikipedia": "https://farside.link/wikiless/{}",
    "youtube": "https://farside.link/invidious/search?q={}",
    "github": "https://github.com/search?q={}",
    "twitter": "https://twitter.com/search?q={}",
    "ddg": "https://duckduckgo.com/?q={}",
}
c.zoom.default = "90%"
c.editor.command = ["/usr/bin/nvim", "{}"]
c.completion.open_categories = [
    "quickmarks",
    "history",
    "bookmarks",
    "filesystem",
    "searchengines",
]
c.aliases["translate"] = "spawn --userscript translate"

to_delete = ["<Ctrl+B>", "r", "<Ctrl+W>", "gm", "gK", "gJ"]
for key in to_delete:
    if key in c.bindings.default["normal"]:
        del c.bindings.default["normal"][key]

config.bind("<Ctrl+j>", "tab-move +")
config.bind("<Ctrl+k>", "tab-move -")
config.bind("<Ctrl+x>", "tab-close")
config.bind("r", "spawn --userscript farside")
