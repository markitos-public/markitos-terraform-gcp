package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net"
	"net/http"
	"os"
	"time"

	_ "github.com/glebarez/sqlite"
)

type Ping struct {
	ID        int       `json:"id"`
	IP        string    `json:"ip"`
	CreatedAt time.Time `json:"createdAt"`
}

func main() {
	dbPath := "/tmp/app.db"
	db, err := sql.Open("sqlite", dbPath)
	if err != nil {
		os.Exit(1)
	}
	defer db.Close()
	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS pings (id INTEGER PRIMARY KEY AUTOINCREMENT, ip TEXT, createdAt DATETIME NOT NULL)`)
	if err != nil {
		os.Exit(1)
	}

	http.HandleFunc("/api/ping", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusOK)
			return
		}

		ip, _, _ := net.SplitHostPort(r.RemoteAddr)
		createdAt := time.Now().UTC()
		var id int
		err := db.QueryRow(`INSERT INTO pings (ip, createdAt) VALUES ($1, $2) RETURNING id`, ip, createdAt).Scan(&id)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		resp := map[string]interface{}{"pong": createdAt}
		log.Println("BACKEND:", resp)
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(resp)
	})
	http.ListenAndServe(":8080", nil)
}
