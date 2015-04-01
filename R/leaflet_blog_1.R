##### Location Names
Location <- c("Atlanta ","Los Angeles","Chicago","New York","Dallas","Baltimore","Phoenix","Charlotte","Houston","San Antonio", "Seattle" )

#### Latitude and Longitude values for each of the above location
Lat <- c(33.74401,33.82377,41.78798,40.767309,32.88153,39.148492,33.45444,35.2406,29.935842,29.44838,47.714965 )
Lon <- c(-84.56032,-118.2668,-87.7738,-73.978308,-96.64601,-76.796211,-112.32401,-81.04028,-95.398436,-98.39908,-122.127166 )

#### Some hypothetical number of orders shipped out of each location
Orders <- c(1992,2500,3600,2252,3650,3450,4145,3945,5050,4300,1987)

#### Let us create some hypothetical class flags for the cities
Type <- c(rep("Yoda",5),rep("Vader",6))
### Create data set from the above vectors
df <- data.frame(Location, Lat,Lon,Orders,Type)


###Now let us start experimenting with the maps.
##1. This is just a OSM tile layer, so the default world map (if you zoom in couple of times)
library(leaflet) 
mymap <- leaflet() %>% addTiles() 
##mymap  # a map with the default OSM tile layer

###If you want to control the map tile layer, here is an example:  
mymap <- mymap %>%
addTiles(
'http://otile{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpeg',
attribution = 'Tiles Courtesy of <a href="http://www.mapquest.com/">MapQuest</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
) %>% setView(-97, 40, zoom = 4)
####mymap


##2. Adding popups at a certain location.

mymap %>% addPopups(-85.472059, 35.929550, '<b>This is Sparta!</b>, no really! This is Sparta, TN! ')


##3. Add circles to the map.

# add some circles to a map, using the dummy data we have created 'df'
mymap %>% addCircles(data=df)
# you can also explicitly use Lat and Long
mymap %>% addCircles(data=df,lat= ~Lat, lng = ~Lon, radius = 50, color = '#ff0000')


##5. Markers

mymap %>% addMarkers(data=df,df[1,"Lon"],df[1,"Lat"], icon = JS("L.icon({
                                                                iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                                iconSize: [75, 75]
                                                                })"))


##6. You can add markups and popups together.

mymap %>% addMarkers(data=df,df[1,"Lon"],df[1,"Lat"], icon = JS("L.icon({
                                                                iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                                iconSize: [75, 75]
                                                                })")) %>%
  addPopups(-86.753660,36.181098,  'Atlanta...@#brrr@+-*`~|%&#^$$') %>% 
  


##7. You can even have multiple markers, each with different icon!
Yoda - <http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png>  
  Vader- <http://icons.iconarchive.com/icons/artua/star-wars/128/Darth-Vader-icon.png>  
 
mymap %>% addMarkers(data=df,df[1,"Lon"],df[1,"Lat"],icon = JS("L.icon({
                                                               iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                               iconSize: [60, 60]
                                                               })")) %>%
  addPopups(data=df,df[1,"Lon"],df[1,"Lat"], as.character(df[1,"Location"])) %>%
  addMarkers(data=df,df[2,"Lon"],df[2,"Lat"],icon = JS("L.icon({
                                                       iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                       iconSize: [60, 60]
                                                       })")) %>%
  addPopups(data=df,df[2,"Lon"],df[2,"Lat"], as.character(df[2,"Location"])) %>%
  addMarkers(data=df,df[7,"Lon"],df[7,"Lat"],icon = JS("L.icon({
                                                       iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Darth-Vader-icon.png',
                                                       iconSize: [60, 60]
                                                       })")) %>%
  addPopups(data=df,df[7,"Lon"],df[7,"Lat"], as.character(df[7,"Location"])) %>%
  addMarkers(data=df,df[10,"Lon"],df[10,"Lat"],icon = JS("L.icon({
                                                         iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Darth-Vader-icon.png',
                                                         iconSize: [60, 60]
})")) %>%
  addPopups(data=df,df[10,"Lon"],df[10,"Lat"], as.character(df[10,"Location"]))


#####This can be done in a faster way, by vectorizing. It can also be automated in a user-function.

##### Mapping Yoda icons only
mymap %>% addMarkers(as.vector(df[1:5,"Lon"]),as.vector(df[1:5,"Lat"]),  icon = JS("L.icon({
                                                                                   iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                                                   iconSize: [50, 50]
  })")) 
##  %>% addPopups(as.vector(df[1:5,"Lon"]),as.vector(df[1:5,"Lat"]), as.character(df[1:5,"Location"]) )

##### Mapping Yoda and Vader locations together
mymap %>% addMarkers(as.vector(df[df$Type=="Yoda","Lon"]),as.vector(df[df$Type=="Yoda","Lat"]),  icon = JS("L.icon({
                                                                                                           iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Master-Joda-icon.png',
                                                                                                           iconSize: [50, 50]
})")) %>%
  addPopups(as.vector(df[df$Type=="Yoda","Lon"]),as.vector(df[df$Type=="Yoda","Lat"]), as.character(df[df$Type=="Yoda","Location"]) ) %>%
  addMarkers(as.vector(df[df$Type=="Vader","Lon"]),as.vector(df[df$Type=="Vader","Lat"]),  icon = JS("L.icon({
                                                                                                     iconUrl: 'http://icons.iconarchive.com/icons/artua/star-wars/128/Darth-Vader-icon.png',
                                                                                                     iconSize: [50, 50]
                                                                                                     })")) %>%
 addPopups(as.vector(df[df$Type=="Vader","Lon"]),as.vector(df[df$Type=="Vader","Lat"]), as.character(df[df$Type=="Vader","Location"]) ) 


