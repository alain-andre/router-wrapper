# http://data.bordeaux-metropole.fr/data.php?themes=10

all: Graph.obj

bordeaux-bus-gtfs.zip:
	wget "http://data.bordeaux-metropole.fr/files.php?gid=68&format=14" --no-verbose -O $@

bordeaux-tram-gtfs.zip:
	wget "http://data.bordeaux-metropole.fr/files.php?gid=67&format=14" --no-verbose -O $@

bordeaux_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=45.065 left=-0.900 bottom=44.569 right=-0.162 --write-pbf $@

Graph.obj: bordeaux-bus-gtfs.zip bordeaux-tram-gtfs.zip bordeaux_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj bordeaux-bus-gtfs.zip bordeaux-tram-gtfs.zip
