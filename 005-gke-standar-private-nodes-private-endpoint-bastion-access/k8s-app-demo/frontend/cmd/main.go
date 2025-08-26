package main

import (
	"encoding/json"
	"html/template"
	"net/http"
	"os"
	"time"
)

var tpl = `<html><head><title>Frontend</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"></head><body class="container"><h1 class="mt-5">Ping Service</h1><form method="POST"><button class="btn btn-primary" type="submit">Ping Backend</button></form>{{if .Pong}}<div class="alert alert-success mt-3">Pong: {{.Pong}}</div>{{end}}</body></html>`

type PageData struct {
	Pong string
}

func main() {
	backendURL := os.Getenv("BACKEND_URL")
	if backendURL == "" {
		backendURL = "http://markitos.005-gke-terraform-backend:8080/api/ping"
	}
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := PageData{}
		if r.Method == http.MethodPost {
			resp, err := http.Get(backendURL)
			if err == nil {
				var res map[string]interface{}
				json.NewDecoder(resp.Body).Decode(&res)
				resp.Body.Close()
				if v, ok := res["pong"]; ok {
					if t, ok := v.(string); ok {
						data.Pong = t
					} else {
						data.Pong = time.Now().UTC().Format(time.RFC3339)
					}
				}
			}
		}
		tmpl := template.Must(template.New("").Parse(tpl))
		tmpl.Execute(w, data)
	})
	http.ListenAndServe(":8081", nil)
}
