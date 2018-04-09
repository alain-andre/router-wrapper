# http://opendata.nicecotedazur.org/data/dataset/export-quotidien-au-format-gtfs-du-reseau-de-transport-lignes-d-azur

all: Graph.obj

nice-gtfs.zip:
	#wget "http://opendata.nicecotedazur.org/data/storage/f/gtfs1501542901/GTFSExport.zip" --no-verbose -O $@
	wget "http://opendata.nicecotedazur.org/data/dataset/export-quotidien-au-format-gtfs-du-reseau-de-transport-lignes-d-azur/resource/aacb4eea-d008-4b13-b17a-848b8ced7e03/download" --no-verbose -O $@

nice_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=43.756 left=7.182 bottom=43.636 right=7.311 --write-pbf $@

Graph.obj: nice-gtfs.zip nice_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj nice-gtfs.zip
