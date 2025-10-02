-- 平台检测
local is_mac = vim.fn.has('macunix') == 1
local is_linux = vim.fn.has('unix') == 1 and vim.fn.has('macunix') == 0

local opts = {
    noremap = true,
    silent = true,
}

-- 设置 leader 键
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-----------------
-- 通用配置（所有平台）--
-----------------

-- 核心窗口导航（Leader 方案 - 最可靠）
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = '向左移动窗口' })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = '向下移动窗口' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = '向上移动窗口' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = '向右移动窗口' })

-- 窗口操作
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = '垂直分割' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = '水平分割' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = '等分窗口' })
vim.keymap.set('n', '<leader>sx', '<C-w>c', { desc = '关闭窗口' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = '关闭其他窗口' })

-- 窗口调整大小（数字键盘风格）
vim.keymap.set('n', '<leader><Up>', ':resize +5<CR>', { desc = '增加窗口高度' })
vim.keymap.set('n', '<leader><Down>', ':resize -5<CR>', { desc = '减少窗口高度' })
vim.keymap.set('n', '<leader><Right>', ':vertical resize +5<CR>', { desc = '增加窗口宽度' })
vim.keymap.set('n', '<leader><Left>', ':vertical resize -5<CR>', { desc = '减少窗口宽度' })

-----------------
-- 平台增强配置 --
-----------------

-- Control 键映射（在 Linux 和部分 macOS 终端工作）
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- 尝试 Option/Alt 键（macOS）
if is_mac then
    vim.keymap.set('n', '<M-h>', '<C-w>h', { desc = '向左移动窗口 (Option+h)' })
    vim.keymap.set('n', '<M-j>', '<C-w>j', { desc = '向下移动窗口 (Option+j)' })
    vim.keymap.set('n', '<M-k>', '<C-w>k', { desc = '向上移动窗口 (Option+k)' })
    vim.keymap.set('n', '<M-l>', '<C-w>l', { desc = '向右移动窗口 (Option+l)' })
end

-- 方向键调整大小（如果终端支持）
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- 其他通用快捷键 --
-----------------

-- 标签页操作
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = '新建标签页' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = '关闭标签页' })
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = '下一个标签页' })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = '上一个标签页' })

-- 快速保存退出
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '保存文件' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '退出' })
vim.keymap.set('n', '<leader>x', ':x<CR>', { desc = '保存并退出' })

-----------------
-- Visual mode (保持你的配置) --
-----------------

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- 可选：调试信息
if is_mac then
    print("🖥️  macOS 键位配置已加载")
elseif is_linux then
    print("🐧 Linux 键位配置已加载")
else
    print("🔧 通用键位配置已加载")
end

