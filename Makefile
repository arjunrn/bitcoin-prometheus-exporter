# Go parameters
GOCMD=go
GSUTILCMD=gsutil
TARCMD=tar
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GSUTILCP=$(GSUTILCMD) cp
TARCOMPRESS=$(TARCMD) czf
GSDEST=gs://prometheus-exporter/bitcoind_exporter.tar.gz
BINARY_NAME=bitcoind_exporter
ARCHIVE_NAME=bitcoind_exporter.tar.gz

all: build

build: 
	$(GOBUILD) -o $(BINARY_NAME) -v

clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(ARCHIVE_NAME)

release:
	$(TARCOMPRESS) $(ARCHIVE_NAME) $(BINARY_NAME)

upload:
	$(GSUTILCP) $(ARCHIVE_NAME) $(GSDEST)
