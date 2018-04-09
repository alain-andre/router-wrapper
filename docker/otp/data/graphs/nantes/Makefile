# http://data.nantes.fr/donnees/detail/arrets-horaires-et-circuits-tan/
# http://data.nantes.fr/donnees/detail/arrets-horaires-et-circuits-tan-ete-2013/

all: Graph.obj

.INTERMEDIATE: nantes.zip ARRETS_HORAIRES_CIRCUITS_TAN_GTFS_%.zip

nantes.zip:
	wget "http://data.nantes.fr/fileadmin/data/datastore/nm/mobilite/24440040400129_NM_TAN_00253/ARRETS_HORAIRES_CIRCUITS_TAN_2017_2018_gtfs.zip" --no-verbose -O $@

ARRETS_HORAIRES_CIRCUITS_TAN_GTFS_%.zip: nantes.zip
	unzip -o $< '*.zip'

nantes-gtfs.zip: ARRETS_HORAIRES_CIRCUITS_TAN_GTFS_%.zip
	mv ARRETS_HORAIRES_CIRCUITS_TAN_GTFS_*.zip $@

nantes_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=47.407 left=-1.866 bottom=47.035 right=-1.191 --write-pbf $@

Graph.obj: nantes-gtfs.zip
	java -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj nantes.zip nantes-gtfs.zip
