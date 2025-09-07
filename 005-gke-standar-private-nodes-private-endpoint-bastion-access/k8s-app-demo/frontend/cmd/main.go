package main

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"os"
	"time"
)

var tpl = `<html><head><title>Frontend</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"></head><body class="container"><h1 class="mt-5">Ping Service</h1>
<form id="pingForm" method="POST"><button class="btn btn-primary" type="submit">Ping Backend</button></form>
<div id="pongServer">{{if .Pong}}<div class="alert alert-success mt-3">Pong: {{.Pong}}</div>{{end}}</div>
<div id="pongClient" class="d-none alert alert-success mt-3"></div>

<script>
	(function(){
		const backendURL = "{{.BackendURL}}";
		const form = document.getElementById('pingForm');
		const pongClient = document.getElementById('pongClient');
		form.addEventListener('submit', async function(e){
			e.preventDefault();
			try {
				const resp = await fetch(backendURL, {method: 'GET'});
				if (!resp.ok) throw new Error('bad response');
				const json = await resp.json();
				const pong = json.pong || new Date().toISOString();
				pongClient.textContent = 'Pong: ' + pong;
				pongClient.classList.remove('d-none');
				// keep URL the same; no reload required
			} catch (err) {
				pongClient.textContent = 'Error calling backend';
				pongClient.classList.remove('d-none');
			}
		});
	})();
</script>
</body></html>`

type PageData struct {
	Pong       string
	BackendURL string
}

func main() {
	backendURL := os.Getenv("BACKEND_URL")
	log.Println("final Backend URL:", backendURL)
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := PageData{BackendURL: backendURL}
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
