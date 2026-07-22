-- lua/plugins/bufdelete.lua
-- This plugins is used to avoid the problem with neo-tree. Closing a buffer directly
-- is not clean, so neo-tree expands in full-width.
-- this remove the buffer, but replace the buffer with another one opened.
return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete", "Bwipeout" },
}
