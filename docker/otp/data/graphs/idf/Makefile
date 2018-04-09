# http://opendata.stif.info/explore/dataset/offre-horaires-tc-gtfs-idf/?tab=metas

all: Graph.obj

stif-gtfs.zip:
	wget -4 --no-check-certificate "https://opendata.stif.info/explore/dataset/offre-horaires-tc-gtfs-idf/files/f24cf9dbf6f80c28b8edfdd99ea16aad/download/" --no-verbose -O $@

ile-de-france-latest.osm.pbf:
	#wget https://s3.amazonaws.com/metro-extracts.mapzen.com/$@
	wget http://download.geofabrik.de/europe/france/$@

Graph.obj: stif-gtfs.zip ile-de-france-latest.osm.pbf
	java -Xmx4G -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj stif-gtfs.zip
