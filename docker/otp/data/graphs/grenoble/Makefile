# http://www.metromobilite.fr/pages/opendata/OpenDataHorairesTheoriques.html

all: Graph.obj

grenoble-gtfs.zip:
	wget "http://www.metromobilite.fr/data/Horaires/SEM-GTFS.zip" --no-verbose -O $@

grenoble_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=45.244 left=5.573 bottom=45.113 right=5.903 --write-pbf $@

Graph.obj: grenoble-gtfs.zip grenoble_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj grenoble-gtfs.zip
