all: Graph.obj

poitiers-gtfs.zip:
	wget "https://data.grandpoitiers.fr/explore/dataset/mobilite-arret-services-theoriques-bus-hiver/files/400d7da94eaacb5e52c612f8ac28e420/download/" --no-verbose -O $@

poitiers-latest.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=46.706 left=0.188 bottom=46.484 right=0.483 --write-pbf $@

Graph.obj: poitiers-gtfs.zip poitiers-latest.osm.pbf
	java -Xmx4G -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj poitiers-gtfs.zip
