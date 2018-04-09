# http://opendata.grand-nancy.org/jeux-de-donnees/detail-dune-fiche-de-donnees/?tx_icsoddatastore_pi1[keywords]=&tx_icsoddatastore_pi1[fileformat][0]=13&tx_icsoddatastore_pi1[uid]=108&tx_icsoddatastore_pi1[returnID]=447

all: Graph.obj

nancy-gtfs.zip:
	wget "http://opendata.grand-nancy.org/?eID=ics_od_datastoredownload&file=333" --no-verbose -O $@

nancy_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=48.753 left=6.097 bottom=48.633 right=6.310 --write-pbf $@

Graph.obj: nancy-gtfs.zip nancy_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj nancy-gtfs.zip
