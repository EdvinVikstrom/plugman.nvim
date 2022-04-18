local Plugin = {}

-- return: Plugin
function Plugin:inherit()
  local self = setmetatable({}, { __index = Plugin })
  return self
end

-- params: {name: String}
-- return: Plugin
function Plugin:new(name)
  local self = setmetatable({}, { __index = Plugin })
  self.name = name
  return self
end

-- return: Boolean
function Plugin:is_valid()
end

-- return: String
function Plugin:get_directory()
end

function Plugin:install()
end

function Plugin:update()
end

return Plugin
