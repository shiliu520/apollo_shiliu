rm -rf build/
mkdir build
cd build
cmake ..
make
./torch_gpu_debug
