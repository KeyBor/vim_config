require('Comment').setup({
  padding = true,        -- 在注释上方添加空格
  sticky = true,         -- 光标停留在注释位置
  ignore = nil,          -- 忽略某些行

  toggler = {
    line = 'gcc',        -- 行注释切换
    block = 'gbc',       -- 块注释切换
  },

  opleader = {
    line = 'gc',         -- 可视模式行注释
    block = 'gb',        -- 可视模式块注释
  },

  extra = {
    above = 'gcO',       -- 在当前行上方添加注释
    below = 'gco',       -- 在当前行下方添加注释
    eol = 'gcA',         -- 在行尾添加注释
  },

  mappings = {
    basic = true,        -- 启用基础映射
    extra = true,        -- 启用额外映射
  },
})

