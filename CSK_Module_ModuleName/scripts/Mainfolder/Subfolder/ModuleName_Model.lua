---@diagnostic disable: undefined-global, redundant-parameter, missing-parameter
--*****************************************************************
-- Inside of this script, you will find the module definition
-- including its parameters and functions
--*****************************************************************

--**************************************************************************
--**********************Start Global Scope *********************************
--**************************************************************************
local nameOfModule = 'CSK_ModuleName'

local moduleName_Model = {}

-- Check if CSK_UserManagement module can be used if wanted
moduleName_Model.userManagementModuleAvailable = CSK_UserManagement ~= nil or false

-- Check if CSK_PersistentData module can be used if wanted
moduleName_Model.persistentModuleAvailable = CSK_PersistentData ~= nil or false

-- Default values for persistent data
-- If available, following values will be updated from data of CSK_PersistentData module (check CSK_PersistentData module for this)
moduleName_Model.parametersName = 'CSK_ModuleName_Parameter' -- name of parameter dataset to be used for this module
moduleName_Model.parameterLoadOnReboot = false -- Status if parameter dataset should be loaded on app/device reboot

-- Load script to communicate with the ModuleName_Model interface and give access
-- to the ModuleName_Model object.
-- Check / edit this script to see/edit functions which communicate with the UI
local setModuleName_ModelHandle = require('Mainfolder/Subfolder/ModuleName_Controller')
setModuleName_ModelHandle(moduleName_Model)

--Loading helper functions if needed
moduleName_Model.helperFuncs = require('Mainfolder/Subfolder/helper/funcs')

-- Optionally check if specific API was loaded via
--[[
if _G.availableAPIs.specific then
-- ... doSomething ...
end
]]


-- Create parameters / instances for this module
moduleName_Model.styleForUI = 'None' -- Optional parameter to set UI style
moduleName_Model.version = Engine.getCurrentAppVersion() -- Version of module
--[[
moduleName_Model.object = Image.create() -- Use any AppEngine CROWN
moduleName_Model.counter = 1 -- Short docu of variable
moduleName_Model.varA = 'value' -- Short docu of variable
--...
]]

-- Parameters to be saved permanently if wanted
moduleName_Model.parameters = {}
moduleName_Model.parameters.flowConfigPriority = CSK_FlowConfig ~= nil or false -- Status if FlowConfig should have priority for FlowConfig relevant configurations
moduleName_Model.parameters.registerEvent = '' -- Event to get data
--moduleName_Model.parameters.paramA = 'paramA' -- Short docu of variable
--moduleName_Model.parameters.paramB = 123 -- Short docu of variable
--...

--**************************************************************************
--********************** End Global Scope **********************************
--**************************************************************************
--**********************Start Function Scope *******************************
--**************************************************************************

--- Function to react on UI style change
local function handleOnStyleChanged(theme)
  moduleName_Model.styleForUI = theme
  Script.notifyEvent("ModuleName_OnNewStatusCSKStyle", moduleName_Model.styleForUI)
end
Script.register('CSK_PersistentData.OnNewStatusCSKStyle', handleOnStyleChanged)

local function processData(data)
  _G.logger:fine(nameOfModule .. ": Process data...")

  -- Process data...
  -- ...

  Script.notifyEvent('ModuleName_OnNewResult', data)
end
moduleName_Model.processData = processData

local function registerToEvent(event)
  if moduleName_Model.parameters.registerEvent then
    Script.deregister(moduleName_Model.parameters.registerEvent, processData)
  end
  moduleName_Model.parameters.registerEvent = event
  Script.register(event, processData)
end
moduleName_Model.registerToEvent = registerToEvent

local function deregisterFromEvent()
  if moduleName_Model.parameters.registerEvent ~= '' then
    Script.deregister(moduleName_Model.parameters.registerEvent, processData)
    moduleName_Model.parameters.registerEvent = ''
    Script.notifyEvent("ModuleName_OnNewStatusEventToRegister", moduleName_Model.parameters.registerEvent)
  end
end
moduleName_Model.deregisterFromEvent = deregisterFromEvent

--[[
-- Some internal code docu for local used function to do something
---@param content auto Some info text if function is not already served
local function doSomething(content)
  _G.logger:fine(nameOfModule .. ": Do something")
  moduleName_Model.counter = moduleName_Model.counter + 1
end
moduleName_Model.doSomething = doSomething
]]

--*************************************************************************
--********************** End Function Scope *******************************
--*************************************************************************

return moduleName_Model
