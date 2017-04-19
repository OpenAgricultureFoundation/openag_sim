# openag_sim

## How to simulate:

### Prerequisites

* A Windows machine with Scilab and GreenScilab installed.
	* Setting up a Windows VM is sufficient.
	* Inside Windows, run scilab-4.1.exe (in the repository’s Software folder).
	* Place Software/GreenScilabV0.9 folder inside now-installed Scilab’s ‘contrib’ folder.
	

### Obtaining input weather data

This is the procedure to follow if you want to re-download and re-process data from the EPW website. *Otherwise, the relevant .dat weather files are available in Data/station_dat_files*, and you should feel free to copy them.

* ‘Data’ folder in repository is relevant. Contains epw_reader.py, epw_retriever.py, and ew_weather_data.csv.
* ‘epw’ refers to EnergyPlus aggregated weather data set: https://energyplus.net/weather
* To download weather data from epw website, in standard format
	* In terminal: ‘python epw_retriever.py’ with input argument ‘epw_data.csv’
* To convert the .epw files to .dat files: 
	* In terminal: ‘python epw_reader.py’ with input argument ‘EPW’
	* (Run this command from the same directory as the epw_retriever.py command) 
* Afterwards, you should have created an ‘EPW’ file in your directory that contains subfolders for every country and weather station. You should also have a directory EPW/dat/ that contains a .dat file for every weather station.

### Simulating on weather station .dat files

* Open Scilab. Run command ‘exec(“path to the ‘loader’ file inside Greenlab”)’
* Run command ‘exec(“fun1.sci”)’ to have access to the prewritten simulator function.
* Run command ‘fun1(“path to parameter file”, “path to folder with batch of desired .dat files/*.dat”, “path to desired output directory”)’
	* The parameter file for five stages of cotton growth is included in this repository as Software/GreenScilabV0.9/parafiles/cotton_5stages.sci
* You should have output files that look like this:

![alt tag](https://github.com/OpenAgInitiative/openag_sim/blob/master/Data/images/greenlab_sim_output.png?raw=true)



