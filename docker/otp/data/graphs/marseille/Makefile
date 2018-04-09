# http://www.lepilote.com/presentation/?rub_code=92&result=2

#ZIP=ACCM AGGLOBUS AIXENBUS BUSDESCOLLINES CG13 CIGALES CIOTABUS COTEBLEUE CPA ETANG FRIOUL LIBEBUS MARCOULINE MILSAB RTM RTMNAV SANPROVENCE

#ZIP=ACCM AGGLOBUS AIXENBUS BUSDESCOLLINES CG13 CIGALES CIOTABUS COTEBLEUE CPA ETANG FRIOUL LER LIBEBUS MARCOULINE MILSAB RTM RTMNAV SANPROVENCE TERIntercite 
#ZIP=ACCM AGGLOBUS AIXENBUS BUSDESCOLLINES CG13 CIGALES CIOTABUS COTEBLEUE CPA ETANG FRIOUL LIBEBUS MARCOULINE MILSAB RTM RTMNAV SANPROVENCE
ZIP=ACCM AGGLOBUS AIXENBUS BUSDESCOLLINES CG13 CIGALES CIOTABUS COTEBLEUE CPA ETANG FRIOUL LIBEBUS MARCOULINE MILSAB RTM RTMNAV SANPROVENCE

all: Graph.obj

#.INTERMEDIATE: $(ZIP:%=%.ZIP)

mobi.chouette.command-3.1.0.zip:
	wget http://maven.chouette.cityway.fr/mobi/chouette/mobi.chouette.command/3.1.0/$@ --no-verbose -O $@

chouette-cmd_3.1.0: mobi.chouette.command-3.1.0.zip
	unzip mobi.chouette.command-3.1.0.zip && chmod 0755 chouette-cmd_3.1.0

%.ZIP:
#	wget "http://www.lepilote.com/FTP/OpenData/$@" --no-verbose -O $@
	wget "http://tsvc2.pilote3.cityway.fr/api/Export/v1/GetExportedDataFile?ExportFormat=Neptune&OperatorCode=$*" --no-verbose -O $@

%-gtfs.zip: %.ZIP chouette-cmd_3.1.0
#%-gtfs.zip:
#	wget "http://tsvc.pilote3.cityway.fr/api/Export/v1/GetExportedDataFile?ExportFormat=Gtfs&OperatorCode=$*" --no-verbose -O $@
	cd chouette-cmd_3.1.0 && sh chouette.sh -i ../input.json -o ../output.json -f ../$@ ../$<

marseille_france.osm.pbf:
	osmosis --read-pbf /srv/osm/europe/france/france-latest.osm.pbf --bounding-box top=43.554 left=4.905 bottom=43.038 right=5.776 --write-pbf $@

Graph.obj: $(ZIP:%=%-gtfs.zip) marseille_france.osm.pbf
	java -jar ${OTP} --build .

clean:
	rm -fr *.osm.pbf Graph.obj $(ZIP) $(ZIP:%=%-gtfs.zip)
