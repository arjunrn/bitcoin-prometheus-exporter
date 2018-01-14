package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	"github.com/btcsuite/btcd/rpcclient"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Logger
func initLogger(infoHandle io.Writer) *log.Logger {
	return log.New(infoHandle, "INFO:", log.Ldate|log.Ltime|log.Lshortfile)
}

func getEnv(name string) string {
	envValue, ok := os.LookupEnv(name)
	if ok {
		return envValue
	}
	panic(fmt.Sprintf("Missing environment variable: %s", name))
}

func main() {
	initLogger(os.Stdout)
	btcUser := getEnv("BTC_USER")
	btcPass := getEnv("BTC_PASS")
	btcHost := getEnv("BTC_HOST")
	config := &rpcclient.ConnConfig{
		Host:         btcHost,
		User:         btcUser,
		Pass:         btcPass,
		DisableTLS:   true,
		HTTPPostMode: true,
	}
	client, err := rpcclient.New(config, nil)
	if err != nil {
		panic(err)
	}
	defer client.Shutdown()
	blockCount, err := client.GetBlockCount()
	if err != nil {
		panic(err)
	}
	blockCountGauge := prometheus.NewGauge(prometheus.GaugeOpts{
		Namespace: "bitcoind",
		Subsystem: "nodestats",
		Name:      "blockcount",
		Help:      "Block Count in the Node",
	})
	prometheus.MustRegister(blockCountGauge)
	blockCountGauge.Set(float64(blockCount))
	http.Handle("/metrics", promhttp.Handler())
	fmt.Printf("Block Count: %d\n", blockCount)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
