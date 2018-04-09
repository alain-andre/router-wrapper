CITIES=angers besancon bordeaux brest grenoble idf la-roche-sur-yon lille marseille metz montpellier nancy nantes nice oise poitiers rennes royan strasbourg toulouse vienne

# angers

# /!\
# File with date in file name
# idf

.PHONY: run clean $(CITIES)

all: $(CITIES)

run: $(CITIES)
	java -jar -Xmx4G ${OTP} \
            --analyst \
            --server \
            --insecure \
            --basePath . $(patsubst %,--router %, $(CITIES))


clean:
	for dir in $(CITIES); do \
	  $(MAKE) -C graphs/$$dir -f Makefile $@; \
	done

 $(CITIES):
	$(MAKE) -C graphs/$@ -f Makefile
