local wk = require("which-key")

wk.setup()
wk.register({
  ["]"] = { name = "+next" },
  ["["] = { name = "+previous" },
  ["g"] = { name = "+goto" },
  ["<leader>h"] = { name = "+git hunk" },
  ["<leader>s"] = { name = "+search" },
  ["<leader>q"] = { name = "+quit" }
})
