#include <pmt.h> // needed for PMT
#include <iostream>
#include <cuda.h>


int main( int argc, char *argv[] )  {

    int array_length = 10000;

    // Initialize memory on host
    size_t sizeA = sizeof(double) * array_length;

    // Allocate Host Memory
    double  *h_A = (double*) malloc(sizeA);

    // Initialize the array with values
    for (int i=0; i<array_length ; ++i) h_A[i] = double(i%3+1);

    // Initialize the Sensor
    std::unique_ptr<pmt::PMT> sensor = pmt::nvml::NVML::Create();
   
   // Read from the PMT Sensor
   pmt::State start = sensor->Read();

   // Allocate Device Memory
   double  *d_A;
   cudaMalloc((void **)&d_A, sizeA);

   cudaMemcpy(d_A, h_A, sizeA, cudaMemcpyHostToDevice);
   cudaMemcpy(d_A, h_A, sizeA, cudaMemcpyDeviceToHost);

   cudaFree(d_A);

   // Read from the PMT Sensor
   pmt::State end = sensor->Read();  
 
  std::cout << "RESULTS-------" << std::endl;
  std::cout << "PMT (NVML) Seconds: " << pmt::PMT::seconds(start, end) << " s"<< std::endl;
  std::cout << "PMT (NVML) Joules: " << pmt::PMT::joules(start, end) << " J" << std::endl;
  std::cout << "PMT (NVML) Watts: " << pmt::PMT::watts(start, end) << " W" << std::endl;

}
