rm -rf build/
mkdir build
cd build
cmake -Wno-dev ..
make
./torch_gpu_debug
