return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
    -- Debugger
    {
      '<leader>d',
      group = 'Debugger',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dt',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Continue',
      nowait = true,
      remap = false,
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
      nowait = true,
      remap = false,
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
      nowait = true,
      remap = false,
    },
    {
      '<leader>du',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Open REPL',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Run Last',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dq',
      function()
        require('dap').terminate()
        require('dapui').close()
        require('nvim-dap-virtual-text').toggle()
      end,
      desc = 'Terminate',
      nowait = true,
      remap = false,
    },
    {
      '<leader>db',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'List Breakpoints',
      nowait = true,
      remap = false,
    },
    {
      '<leader>de',
      function()
        require('dap').set_exception_breakpoints { 'all' }
      end,
      desc = 'Set Exception Breakpoints',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dd',
      function()
        require('dap-go').debug_test()
      end,
      desc = 'Debug closest test',
      nowait = true,
      remap = false,
    },
    {
      '<leader>dv',
      function()
        require('dapui').toggle()
      end,
      desc = 'Show debug view',
      nowait = true,
      remap = false,
    },
  },
}
