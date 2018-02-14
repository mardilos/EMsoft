## About the EMsoft/src folder ##
The files in this folder contain all the f90 modules needed by the EMsoft package.  They are compiled first and the object files are collected together in the *libEMSoftLib.dylib* dynamic library file in the Debug compilation mode.  In Release 3.0, several of these modules are actually not used in any of the main programs; this is true in particular for any of the defect files (apb, defectmodule, dislocation, foilmodule, inclusion, stacking_fault, and void).  These routines will be used starting in Release 3.1, and they will very likely be modified by then, so it would be wise not to rely on them for any code that you may develop.  All other code in this folder is used in the EBSD, ECP, and Kossel pattern simulation programs.