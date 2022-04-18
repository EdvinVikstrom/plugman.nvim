local Plugin = require("plugman.plugin")
local GitPlugin = Plugin:inherit()

-- params: {name: String, url: String}
-- return: GitPlugin
function GitPlugin:new(name, url)
  local self = setmetatable(Plugin:new(name), { __index = GitPlugin })
  self.url = url
  return self
end

-- return: Boolean
function GitPlugin:is_valid()
  return vim.fn.isdirectory(self:get_directory()) == 1
end

-- return: String
function GitPlugin:get_directory()
  return _G.plugin_directory.."/"..self.name
end

function GitPlugin:install()
  vim.fn.system("git clone "..self.url.." ".._G.plugin_directory.."/"..self.name)
end

function GitPlugin:update()
  vim.fn.system("cd "..self:get_directory().." | git fetch | git pull")
end

return GitPlugin
