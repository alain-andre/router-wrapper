# http://data.paysdelaloire.fr/donnees/detail/arrets-horaires-et-circuits-impulsyon-gtfs-a-la-roche-sur-yon

all: Graph.obj

gtfs-ginko.zip:
	wget "http://data.paysdelaloire.fr/fileadmin/data/datastore/pdl/GTFS/J386.zip" --no-verbose -O $@

la-roche-sur-yon_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=46.82 left=-1.6322 bottom=46.5223 right=-1.17554 --write-pbf $@

Graph.obj: gtfs-ginko.zip la-roche-sur-yon_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj gtfs-ginko.zip
