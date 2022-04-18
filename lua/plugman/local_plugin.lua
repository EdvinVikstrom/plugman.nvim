local Plugin = require("plugman.plugin")
local LocalPlugin = Plugin:inherit()

-- params: {name: String, path: String}
-- return: LocalPlugin
function LocalPlugin:new(name, path)
  local self = setmetatable({}, { __index = LocalPlugin })
  self.name = name
  self.path = path
  return self
end

-- return: Boolean
function Plugin:is_valid()
  return vim.fn.isdirectory(self.path)
end

-- return: String
function Plugin:get_directory()
  return self.path
end

function Plugin:install()
end

function Plugin:update()
end

return LocalPlugin
