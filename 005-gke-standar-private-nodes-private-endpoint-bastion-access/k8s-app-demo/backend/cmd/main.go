package main

import (
	"database/sql"
	"encoding/json"
	"net"
	"net/http"
	"os"
	"time"

	_ "github.com/lib/pq"
)

type Ping struct {
	ID        int       `json:"id"`
	IP        string    `json:"ip"`
	CreatedAt time.Time `json:"createdAt"`
}

func main() {
	connStr := "postgres://admin:admin@postgres:5432/postgres?sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		os.Exit(1)
	}
	defer db.Close()
	_, err = db.Exec(`CREATE TABLE IF NOT EXISTS pings (id SERIAL PRIMARY KEY, ip TEXT, createdAt TIMESTAMP NOT NULL)`)
	if err != nil {
		os.Exit(1)
	}
	http.HandleFunc("/api/ping", func(w http.ResponseWriter, r *http.Request) {
		ip, _, _ := net.SplitHostPort(r.RemoteAddr)
		createdAt := time.Now().UTC()
		var id int
		err := db.QueryRow(`INSERT INTO pings (ip, createdAt) VALUES ($1, $2) RETURNING id`, ip, createdAt).Scan(&id)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		resp := map[string]interface{}{"pong": createdAt}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(resp)
	})
	http.ListenAndServe(":8080", nil)
}
