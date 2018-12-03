[![Build Status](https://travis-ci.org/tlorusso/traveltime.svg?branch=dev)](https://travis-ci.org/tlorusso/traveltime)

## traveltime - API Wrapper for the Traveltime API

The traveltime-package allows to retrieve isochrones for traveltime-maps from the [Traveltime Platform API](http://docs.traveltimeplatform.com/overview/introduction) directly from R. The isochrones are stored as sf-objects, ready for visualization or further processing. The isochrones display how far you can travel from a certain location within a given timeframe. Numerous modes of transport are supported.

__GET an API-KEY__ here: http://docs.traveltimeplatform.com/overview/getting-keys/

For non-commercial use the usage of the API is free up to 10'000 queries a month (max 30 queries per min). For commercial use (e.g. to integrate the API into a website) a license is needed. 

You can install the traveltime-package with devtools or remotes from Github. 
```
devtools::install_github("tlorusso/traveltime")

library(traveltime)

```

The `traveltime_map` function allows to easily retrieve traveltime-isochrones via the Traveltime-API.

### querying the Traveltime-API with get_traveltime

```
# retrieve isochrones via request 

The following transport modes are supported:

# "cycling"", "cycling_ferry", "driving", "driving+train", "driving_ferry", "public_transport", 
# "walking", "walking+coach", "walking_bus", "walking_ferry" or "walking_train".

# how far can you go by public transport within 30 minutes?

traveltime30 <- traveltime_map(appId="YourAppId",
               apiKey="YourAPIKey",
               location=c(47.378610,8.54000),
               traveltime=1800,
               type="public_transport",
               departure="2018-10-05T08:00:00Z")
			   
# take a glimpse at the data

plot(traveltime30)

# or on top of a leaflet-map with mapview

mapview::mapview(traveltime30)


# You can switch to arrival search (from how far is a location reachable within x min?) just by using the 'arrival' argument instead of 'departure'.

traveltime30_arrival <- traveltime_map(appId="YourAppId",
               apiKey="YourAPIKey",
               location=c(47.378610,8.54000),
               traveltime=1800,
               type="public_transport",
               arrival="YYYY-MM-DDT08:00:00Z")

```

Some first examples of how to use the API-Wrapper and what can be done with the data are available in the vignette:

https://tlorusso.github.io/traveltime/vignette.html

