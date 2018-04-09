# http://data.angers.fr/donnees/mobilite-horaire-de-passage-theorique/

all: Graph.obj

angers-gtfs.zip:
	wget "http://data.angers.fr/?eID=ics_od_datastoredownload&file=1048" --no-verbose -O $@

angers_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=47.650 left=-0.805 bottom=47.319 right=-0.347 --write-pbf $@

Graph.obj: angers-gtfs.zip angers_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj angers-gtfs.zip
