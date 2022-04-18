local PlugMan = {}

local GitPlugin = require("plugman.git_plugin")
local LocalPlugin = require("plugman.local_plugin")

-- return: PlugMan
function PlugMan:new()
  local self = setmetatable({}, { __index = PlugMan })
  self.plugins = {}
  return self
end

-- params: {name: String, url: String}
function PlugMan:add_git_plugin(name, url)
  self:add_plugin(GitPlugin:new(name, url))
end

-- params: {name: String, path: String}
function PlugMan:add_local_plugin(name, path)
  self:add_plugin(LocalPlugin:new(name, path))
end

-- params: {plugin: Plugin}
function PlugMan:add_plugin(plugin)
  table.insert(self.plugins, plugin)
end

function PlugMan:load_all()
  self:load_plugins(self.plugins)
end

-- params: {plugins: Table{Plugin}}
function PlugMan:load_plugins(plugins)
  for key, val in ipairs(plugins) do
    if (not(val:is_valid())) then
      val:install()
    end
    vim.api.nvim_set_option("runtimepath", vim.api.nvim_get_option("runtimepath")..","..val:get_directory())
    vim.api.nvim_set_var("plugin_"..val.name.."_path", val:get_directory())
  end

  for key,val in ipairs(plugins) do
    vim.api.nvim_set_option("runtimepath", vim.api.nvim_get_option("runtimepath")..","..val:get_directory().."/after")
  end
end

return PlugMan
