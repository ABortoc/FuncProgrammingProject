#!/bin/bash
#Build script

eval "dune build bin/getread.exe"
eval "dune build bin/addread.exe"
eval "dune build bin/removeread.exe"
eval "dune build bin/clearread.exe"
eval "dune build bin/createread.exe"
eval "dune build bin/dropread.exe"
eval "dune build bin/gettoread.exe"
eval "dune build bin/addtoread.exe"
eval "dune build bin/removetoread.exe"
eval "dune build bin/cleartoread.exe"
eval "dune build bin/createtoread.exe"
eval "dune build bin/droptoread.exe"