# Nairobi Air Quality Analysis — Documentation and Findings

**Overview**

I analyzed environmental and economic indicators for Nairobi by combining five separate data sources: Gross County Product (GCP) figures, population totals, three years of PM sensor readings (2017–2019), and a global air quality and deforestation dataset filtered to Nairobi. The aim was to bring these disparate sources into a consistent form and summarize how air quality and related environmental pressures have evolved over time.

**Gross County Product data**

I loaded Nairobi's GCP series for 2013–2020, restructured it from its original wide, labelled format into a Year and GCP(Kes) column pair, and rescaled the values to millions of Kenyan shillings for readability. Across the eight years covered, GCP rose steadily from approximately 1.61 million to 2.27 million (in the rescaled units), with a mean of 1.97 million and comparatively low variability (standard deviation of 0.25 million), consistent with sustained, gradual economic growth over the period.

**Population data**

I renamed the unlabelled year column and rescaled the population series to millions. The portion of the series I inspected, covering 2000–2009, shows Nairobi's population growing from roughly 2.21 million to 3.12 million, an increase of about 41 percent over that decade.

**PM sensor data (2017–2019)**

I parsed three years of air quality data from raw sensor archive files for June 2017-2019, splitting each row into sensor ID, type, location, coordinates, timestamp, value type, and value, then dropped the identifying and locational fields to focus on the measured values. After averaging by value type, the 2017 sample shows a mean P1 (PM10-equivalent) reading of 7.78 and a mean P2 (PM2.5-equivalent) reading of 4.70, alongside average humidity of 81.75 percent and temperature of 21.1°C for that June.

**Global dataset, filtered to Nairobi**

I filtered a global air quality and environmental dataset down to Nairobi records, converted its numeric fields from string type, and derived a Net Deforestation Rate as the difference between deforestation and afforestation rates. After removing one flagged outlier row and dropping identifying and unused columns, I aggregated the remaining records by year. The city-level (pre-aggregation) records show individual-year AQI readings ranging from roughly 47 to 158, PM2.5 from about 27 to 97, and PM10 from near 0 to 148, alongside net deforestation rates mostly between 1 and 6 percent, with one year recording a small negative value indicating afforestation outpaced deforestation. The year-aggregated summary shows average AQI in the 94–109 range for 2014, 2016, and 2017, but an anomalous mean of 2,445.66 for 2015, roughly twenty times any other year in the series.

**Notes on the code and data as written**

The 2015 AQI anomaly in the final aggregated table indicates a data quality issue, most likely one or more extreme or corrupted values in the source records for that year that survived the single outlier removal step; the outlier-removal step in the notebook drops only one specific row index, which is not enough to fully clean the 2015 aggregate. The aggregated table also contains a 1991 entry despite the underlying Nairobi records otherwise spanning 2014–2023, suggesting either a genuine early record or a parsing artifact worth verifying. Separately, the sensor-data preparation step assigns nrb_pm18's split columns to all three PM dataframes (nrb_pm17, nrb_pm18, and nrb_pm19 all read from nrb_pm18['row']), so the 2017 and 2019 results reported above are very likely populated from 2018 sensor data rather than their own years; this should be corrected before the per-year sensor comparisons are relied upon. Finally, the GCP cleaning step (dropping the first six rows and renaming columns) is executed twice in the notebook, the second time on data that has already been transformed, though in this case the second pass is a no-op rather than a source of error since the first six remaining rows are already numeric year rows.

**Dependencies**

pandas and numpy, along with the five source files: NairobiGCP.csv, the Nairobi population CSV, three sensor data archive CSVs for June 2017–2019, and global_air_quality_datacleaning.csv.
