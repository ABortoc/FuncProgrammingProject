#!/bin/bash
#Move script

eval "mkdir executables"
eval "mv -i _build/default/bin/addread.exe executables/"
eval "mv -i _build/default/bin/clearread.exe executables/"
eval "mv -i _build/default/bin/getread.exe executables/"
eval "mv -i _build/default/bin/migrateread.exe executables/"
eval "mv -i _build/default/bin/removeread.exe executables/"
eval "mv -i _build/default/bin/rollbackread.exe executables/"
eval "mv -i _build/default/bin/addtoread.exe executables/"
eval "mv -i _build/default/bin/cleartoread.exe executables/"
eval "mv -i _build/default/bin/gettoread.exe executables/"
eval "mv -i _build/default/bin/migratetoread.exe executables/"
eval "mv -i _build/default/bin/removetoread.exe executables/"
eval "mv -i _build/default/bin/rollbacktoread.exe executables/"