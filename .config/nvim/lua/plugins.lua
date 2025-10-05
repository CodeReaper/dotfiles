local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

    require 'plugin.conform',
    require 'plugin.which',
    require 'plugin.telescope',
    require 'plugin.mason',
    require 'plugin.sleuth',
    require 'plugin.slides',
    require 'plugin.mini',

})
