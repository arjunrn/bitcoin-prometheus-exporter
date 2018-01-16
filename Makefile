# Go parameters
GOCMD=go
GLIDECMD=glide
GSUTILCMD=gsutil
TARCMD=tar
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GSUTILCP=$(GSUTILCMD) cp
TARCOMPRESS=$(TARCMD) czf
GSDEST=gs://prometheus-exporter/bitcoind_exporter.tar.gz
GLIDEINSTALL=$(GLIDECMD) install
BINARY_NAME=bitcoind_exporter
ARCHIVE_NAME=bitcoind_exporter.tar.gz

all: build

build: 
	$(GOBUILD) -o $(BINARY_NAME) -v
deps:
	$(GLIDEINSTALL)
clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(ARCHIVE_NAME)

release:
	$(TARCOMPRESS) $(ARCHIVE_NAME) $(BINARY_NAME)
	$(GSUTILCP) $(ARCHIVE_NAME) $(GSDEST)

