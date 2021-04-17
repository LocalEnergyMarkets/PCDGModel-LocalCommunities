README

Here is a step-by-step guide how to use the PCDG stand-alone application:

1) Access the github repository at https://github.com/LocalEnergyMarkets/PCDGModel-LocalCommunities

------------------------------------

2) For non-MATLAB users, download MATLAB Runtime from the link provided in the Step 1 folder.
After MATLAB Runtime download is complete, continue with next step. 

------------------------------------

3) For users with MATLAB already installed, download the PCDG.exe file from the Step 2 folder.

------------------------------------

4) Running Example Use Case

Once PCDG.exe is successfully running, there are several pages to get familiar with:

	a) Home  
	Provides context for the relevance of peer-to-peer (P2P) energy networks in today's electricity 
	grid, as well as links to the paper the model is based off of and the template used in data input.
	
	b) Data Import 
	Provides a link to the template, as well as an Import Data button. Upon clicking the
	Import Data button, the user has the option to determine the data used in the model. Please choose the 
	"P2P Data Input" file provided in the github repository. After several seconds, two dropdown menus will show up. 
	"Time periods per hour" allows you to determine the time periods per hour in the model. Given that the example data
	is in 30 minute timesteps, please choose "2". "Battery Inclusion" determines whether or not there are batteries in the
 	example. To make things interesting, choose "On". 
	This brings up various battery parameters, all which can be changed to represent a battery of the user's choosing. At 
	this time, all batteries in a neighborhood must have the same characteristics. For the example in our model, the 
	batteries used have the following characteristics:

	Battery Capacity Value = 4 kWh
	Charging Efficiency = 94.08%
	Max Charging Rate = 2.5 kW
	Discharging Efficiency = 94.08%
	Max Discharge Rate = 2.5 kW
	Initial Battery Charge = 0

	User may pick several houses at random by clicking on them House Numbers in the dropdown menu under "Select House".
	Houses chosen to have battery storage will show as green in figure on the right side of the screen.

	c) Visualization 
	Primary page for analyzing results and KPIs of the model. Under "Tweak Settings", user can change
	the KPI represented in the graph by changing the "Y-Axis Data". Additionally, this can be shown for all houses, or 
	individual houses by changing "House Number".

	Several important KPIs are listed under the "Global KPI" section. These can be exported to Excel using the "Export KPI to Excel" button. 

	d) Trading Between Houses 
	Visualizes P2P trading on a household scale. "Display Trading" will show a electricity 
	flow graph between houses. This can get quite messy with many households and batteries. Flow tends to center around 
	houses with surplus RES or batteries. "Total Export", "Total Import", and "Total Trade" are visualized in the graph on the right. 
	The Y-axis represents the houses which are exporting electricity, and the X-axis import. The trading volume is shown chromatically 
	by the scale on the right. 

	e) Compare
	This tab allows the user to compare multiple simulations' KPIs. Once the user has ran different cases (you can try it 
	yourself by changing the battery characteristics or by adding more/less batteries) and they have exported the KPIs 
  	on the Visualization tab, they can be compared graphically by importing the KPIs on this page. 

	f) End 
	The user can find contact information, as well as start a new simulation or close the application.
	IMPORTANT: In order the run another simulation, the user must click "New Simulation", which 
	restarts the application. The application cannot run multiple instances at once, and as such 
	will produce an error if multiple input files are uploaded. Please remember to export your KPIs 
	before running a new simulation if you intend to compare them.


------------------------------------

5) Developing Unique Input Data

Once the user is familiar with the features of the software using the given data, the input data file can be changed to meet 
the user's simulation needs. The input data template is split into several different tabs:

	a) Demand represents the power demand per time period for each household. It is important to note that this is different
	from the energy consumed, unless the time step is 1 hour (1kW for a half hour timestep represents .5kWh of energy,
	but 1kW of demand in a 1 hour timestep represents 1kWh of energy).

	b) Electricity Price represents the electricity price per time period.

	c&d) Wind and Solar Data represent the wind and solar input data per time period for all houses that have solar or
	wind turbine systems. All houses with no RES can be left blank. 

	e) Grid Tariff represents the feed-in tariff price for renewables per time period.

IMPORTANT: Make sure that all the time steps match up for each tab. The application will not run if any of them do not match.
Feel free to play around with the data provided in "P2P Data Input for 9 months", or utilize your own data.

------------------------------------

A technical user manual with visual guides is currently under development and will be linked to in the github once complete.

-----------------------------------

Underlying file notes:

PCDGModel-LocalCommunities
CommunityBasedP2P.m is the main mfile that loads the input data and passes it to the P2P.m function. 
One should read the demand, price, solar, and wind profiles for the considered period. 
The batteries can be included for each house by setting the corresponding element of BatteryPlace to one and vice versa. 
The initial state of charge of each battery is set in the Sp0 vector.
