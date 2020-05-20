## Bitcoind Prometheus Exporter

This project provides a simple exporter for a bitcoin node to export metrics in the [Prometheus format](https://prometheus.io/docs/instrumenting/exposition_formats/#text-format-details).

To build the binary run the command:

```bash
make
```

To copy the built binary to the storage run the command:

```bash
make release
```

### Running the exporter:
The exporter can be run by passing the the RPC username, password and host to the binary like so:

```bash
BTC_USER=btcuser BTC_PASS=btcpass BTC_HOST=127.0.0.1:8332 ./bitcoind_exporter
```
