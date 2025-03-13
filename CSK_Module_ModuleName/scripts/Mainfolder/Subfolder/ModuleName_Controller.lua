---@diagnostic disable: undefined-global, redundant-parameter, missing-parameter

--***************************************************************
-- Inside of this script, you will find the necessary functions,
-- variables and events to communicate with the ModuleName_Model
--***************************************************************

--**************************************************************************
--************************ Start Global Scope ******************************
--**************************************************************************
local nameOfModule = 'CSK_ModuleName'

-- Timer to update UI via events after page was loaded
local tmrModuleName = Timer.create()
tmrModuleName:setExpirationTime(300)
tmrModuleName:setPeriodic(false)

-- Reference to global handle
local moduleName_Model

-- ************************ UI Events Start ********************************

-- Script.serveEvent("CSK_ModuleName.OnNewEvent", "ModuleName_OnNewEvent")

Script.serveEvent('CSK_ModuleName.OnNewResult', 'ModuleName_OnNewResult')

Script.serveEvent('CSK_ModuleName.OnNewStatusModuleVersion', 'ModuleName_OnNewStatusModuleVersion')
Script.serveEvent('CSK_ModuleName.OnNewStatusCSKStyle', 'ModuleName_OnNewStatusCSKStyle')
Script.serveEvent('CSK_ModuleName.OnNewStatusModuleIsActive', 'ModuleName_OnNewStatusModuleIsActive')

Script.serveEvent('CSK_ModuleName.OnNewStatusEventToRegister', 'ModuleName_OnNewStatusEventToRegister')

Script.serveEvent('CSK_ModuleName.OnNewStatusFlowConfigPriority', 'ModuleName_OnNewStatusFlowConfigPriority')
Script.serveEvent("CSK_ModuleName.OnNewStatusLoadParameterOnReboot", "ModuleName_OnNewStatusLoadParameterOnReboot")
Script.serveEvent("CSK_ModuleName.OnPersistentDataModuleAvailable", "ModuleName_OnPersistentDataModuleAvailable")
Script.serveEvent("CSK_ModuleName.OnNewParameterName", "ModuleName_OnNewParameterName")
Script.serveEvent("CSK_ModuleName.OnDataLoadedOnReboot", "ModuleName_OnDataLoadedOnReboot")

Script.serveEvent('CSK_ModuleName.OnUserLevelOperatorActive', 'ModuleName_OnUserLevelOperatorActive')
Script.serveEvent('CSK_ModuleName.OnUserLevelMaintenanceActive', 'ModuleName_OnUserLevelMaintenanceActive')
Script.serveEvent('CSK_ModuleName.OnUserLevelServiceActive', 'ModuleName_OnUserLevelServiceActive')
Script.serveEvent('CSK_ModuleName.OnUserLevelAdminActive', 'ModuleName_OnUserLevelAdminActive')

-- ...

-- ************************ UI Events End **********************************

--[[
--- Some internal code docu for local used function
local function functionName()
  -- Do something

end
]]

--**************************************************************************
--********************** End Global Scope **********************************
--**************************************************************************
--**********************Start Function Scope *******************************
--**************************************************************************

-- Functions to forward logged in user roles via CSK_UserManagement module (if available)
-- ***********************************************
--- Function to react on status change of Operator user level
---@param status boolean Status if Operator level is active
local function handleOnUserLevelOperatorActive(status)
  Script.notifyEvent("ModuleName_OnUserLevelOperatorActive", status)
end

--- Function to react on status change of Maintenance user level
---@param status boolean Status if Maintenance level is active
local function handleOnUserLevelMaintenanceActive(status)
  Script.notifyEvent("ModuleName_OnUserLevelMaintenanceActive", status)
end

--- Function to react on status change of Service user level
---@param status boolean Status if Service level is active
local function handleOnUserLevelServiceActive(status)
  Script.notifyEvent("ModuleName_OnUserLevelServiceActive", status)
end

--- Function to react on status change of Admin user level
---@param status boolean Status if Admin level is active
local function handleOnUserLevelAdminActive(status)
  Script.notifyEvent("ModuleName_OnUserLevelAdminActive", status)
end

--- Function to get access to the moduleName_Model object
---@param handle handle Handle of moduleName_Model object
local function setModuleName_Model_Handle(handle)
  moduleName_Model = handle
  if moduleName_Model.userManagementModuleAvailable then
    -- Register on events of CSK_UserManagement module if available
    Script.register('CSK_UserManagement.OnUserLevelOperatorActive', handleOnUserLevelOperatorActive)
    Script.register('CSK_UserManagement.OnUserLevelMaintenanceActive', handleOnUserLevelMaintenanceActive)
    Script.register('CSK_UserManagement.OnUserLevelServiceActive', handleOnUserLevelServiceActive)
    Script.register('CSK_UserManagement.OnUserLevelAdminActive', handleOnUserLevelAdminActive)
  end
  Script.releaseObject(handle)
end

--- Function to update user levels
local function updateUserLevel()
  if moduleName_Model.userManagementModuleAvailable then
    -- Trigger CSK_UserManagement module to provide events regarding user role
    CSK_UserManagement.pageCalled()
  else
    -- If CSK_UserManagement is not active, show everything
    Script.notifyEvent("ModuleName_OnUserLevelAdminActive", true)
    Script.notifyEvent("ModuleName_OnUserLevelMaintenanceActive", true)
    Script.notifyEvent("ModuleName_OnUserLevelServiceActive", true)
    Script.notifyEvent("ModuleName_OnUserLevelOperatorActive", true)
  end
end

--- Function to send all relevant values to UI on resume
local function handleOnExpiredTmrModuleName()

  updateUserLevel()

  Script.notifyEvent("ModuleName_OnNewStatusModuleVersion", 'v' .. moduleName_Model.version)
  Script.notifyEvent("ModuleName_OnNewStatusCSKStyle", moduleName_Model.styleForUI)
  Script.notifyEvent("ModuleName_OnNewStatusModuleIsActive", _G.availableAPIs.default and _G.availableAPIs.specific)
  
  if _G.availableAPIs.default and _G.availableAPIs.specific then

	Script.notifyEvent("ModuleName_OnNewStatusEventToRegister", moduleName_Model.parameters.registerEvent)

	-- Script.notifyEvent("ModuleName_OnNewEvent", false)

	Script.notifyEvent("ModuleName_OnNewStatusFlowConfigPriority", moduleName_Model.parameters.flowConfigPriority)
	Script.notifyEvent("ModuleName_OnNewStatusLoadParameterOnReboot", moduleName_Model.parameterLoadOnReboot)
	Script.notifyEvent("ModuleName_OnPersistentDataModuleAvailable", moduleName_Model.persistentModuleAvailable)
	Script.notifyEvent("ModuleName_OnNewParameterName", moduleName_Model.parametersName)
	-- ...
  end
end
Timer.register(tmrModuleName, "OnExpired", handleOnExpiredTmrModuleName)

-- ********************* UI Setting / Submit Functions Start ********************

local function pageCalled()
  if _G.availableAPIs.default and _G.availableAPIs.specific then
    updateUserLevel() -- try to hide user specific content asap
  end
  tmrModuleName:start()
  return ''
end
Script.serveFunction("CSK_ModuleName.pageCalled", pageCalled)

--[[
local function setSomething(value)
  _G.logger:fine(nameOfModule .. ": Set new value = " .. value)
  moduleName_Model.varA = value
end
Script.serveFunction("CSK_ModuleName.setSomething", setSomething)
]]

local function setEventToRegister(event)
  moduleName_Model.registerToEvent(event)
end
Script.serveFunction('CSK_ModuleName.setEventToRegister', setEventToRegister)

local function getStatusModuleActive()
  return _G.availableAPIs.default and _G.availableAPIs.specific
end
Script.serveFunction('CSK_ModuleName.getStatusModuleActive', getStatusModuleActive)

local function clearFlowConfigRelevantConfiguration()
  -- Insert code here to clear FlowConfig relevant actions
  moduleName_Model.deregisterFromEvent()
end
Script.serveFunction('CSK_ModuleName.clearFlowConfigRelevantConfiguration', clearFlowConfigRelevantConfiguration)

local function getParameters()
  return moduleName_Model.helperFuncs.json.encode(moduleName_Model.parameters)
end
Script.serveFunction('CSK_ModuleName.getParameters', getParameters)

-- *****************************************************************
-- Following function can be adapted for CSK_PersistentData module usage
-- *****************************************************************

local function setParameterName(name)
  _G.logger:fine(nameOfModule .. ": Set parameter name: " .. tostring(name))
  moduleName_Model.parametersName = name
end
Script.serveFunction("CSK_ModuleName.setParameterName", setParameterName)

local function sendParameters(noDataSave)
  if moduleName_Model.persistentModuleAvailable then
    CSK_PersistentData.addParameter(moduleName_Model.helperFuncs.convertTable2Container(moduleName_Model.parameters), moduleName_Model.parametersName)
    CSK_PersistentData.setModuleParameterName(nameOfModule, moduleName_Model.parametersName, moduleName_Model.parameterLoadOnReboot)
    _G.logger:fine(nameOfModule .. ": Send ModuleName parameters with name '" .. moduleName_Model.parametersName .. "' to CSK_PersistentData module.")
    if not noDataSave then
      CSK_PersistentData.saveData()
    end
  else
    _G.logger:warning(nameOfModule .. ": CSK_PersistentData module not available.")
  end
end
Script.serveFunction("CSK_ModuleName.sendParameters", sendParameters)

local function loadParameters()
  if moduleName_Model.persistentModuleAvailable then
    local data = CSK_PersistentData.getParameter(moduleName_Model.parametersName)
    if data then
      clearFlowConfigRelevantConfiguration()
      _G.logger:info(nameOfModule .. ": Loaded parameters from CSK_PersistentData module.")
      moduleName_Model.parameters = moduleName_Model.helperFuncs.convertContainer2Table(data)
      -- If something needs to be configured/activated with new loaded data, place this here:
      -- ...
      -- ...

      CSK_ModuleName.pageCalled()
      return true
    else
      _G.logger:warning(nameOfModule .. ": Loading parameters from CSK_PersistentData module did not work.")
      return false
    end
  else
    _G.logger:warning(nameOfModule .. ": CSK_PersistentData module not available.")
    return false
  end
end
Script.serveFunction("CSK_ModuleName.loadParameters", loadParameters)

local function setLoadOnReboot(status)
  moduleName_Model.parameterLoadOnReboot = status
  _G.logger:fine(nameOfModule .. ": Set new status to load setting on reboot: " .. tostring(status))
  Script.notifyEvent("ModuleName_OnNewStatusLoadParameterOnReboot", status)
end
Script.serveFunction("CSK_ModuleName.setLoadOnReboot", setLoadOnReboot)

local function setFlowConfigPriority(status)
  moduleName_Model.parameters.flowConfigPriority = status
  _G.logger:fine(nameOfModule .. ": Set new status of FlowConfig priority: " .. tostring(status))
  Script.notifyEvent("ModuleName_OnNewStatusFlowConfigPriority", moduleName_Model.parameters.flowConfigPriority)
end
Script.serveFunction('CSK_ModuleName.setFlowConfigPriority', setFlowConfigPriority)

--- Function to react on initial load of persistent parameters
local function handleOnInitialDataLoaded()

  if _G.availableAPIs.default and _G.availableAPIs.specific then
    _G.logger:fine(nameOfModule .. ': Try to initially load parameter from CSK_PersistentData module.')

    if string.sub(CSK_PersistentData.getVersion(), 1, 1) == '1' then

      _G.logger:warning(nameOfModule .. ': CSK_PersistentData module is too old and will not work. Please update CSK_PersistentData module.')
      moduleName_Model.persistentModuleAvailable = false
    else

      local parameterName, loadOnReboot = CSK_PersistentData.getModuleParameterName(nameOfModule)

      if parameterName then
        moduleName_Model.parametersName = parameterName
        moduleName_Model.parameterLoadOnReboot = loadOnReboot
      end

      if moduleName_Model.parameterLoadOnReboot then
        loadParameters()
      end
      Script.notifyEvent('ModuleName_OnDataLoadedOnReboot')
    end
  end
end
Script.register("CSK_PersistentData.OnInitialDataLoaded", handleOnInitialDataLoaded)

local function resetModule()
  if _G.availableAPIs.default and _G.availableAPIs.specific then
    clearFlowConfigRelevantConfiguration()
    pageCalled()
  end
end
Script.serveFunction('CSK_ModuleName.resetModule', resetModule)
Script.register("CSK_PersistentData.OnResetAllModules", resetModule)

-- *************************************************
-- END of functions for CSK_PersistentData module usage
-- *************************************************

return setModuleName_Model_Handle

--**************************************************************************
--**********************End Function Scope *********************************
--**************************************************************************

