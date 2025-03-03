# read binary file
file spike64_2_multicore

# set logging options
set logging enabled off
set logging file gdb_multicore.log
set logging overwrite on
# set logging enabled on

# set gdb to show packets and serial data
#set debug remote 1
#set debug serial 1

set remotetimeout 20

target remote localhost:3333
info threads
thread 2
thread 1
load
compare-sections
p/x $pc=_start
thread 2
p/x $pc=_start
b set_trap_handler
c
#monitor r
#load
#break main
#continue
#n
#quit