local M = {}

function M.send(text)
    local uri =  "http://localhost:5000/set"

    local res = vim.fn.system({
        "curl", "-s", "-X", "POST", "--data-binary", text, uri
    })
end

return M
