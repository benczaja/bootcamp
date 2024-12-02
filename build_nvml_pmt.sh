#!/bin/bash

#source /cvmfs/software.eessi.io/versions/2023.06/init/bash 
#module load foss/2023b

unset LIBRARY_PATH
unset LD_LIBRARY_PATH

# Clone and Build PMT
git clone https://git.astron.nl/RD/pmt.git

cd pmt

mkdir build && cd build

cmake -DPMT_BUILD_RAPL=1 -DPMT_BUILD_NVML=1 -DCMAKE_INSTALL_PREFIX=/home/benjamic/bootcamp/pmt ..

make install

cd ../..


export LIBRARY_PATH=/usr/local/cuda/lib64
export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH

# compile simple cpp code
/usr/local/cuda/bin/nvcc -std=c++20 -I/home/benjamic/bootcamp/pmt/include -L/home/benjamic/bootcamp/pmt/lib -lpmt simple.cu -o simple.exe

# add some paths to your LD path
# PMT
export LD_LIBRARY_PATH=/home/benjamic/bootcamp/pmt/lib
# LIBSTD (EESSI compat layer workaround)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/software.eessi.io/versions/2023.06/software/linux/x86_64/intel/skylake_avx512/software/GCCcore/13.2.0/lib64





