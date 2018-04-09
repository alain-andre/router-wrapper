# http://www.cts-strasbourg.eu/fr/portail-open-data/

all: Graph.obj

strasbourg-gtfs.zip:
	wget "http://opendata.cts-strasbourg.fr/fichiers/gtfs/google_transit.zip" --no-verbose -O $@

strasbourg_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=48.722 left=7.449 bottom=48.371 right=8.078 --write-pbf $@

Graph.obj: strasbourg-gtfs.zip strasbourg_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj strasbourg-gtfs.zip
