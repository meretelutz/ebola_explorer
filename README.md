# Ebola Explorer

A dashboard to explore the 2014-2016 Ebola virus outbreak through cases and deaths

## The Outbreak

The 2014-2016 Ebola virus outbreak in Western Africa was one of the most widespread and deadliest outbreaks of Ebola in history. The first case was reported in Guinea, but the disease spread rapidly and widely, with major outbreaks in Liberia and Sierra Leone, and minor in the USA, UK, Italy, and Spain. This particular outbreak infected 28,616 people, and killed 11,310, with an overall case-fatality rate of 40%.

## Target Audience: Students of epidemiology and public health

This infamous epidemic is often studied by epidemiologists in training due to its widespread nature and well-documented history. It is a commonly used case-study to explore how cultural norms and traditions must be taken into account when developing public health interventions. I hope that students learning about public health will be able to use this dashboard to explore different ways of plotting disease surveillance information, and learn about common epidemiological metrics like case fatality rate and mortality rate. The ability to filter the data for country and time period allows users to compare responses across countries and examine trends in the data. 

## The Data

The data for this dashboard is sourced from [kaggle](https://www.kaggle.com/datasets/imdevskp/ebola-outbreak-20142016-complete-dataset) which in turn sourced the data from the [Humanitarian Data Exchange](https://data.humdata.org/dataset/ebola-cases-2014) and the [World Health Organization](https://www.who.int/csr/don/archive/disease/ebola/en/). Observations span from August 2014 to March 2016 across 10 countries, and include cumulative number of cases and deaths. 

## Installation Instructions

From your terminal, navigate to the location you would like to download the repository and run the following command:
```bash
git clone git@github.ubc.ca:MDS-2023-24/DSCI_532_individual-assignment_merete.git
```

Next navigate into the repo
```bash
cd DSCI_532_individual-assignment_merete
```

And open the RProject file
```bash
open DSCI_532_individual-assignment_merete.Rproj 
```

Activate the project's environment
```r
renv::restore()
```
Using the RStudio interface, open the `app.R` file found in the `src` folder, and run the file (cmd+shift+return on Mac) to launch the app
