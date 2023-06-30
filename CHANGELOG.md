# Changelog
All notable changes to this project will be documented in this file.

## Release 3.6.0

### Improvements
- Using recursive helper functions to convert Container <-> Lua table

## Release 3.5.0

### Improvements
- Update to EmmyLua annotations
- Usage of lua diagnostics
- Documentation updates

## Release 3.4.0

### Improvements
- Using internal moduleName variable to be usable in merged apps instead of _APPNAME, as this did not work with PersistentData module in merged apps.

## Release 3.3.1

### Improvements
- Naming of UI elements and adding some mouse over info texts
- Appname added to log messages
- Minor edits

### Bugfix
- UI events notified after pageLoad after 300ms instead of 100ms to not miss

## Release 3.3.0

### Improvements
- Per default use 'LuaLoadAllEngineAPI = true' to make it easier to start
- Update of helper funcs
- Hiding  SOPAS Login
- Added convertToList in converter.ts
- Minor code edits / docu updates

## Release 3.2.1

### Bugfix
- checkAPIs script was not loaded in Model and minor edit in sample code

## Release 3.2.0

### Improvements
- Loading only required APIs ('LuaLoadAllEngineAPI = false') -> less time for GC needed
- Changed status type of user levels from string to bool (usable with CSK_Module_UserManagement since version 1.2.1)
- Renamed page folder accordingly to module name

## Release 3.1.0

### New features
- Integration of CSK_UserManagement functionality

## Release 3.0.0

### New features
- Update handling of persistent data according to CSK_PersistentData module ver. 2.0.0

## Release 2.2.0

### Improvements
- Setup of Parameter name (PersistentData) added to UI
- Support of 2-dim tables within parameters to save in PersistentData CSK module

## Release 2.1.0

### New feature
- Added "OnDataLoadedOnReboot" event

### Improvement

- PersistentData functions moved to _Controller.lua to be consistent to MultiInstanceTemplate
- Added more manifest documentation and created html based on this

## Release 2.0.1

### Improvement
- New function to load/save parameters with SubContainer

## Release 2.0.0

### Improvements
- Added StepByStep instruction how to customize the template (see README.md)
- By using the StepByStep instruction it becomes much more easier to customize the template
- CSK_PersistentData module usage directly implemented incl. UI (PersistendData module needs to provide according parameters...)
- Renamed files/variables from "Helper/Interface" to "Model/Controller" (MVC)

## Release 1.2.0

### Improvements
- Optionally store to load parameters at app restart
- Using unique local event names

## Release 1.1.0

### Improvements
- Providing function to work with PersistentData module to load/save module parameters

## Release 1.0.0
- Initial commit