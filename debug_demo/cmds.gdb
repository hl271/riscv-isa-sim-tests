# read binary file
file rot13-32

# set logging options
set logging enabled off
set logging file gdb.log
set logging overwrite on
set logging enabled on

# set gdb to show packets and serial data
#set debug remote 1
#set debug serial 1

target remote localhost:3333
#monitor r
load
break main
continue
n
n
n
quit