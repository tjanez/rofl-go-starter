package main

import (
    "log"
    "time"
)

func main() {
    log.SetFlags(log.LUTC | log.Ldate | log.Ltime)
    log.Println("rofl-go-starter: hello from TDX")
    for {
        time.Sleep(10 * time.Second)
        log.Println("rofl-go-starter: heartbeat")
    }
}
