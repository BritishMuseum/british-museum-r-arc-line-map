# Arc Lines on World, Europe or UK map

![](https://img.shields.io/badge/code-R-blue.svg) ![](https://img.shields.io/badge/license-GNU-brightgreen.svg) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1053810.svg)](https://doi.org/10.5281/zenodo.1053810)

#### Objective : Make a map with arcs from a central point using auto-collecting latitude and longitude of locations OR just plot arc line path plotted on 2D map

## Plotting Examples
<img src="https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/outputs/world_example.png" width="800"><img src="https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/outputs/europe_example.png" width="400"><img src="https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/outputs/uk_example.png" width="400">

**Prerequisites : *Download [R](https://www.r-project.org/) and [R studio desktop](https://www.rstudio.com/products/rstudio/download/) to get started.***

## Navigation
 :open_file_folder: [code](https://github.com/BritishMuseum/british-museum-r-arc-line-map/tree/master/src)

 :triangular_ruler: [outputs](https://github.com/BritishMuseum/british-museum-r-arc-line-map/tree/master/outputs)
 
 :bar_chart: [data](https://github.com/BritishMuseum/british-museum-r-arc-line-map/tree/master/data)

## Code to run  
You can use your own city list (with countries) to create your own map.
### 1. ![run_global.R](https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/src/run_global.R)
Open run_global.R - it includes all the packages required to create. Then the auto-generate of latitude and longitude of your cities. 
Change the colours. 
#### ![geocode_arc_map.R](https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/src/geocode_arc_map.R) - create maps
#### ![auto_geocode.R](https://github.com/BritishMuseum/british-museum-r-arc-line-map/blob/master/src/auto_geocode.R) - auto-generate lat and lon
