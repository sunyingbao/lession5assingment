library(raster)
source('subfunction/ndvover.R')
#compile all the bands in to lists
lc8data=list.files('data1/',pattern = glob2rx('*.tif'),full.names = TRUE)
lc5data=list.files('data2/',pattern = glob2rx('*.tif'),full.names = TRUE)

#convert into rasterLayers
c8=stack(lc8data)
lc5=stack(lc5data)

#calculate NDVI
ndvilc8=ndvOver(lc8[[6]],lc8[[5]])
ndvilc5=ndvOver(lc5[[7]],lc5[[6]])

#get masks for two landsat8 and landsat5
fmasklc8=lc8[[1]]
fmasklc5=lc5[[1]]

#get rid of the clound
ndvilc8[fmasklc8 != 0] = NA
ndvilc5[fmasklc5 != 0] = NA

#plot the NDVI resulting images without cloud
plot(ndvilc8)
plot(ndvilc5)

# specify the extent for both NDVI images
extent=intersect(ndvilc8,ndvilc5)
ndvilc8newextent=crop(ndvilc8,extent)
ndvilc5newextent=crop(ndvilc5,extent)

#get final result
result=ndvilc8newextent-ndvilc5newextent
plot(result)

