# read binary file
file spike32_main

# set logging options
set logging enabled off
set logging file gdb_multicore.log
set logging overwrite on
# set logging enabled on

# set gdb to show packets and serial data
set debug remote 1
#set debug serial 1

set remotetimeout 20

target remote localhost:3333
#load
#compare-sections
#b main
#c
#delete 1
#watch counter == 5
#c
#p/x counter
#c
#b _exit
#c
#monitor r
#load
#break main
#continue
#n
#quit