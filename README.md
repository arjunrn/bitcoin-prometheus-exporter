## Bitcoind Prometheus Exporter

This project provides a simple exporter for a bitcoin node to export metrics in the [Prometheus format](https://prometheus.io/docs/instrumenting/exposition_formats/#text-format-details).

To build the project you need to have the following dependencies installed:
1. [Go Compiler](https://golang.org/cmd/go/)
2. [Glide](https://github.com/Masterminds/glide)

To download the dependencies run the following command:

```bash
make deps
```

This will download and install the dependencies in the _vendor_ directory. Then to build the binary run the command:

```bash
make
```

To copy the built binary to the storage run the command:

```bash
make release
```

