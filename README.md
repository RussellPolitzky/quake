
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- * Turn on travis for this repo at https://travis-ci.org/profile -->
<!--  * Add a travis shield to your README.md: -->
<!-- [![Travis-CI Build Status](https://travis-ci.org/.svg?branch=master)](https://travis-ci.org/) -->
The Quake Package
=================

The `quake` package visualizes [NOAA earthquake data](https://ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1). `quake` shows when earthquakes happened on a labelled timeline, and where they happened on an interactive map.

Two custom, `ggplot2` geometries, `geom_timeline` and `geom_timeline_label` make for easy earthquake, timeline plotting and labelling, while function `eq_map` shows earthquake locations.

Installation
------------

`quake` is available from GitHub and is installed using the `devtools` package as follows:

    devtools::install_github("RussellPolitzky/quake")

Cleaning Data
-------------

NOAA data is supplied without a consolidate date column and given locations includes countr, as well as province and city. As such, the `eq_clean_data` function adds a `date` column and one for `clean_location`.

In the example, below, tab separated NOAA data is read using the `data.table`'s `fread` function, and then cleaned using `eq_clean_data`. Sample output is shown below.

``` r
library(data.table)
library(magrittr)
library(quake)
library(DT)

data_file_name <- system.file("extdata", "earthquakes.tsv", package = "quake")
clean_data     <- fread(data_file_name) %>% eq_clean_data
datatable(head(clean_data))
```

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-dcd8603ff9278607cfb8">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],[1,2,3,5877,8,11],["","Tsu","","Tsu","",""],[-2150,-2000,-2000,-1610,-1566,-1450],[1,1,1,1,1,1],[1,1,1,1,1,1],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[null,null,18,null,null,null],[7.3,null,7.1,null,null,null],[null,null,null,null,null,null],[null,null,7.1,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[7.3,null,null,null,null,null],[null,10,10,null,10,10],["JORDAN","SYRIA","TURKMENISTAN","GREECE","ISRAEL","ITALY"],["","","","","",""],["JORDAN:  BAB-A-DARAA,AL-KARAK","SYRIA:  UGARIT","TURKMENISTAN:  W","GREECE:  THERA ISLAND (SANTORINI)","ISRAEL:  ARIHA (JERICHO)","ITALY:  LACUS CIMINI"],[31.1,35.683,38,36.4,31.5,35.5],[35.5,35.8,58.2,25.4,35.3,25.5],[140,130,40,130,140,130],[null,null,1,null,null,null],[null,3,1,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[3,null,1,null,3,null],[null,null,null,null,null,null],[null,null,1,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,1,null,null,null],[null,3,1,3,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,1,3,null,null],[null,null,null,null,null,null],[null,null,1,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],["-2150-01-01","-2000-01-01","-2000-01-01","-1610-01-01","-1566-01-01","-1450-01-01"],["BAB-A-DARAA,AL-KARAK","UGARIT","W","THERA ISLAND (SANTORINI)","ARIHA (JERICHO)","LACUS CIMINI"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>I_D<\/th>\n      <th>FLAG_TSUNAMI<\/th>\n      <th>YEAR<\/th>\n      <th>MONTH<\/th>\n      <th>DAY<\/th>\n      <th>HOUR<\/th>\n      <th>MINUTE<\/th>\n      <th>SECOND<\/th>\n      <th>FOCAL_DEPTH<\/th>\n      <th>EQ_PRIMARY<\/th>\n      <th>EQ_MAG_MW<\/th>\n      <th>EQ_MAG_MS<\/th>\n      <th>EQ_MAG_MB<\/th>\n      <th>EQ_MAG_ML<\/th>\n      <th>EQ_MAG_MFA<\/th>\n      <th>EQ_MAG_UNK<\/th>\n      <th>INTENSITY<\/th>\n      <th>COUNTRY<\/th>\n      <th>STATE<\/th>\n      <th>LOCATION_NAME<\/th>\n      <th>LATITUDE<\/th>\n      <th>LONGITUDE<\/th>\n      <th>REGION_CODE<\/th>\n      <th>DEATHS<\/th>\n      <th>DEATHS_DESCRIPTION<\/th>\n      <th>MISSING<\/th>\n      <th>MISSING_DESCRIPTION<\/th>\n      <th>INJURIES<\/th>\n      <th>INJURIES_DESCRIPTION<\/th>\n      <th>DAMAGE_MILLIONS_DOLLARS<\/th>\n      <th>DAMAGE_DESCRIPTION<\/th>\n      <th>HOUSES_DESTROYED<\/th>\n      <th>HOUSES_DESTROYED_DESCRIPTION<\/th>\n      <th>HOUSES_DAMAGED<\/th>\n      <th>HOUSES_DAMAGED_DESCRIPTION<\/th>\n      <th>TOTAL_DEATHS<\/th>\n      <th>TOTAL_DEATHS_DESCRIPTION<\/th>\n      <th>TOTAL_MISSING<\/th>\n      <th>TOTAL_MISSING_DESCRIPTION<\/th>\n      <th>TOTAL_INJURIES<\/th>\n      <th>TOTAL_INJURIES_DESCRIPTION<\/th>\n      <th>TOTAL_DAMAGE_MILLIONS_DOLLARS<\/th>\n      <th>TOTAL_DAMAGE_DESCRIPTION<\/th>\n      <th>TOTAL_HOUSES_DESTROYED<\/th>\n      <th>TOTAL_HOUSES_DESTROYED_DESCRIPTION<\/th>\n      <th>TOTAL_HOUSES_DAMAGED<\/th>\n      <th>TOTAL_HOUSES_DAMAGED_DESCRIPTION<\/th>\n      <th>date<\/th>\n      <th>clean_location<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row"}},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
' @description  takes a NOAA data frame and returns a cleaned
============================================================

' . The clean  has
=================

' a date column, of type , created by uniting the year, month,
==============================================================

' day columns from the raw data. The  and 
=========================================

' are converted to s.
=====================

Plotting a Quake Timeline
-------------------------

Adding Labels to A Quake Timeline
---------------------------------

Mapping Quakes
--------------
