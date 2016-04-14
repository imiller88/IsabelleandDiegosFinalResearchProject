**Assignment:**

gather web based data from at least two sources, merge the data sets, conduct basic descriptive and inferential statistics on the data to address a relevant research question and briefly describe the results including with dynamically generated tables and figures. Students are encouraged to access data and perform statistical analyses with an eye to answering questions relevant for their Collaborative Research Project. Deadline 19 April, the write up should be 1,500 words maximum and use literate programming, 10% of final grade.

All of the code can be found in the file DownloadCleanMergeFinal.R.



**1. Data scraping**

Data has been drawn from three separate sources: the Quality of Governance Standard dataset (found at http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.csv), the World Governance Indicator dataset (found at http://databank.worldbank.org/data/download/WGI_csv.zip), and the World Development Indicator dataset, which can be downloaded as an R package called "WDI". This code can be found isolated in the file 1_Downloading.R.

**2. Data Cleaning and Reshaping**

The desired variables have been selected out of the datasets for the years 2002-2014, shaped for merging, and cleaned to eliminate NA or unclear values. This code can be found isolated in 2_CleaningReshaping.R.

**3. Merging**

The isolated code for the merging of variables into a single dataset can be found in the file 3_Merging.R.
