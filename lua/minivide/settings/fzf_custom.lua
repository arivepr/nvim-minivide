local fzf = require("fzf-lua")

local M = {}

-- Your Opinionated UI Defaults
-- You can deeply customize the floating window, borders, and behavior here
M.ui_prefs = {
    winopts = {
        height     = 0.85,
        width      = 0.80,
        row        = 0.35,
        preview = {
            layout = "vertical",
            vertical = "down:45%",
        },
    },
}

-- Custom Picker: Project Search
function M.project_files()
    fzf.files({
        prompt = "Minivide Files> ",
        winopts = M.ui_prefs.winopts,
    })
end

-- Custom Picker: Live Grep (Opinionated Search)
function M.live_grep()
    fzf.live_grep({
        prompt = "Minivide Search> ",
        winopts = M.ui_prefs.winopts,
    })
end

return M
