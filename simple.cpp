#include <pmt.h> // needed for PMT
#include <iostream>


int main( int argc, char *argv[] )  {
 
  // Initialize the Sensor
  std::unique_ptr<pmt::PMT> sensor = pmt::rapl::Rapl::Create();
   
  // Read from the PMT Sensor
  pmt::State start = sensor->Read();
   
  for(int i =0;i<20000;i++){
    int dummy = i;
  }
 
  // Read from the PMT Sensor
  pmt::State end = sensor->Read();  
 
  std::cout << "RESULTS-------" << std::endl;
  std::cout << "PMT Seconds: " << pmt::PMT::seconds(start, end) << " s"<< std::endl;
  std::cout << "PMT Joules: " << pmt::PMT::joules(start, end) << " J" << std::endl;
  std::cout << "PMT Watts: " << pmt::PMT::watts(start, end) << " W" << std::endl;

}
