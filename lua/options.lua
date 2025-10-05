-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a' -- allow the mouse to be used in nvim

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of Python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enable 24-bit RGB color in the TUI
vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- 自动检测并设置 Linux 和 macOS 的剪切板工具
local function setup_clipboard()
  -- 首先设置基本的 clipboard 选项
  vim.opt.clipboard = "unnamedplus"  -- Linux
  -- vim.opt.clipboard = "unnamed"   -- macOS (如果需要的话)
  
  -- 检测 macOS
  if vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1 then
    if vim.fn.executable('pbcopy') == 1 then
      vim.g.clipboard = {
        name = 'macos-pbpaste',
        copy = {
          ['+'] = 'pbcopy',
          ['*'] = 'pbcopy',
        },
        paste = {
          ['+'] = 'pbpaste',
          ['*'] = 'pbpaste',
        },
        cache_enabled = 1,
      }
      print("Clipboard: Using macOS pbcopy/pbpaste")
    end
  
  -- 检测 Linux
  elseif vim.fn.has('unix') == 1 then
    -- 首先检测 Wayland
    if os.getenv('WAYLAND_DISPLAY') and vim.fn.executable('wl-copy') == 1 and vim.fn.executable('wl-paste') == 1 then
      vim.g.clipboard = {
        name = 'wayland',
        copy = {
          ['+'] = 'wl-copy --type text/plain',
          ['*'] = 'wl-copy --type text/plain --primary',
        },
        paste = {
          ['+'] = 'wl-paste --no-newline',
          ['*'] = 'wl-paste --no-newline --primary',
        },
        cache_enabled = 1,
      }
      print("Clipboard: Using Wayland wl-copy/wl-paste")
    
    -- 检测 X11 系统 (xclip)
    elseif vim.fn.executable('xclip') == 1 then
      vim.g.clipboard = {
        name = 'xclip',
        copy = {
          ['+'] = 'xclip -selection clipboard',
          ['*'] = 'xclip -selection primary',
        },
        paste = {
          ['+'] = 'xclip -selection clipboard -o',
          ['*'] = 'xclip -selection primary -o',
        },
        cache_enabled = 1,
      }
      print("Clipboard: Using xclip")
    
    -- 检测 X11 系统 (xsel)
    elseif vim.fn.executable('xsel') == 1 then
      vim.g.clipboard = {
        name = 'xsel',
        copy = {
          ['+'] = 'xsel --clipboard --input',
          ['*'] = 'xsel --primary --input',
        },
        paste = {
          ['+'] = 'xsel --clipboard --output',
          ['*'] = 'xsel --primary --output',
        },
        cache_enabled = 1,
      }
      print("Clipboard: Using xsel")
    else
      print("Clipboard: No clipboard tool found. Please install xclip, xsel, or wl-clipboard")
    end
  end
end

-- 调用设置函数
setup_clipboard()
-- 智能键位映射 (自动适应不同系统)
local function setup_keymaps()
  local is_mac = vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1
  
  if is_mac then
    -- macOS 风格的键位映射
    -- Command+C 复制 (在 macOS 终端中通常映射为 ⌘+C)
    vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, desc = "Copy (Cmd+C)" })
    vim.keymap.set('v', '<D-x>', '"+x', { noremap = true, desc = "Cut (Cmd+X)" })
    vim.keymap.set({'n', 'i'}, '<D-v>', '"+p', { noremap = true, desc = "Paste (Cmd+V)" })
  else
    -- Linux 风格的键位映射
    vim.keymap.set('i', '<A-v>', '<C-r>+', { noremap = true, desc = "Paste from clipboard" })
    vim.keymap.set('n', '<A-v>', '"+p', { noremap = true, desc = "Paste from clipboard" })
  end
  
  -- 跨平台的通用映射 (两个系统都适用)
  vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = "Copy to clipboard" })
  vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = "Paste from clipboard" })
  vim.keymap.set({'n', 'v'}, '<leader>Y', '"+Y', { desc = "Copy line to clipboard" })
end

setup_keymaps()
