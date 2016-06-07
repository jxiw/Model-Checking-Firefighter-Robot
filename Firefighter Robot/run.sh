bipc.sh -I . -p Robot -d "RobotCompound()" --gencpp-output output
cmake output
make -j 4
./system

