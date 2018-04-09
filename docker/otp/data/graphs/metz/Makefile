# https://www.data.gouv.fr/fr/datasets/transport-donnees-gtfs/

all: Graph.obj

metz-gtfs.zip:
	wget --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" "https://si.metzmetropole.fr/fiches/opendata/gtfs_current.zip" --no-verbose -O $@

metz_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=49.159 left=6.056 bottom=49.053 right=6.349 --write-pbf $@

Graph.obj: metz-gtfs.zip metz_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj metz-gtfs.zip
