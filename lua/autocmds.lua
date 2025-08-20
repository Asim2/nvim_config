-- autocmds.lua (Auto Commands)

-- Automatically trims trailing whitespace on save for Python files.
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        local save_cursor = vim.fn.getpos(".")  -- Save cursor position
        vim.cmd([[ %s/\s\+$//e ]])  -- Trim trailing whitespace
        vim.fn.setpos(".", save_cursor)  -- Restore cursor position
    end,
})

--[[
    -- Change directory to the current file's directory on buffer enter
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        command = "lcd %:p:h"  -- Change directory to the current file's directory on buffer enter
    })
]]


-- Auto-switch between relative and absolute line numbers
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    pattern = "*",
    callback = function()
        if vim.opt.number:get() then
            vim.opt.relativenumber = false  -- Disable relative numbers in insert mode & unfocused windows
        end
    end,
})
