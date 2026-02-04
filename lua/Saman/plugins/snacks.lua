return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        styles = {
            input = {
               keys = {
                    n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                    i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                },
            },
        },

        input = { enabled = true },

        quickfile = {
            enabled = true,
            exclude = { "latex" },
        },

        picker = {
            enabled = true,
            matchers = { frecency = true, cwd_bonus = false },
            exclude = { ".git", "node_modules", "dist", "build" },

            formatters = {
                file = {
                    filename_first = true,
                    filename_only = false,
                    icon_width = 2,
                },
            },

            layout = {
                preset = "telescope",
                cycle = false,
            },

            layouts = {
                select = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        width = 0.6,
                        height = 0.4,
                        min_width = 80,
                        min_height = 10,
                        border = "rounded",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                    },
                },

                telescope = {
                    reverse = true,
                    layout = {
                        box = "horizontal",
                        backdrop = false,
                        width = 0.8,
                        height = 0.9,
                        border = "none",
                        {
                            box = "vertical",
                            { win = "list", title = "Results", title_pos = "center", border = "rounded" },
                            { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                        },
                        {
                            win = "preview",
                            title = "{preview:Preview}",
                            width = 0.50,
                            border = "rounded",
                            title_pos = "center",
                        },
                    },
                },

                ivy = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        width = 0,
                        height = 0.4,
                        position = "bottom",
                        border = "top",
                        title = "{title} {live} {flags}",
                        title_pos = "left",
                        { win = "input", height = 1, border = "bottom" },
                        {
                            box = "horizontal",
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                        },
                    },
                },
            },
        },

        image = {
            enabled = function()
                return vim.bo.filetype == "markdown"
            end,
            doc = {
                float = false,
                inline = false,
                max_width = 50,
                max_height = 30,
                wo = { wrap = false },
            },
            convert = { notify = true, command = "magick" },
            img_dirs = {
                "img", "images", "assets", "static", "public", "media", "attachments",
                vim.fn.expand("~/Library"),
                vim.fn.expand("~/Downloads"),
            },
        },

        dashboard = {
            enabled = true,
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { section = "startup" },
                {
                    section = "terminal",
                    cmd = "ascii-image-converter ~/Desktop/Others/profiles.JPG -C -c",
                    random = 15,
                    pane = 2,
                    indent = 15,
                    height = 20,
                },
            },
        },
    },

    keys = {
        { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
        { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
        { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Rename File" },
        { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },

        { "<leader>pf", function() require("snacks").picker.files() end, desc = "Find Files" },
        { "<leader>pc", function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, desc = "Find Config" },
        { "<leader>ps", function() require("snacks").picker.grep() end, desc = "Grep" },
        { "<leader>pws", function() require("snacks").picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },
        { "<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "Keymaps" },

        { "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "Git Branches" },

        { "<leader>th", function() require("snacks").picker.colorschemes({ layout = "ivy" }) end, desc = "Themes" },
        { "<leader>vh", function() require("snacks").picker.help() end, desc = "Help" },
    },
}

