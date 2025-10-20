return {
  'saghen/blink.cmp',
  opts = {
    keymap = {
      preset = 'enter',
    },
    fuzzy = { implementation = 'lua' },
    completion = {
      documentation = {
        auto_show = true,
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = {
      enabled = true,
    },
  },
}
