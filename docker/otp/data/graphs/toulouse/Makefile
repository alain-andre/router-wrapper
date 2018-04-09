# https://data.toulouse-metropole.fr/explore/dataset/tisseo-gtfs/?tab=metas

all: Graph.obj

tisseo-gtfs.zip:
	wget "https://data.toulouse-metropole.fr/explore/dataset/tisseo-gtfs/files/bd1298f158bc39ed9065e0c17ebb773b/download/" --no-verbose -O $@

toulouse_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=43.838 left=1.062 bottom=43.327 right=1.779 --write-pbf $@

Graph.obj: tisseo-gtfs.zip toulouse_france.osm.pbf
	java -Xmx2G -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj tisseo-gtfs.zip
