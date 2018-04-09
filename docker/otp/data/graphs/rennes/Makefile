# https://data.explore.star.fr/explore/dataset/tco-busmetro-horaires-gtfs-versions-td/?tab=metas

all: Graph.obj

IDS=$(shell curl -s 'https://data.explore.star.fr/api/records/1.0/search/?dataset=tco-busmetro-horaires-gtfs-versions-td&q=finvalidite+%3E%3D+%23now%28%29' | jq -M -r '.records[].fields.id')

%-gtfs.zip:
	curl -s 'https://data.explore.star.fr/api/records/1.0/search/?dataset=tco-busmetro-horaires-gtfs-versions-td&q=finvalidite+%3E%3D+%23now%28%29' | jq -M -r '.records[] | select( .fields.id | contains("$*")).fields.url' | xargs -I{} wget  "{}" --no-verbose -O $@

rennes_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=48.301 left=-1.973 bottom=47.920 right=-1.469 --write-pbf $@

Graph.obj: $(IDS:%=%-gtfs.zip) rennes_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj *-gtfs.zip
