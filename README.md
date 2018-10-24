# ZHHpipelines
The preprocessing pipeline at ZHH
## BIDS Conversion
**Usage: dicom2bids.sh grid_num sess_num descr**
  
  grid_num: subject identifier;
  sess_num: session identifier;
  descr: study specificator (currently available: TMS)

**Usage: multiple_dicom2bids.sh info.csv**

  info.csv: a file with 3 columns, first subject identifier, second: session identifier, third: study type
  Program goes over every line one by one and calls dicom2bids.sh
  
  
  test...
