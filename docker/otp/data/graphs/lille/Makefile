all: Graph.obj

lille-gtfs.zip:
	wget -4 --no-check-certificate "https://opendata.lillemetropole.fr/api/datasets/1.0/transport_arret_transpole-point/alternative_exports/gtfs_zip" --no-verbose -O $@

lille-latest.osm.pbf:
	wget -4 --no-check-certificate "https://s3.amazonaws.com/mapzen.odes/ex_NJX7NfeFU5XQNmLb46pTfmAZ5KMca.osm.pbf" --no-verbose -O $@

Graph.obj: lille-gtfs.zip lille-latest.osm.pbf
	java -Xmx4G -jar ${OTP} --build .

clean:
	rm -f *.osm.pbf Graph.obj lille-gtfs.zip
