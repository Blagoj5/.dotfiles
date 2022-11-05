config.load_autoconfig(True)
c.content.blocking.method = 'both'
c.hints.uppercase = True
c.input.insert_mode.auto_load = True
c.input.insert_mode.auto_enter = True
c.tabs.favicons.scale = 2.0
c.tabs.padding = {'bottom': 15, 'left': 3, 'right': 3, 'top': 15}
c.tabs.position = 'left'
c.tabs.show = 'multiple'
c.tabs.width = 55
c.url.searchengines = {'DEFAULT': 'https://www.google.com.ar/search?q={}', 'g': 'https://duckduckgo.com/?q={}'}
c.url.start_pages = 'google.com'
c.colors.hints.fg = 'black'
c.colors.webpage.darkmode.enabled = False
c.fonts.default_family = 'Fira-Code'
c.fonts.hints = 'bold default_size default_family'

# Bindings for normal mode
config.bind('<Ctrl+Shift+l>', 'spawn --userscript qute-bitwarden')
config.bind('X', 'undo')
config.bind('d', 'scroll-page 0 0.5')
config.bind('gx', 'close')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('x', 'tab-close')
config.bind('T', 'set-cmd-text -s :tab-select')
# Bindings for insert mode
config.bind('<Ctrl+Shift+l>', 'spawn --userscript qute-bitwarden', mode='insert')