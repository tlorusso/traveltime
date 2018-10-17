## traveltimeR - API Wrapper for the Traveltime API

The traveltimeR-package allows to retrieve isochrones for traveltimemaps from the Traveltime Platform API directly from R. The isochrones are stored as sf-objects, ready for visualization or further processing. The isochrones display how far you can travel from a certain location within a given timeframe. Numerous modes of transport are supported.
https://api.traveltimeapp.com/

__GET an API-KEY__ here: http://docs.traveltimeplatform.com/overview/getting-keys/

For non-commercial use the usage of the API is free up to 10'000 queries a month (max 30 queries per min). For commercial use (e.g. to integrate the API into a website) a license is needed. 


```
devtools::install_github("tlorusso/traveltimeR")

# load packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, purrr, sf, mapview, traveltimeR)

```


You can easily retrieve the isochrones with the get_traveltime function.


### querying the Traveltime-API with get_traveltime

```
# retrieve isochrones via request 

# The following transport modes are supported:

# "cycling"", "cycling_ferry", "driving", "driving+train", "driving_ferry", "public_transport", 
# "walking", "walking+coach", "walking_bus", "walking_ferry" or "walking_train".

# how far can you go by public transport within 30 minutes?
traveltime30 <- get_traveltime(appId="YourAppId",
               apiKey="YourAPIKey",
               location=c(47.378610,8.54000),
               traveltime=1800,
               type="public_transport",
               departure="2018-10-05T08:00:00Z")

```

Examples of how to ... the traveltime-isochrones in R easily are available in the vignette.
