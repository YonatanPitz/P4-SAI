# P4-SAI
SAI implementation in P4

For easy use of useful symbolic links, clone inside behavioral-model/targets/

# Running
execute ```sudo veth_setup.sh``` to create veth interfaces.

execute ```run_server.sh``` to run the behavioral_model switch.  
log is written automatically to log.txt

# Compiling
make sure you have the [p4c-bm](https://github.com/p4lang/p4c-bm) compiler installed.
run ```p4c-bmv2 --p4-v1.1 --json sai.json src/sai.p4``` on main directory.
