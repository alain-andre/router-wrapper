# https://api.ginko.voyage

all: Graph.obj

gtfs-ginko.zip:
	wget "https://api.ginko.voyage/gtfs-ginko.zip" --no-verbose -O $@

besancon_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=47.39 left=5.75 bottom=47.07 right=6.24 --write-pbf $@

Graph.obj: gtfs-ginko.zip besancon_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj gtfs-ginko.zip
