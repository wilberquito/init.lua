vim.opt.termguicolors = true

require('bufferline').setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none" or "ordinal" or "buffer_id" or "both",
        close_command = "bdelete! %d", -- can be a string or function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string or function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string or function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string or function, see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'underline' or 'icon' or 'underline' or 'none',
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf) -- buf contains:
            -- name                or str        or the basename of the active file
            -- path                or str        or the full path of the active file
            -- bufnr (buffer only) or int        or the number of the active buffer
            -- buffers (tabs only) or table(int) or the numbers of the buffers in the tab
            -- tabnr (tabs only)   or int        or the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        end,
        max_name_length = 15,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = false or "nvim_lsp" or "coc",
        diagnostics_update_in_insert = false,
        -- the diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- local icon = level:match("error") and " " or " "
            -- return " " .. icon .. count
            return " "
        end,
        -- note: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
            -- filter out filetypes you don't want to see
            if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                return true
            end
            -- filter out by buffer name
            if vim.fn.bufname(buf_number) ~= "<buffer-name-i-dont-want>" then
                return true
            end
            -- filter out based on arbitrary rules
            -- e.g. filter out vim wiki buffer from tabline in your work repo
            if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                return true
            end
            -- filter out by it's index number in list (don't show first buffer)
            if buf_numbers[1] ~= buf_number then
                return true
            end
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left" or "center" or "right",
                highlight = "Directory",
                separator = true
            }
        },
        color_icons = true or false, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true or false, -- disable filetype icons for buffers
        show_buffer_close_icons = true or false,
        show_buffer_default_icon = true or false, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon = true or false,
        show_tab_indicators = false,
        show_duplicate_prefix = true or false, -- whether to show duplicate buffer prefix
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { 'or', 'or' }
        separator_style = "thick" or 'thin' or "slant" or "thick" or { 'any', 'any' },
        enforce_regular_tabs = false or true,
        always_show_bufferline = true or false,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
        },
        sort_by = 'insert_after_current' or 'insert_at_end' or 'id' or 'extension' or 'relative_directory' or 'directory'
            or
            'tabs' or function(buffer_a, buffer_b)
                -- add custom logic
                return buffer_a.modified > buffer_b.modified
            end
    }
}
