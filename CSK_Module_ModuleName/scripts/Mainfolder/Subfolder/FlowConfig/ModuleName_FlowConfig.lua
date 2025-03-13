-- Include all relevant FlowConfig scripts

--*****************************************************************
-- Here you will find all the required content to provide specific
-- features of this module via the 'CSK FlowConfig'.
--*****************************************************************

require('Mainfolder.Subfolder.FlowConfig.ModuleName_Consumer')
require('Mainfolder.Subfolder.FlowConfig.ModuleName_Provider')
require('Mainfolder.Subfolder.FlowConfig.ModuleName_Process')

--- Function to react if FlowConfig was updated
local function handleOnClearOldFlow()
  if _G.availableAPIs.default and _G.availableAPIs.specific then
    if moduleName_Model.parameters.flowConfigPriority then
      CSK_ModuleName.clearFlowConfigRelevantConfiguration()
    end
  end
end
Script.register('CSK_FlowConfig.OnClearOldFlow', handleOnClearOldFlow)