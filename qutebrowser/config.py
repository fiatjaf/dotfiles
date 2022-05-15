config.load_autoconfig(False)

c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.position = "bottom"
c.url.auto_search = "dns"
c.url.default_page = "https://farside.link/whoogle"
c.url.start_pages = [c.url.default_page]
c.url.searchengines = {
    "DEFAULT": "https://farside.link/whoogle/search?q={}",
    "google": "https://google.com/search?q={}",
    "wikipedia": "https://en.wikipedia.org/wiki/{}",
    "youtube": "https://www.youtube.com/results?search_query={}",
    "github": "https://github.com/search?q={}",
    "twitter": "https://twitter.com/search?q={}",
    "ddg": "https://duckduckgo.com/?q={}",
}
c.zoom.default = "90%"
