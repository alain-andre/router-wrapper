# https://geo.pays-de-brest.fr/actualites/Pages/public/Offre_Theorique_Bibus.aspx

all: Graph.obj

brest-gtfs.zip:
	wget "https://applications002.brest-metropole.fr/VIPDU72/GPB/Lot_BrestMetropole_Bibus.zip" --no-verbose -O $@

brest_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=48.455 left=-4.580 bottom=48.345 right=-4.385 --write-pbf $@

Graph.obj: brest-gtfs.zip brest_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj brest-gtfs.zip
