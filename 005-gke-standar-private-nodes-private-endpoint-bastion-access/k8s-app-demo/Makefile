start: stop
	docker compose up --build -d

stop:
	docker compose down
	

publish:
	@version=${version}; \
	if [ -z "$$version" ]; then version=latest; fi; \
	docker build -t us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-database:$$version -f backend/Dockerfile backend; \
	docker build -t us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-frontend:$$version -f frontend/Dockerfile frontend; \
	docker build -t us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-backend:$$version -f backend/Dockerfile backend; \
	docker push us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-database:$$version; \
	docker push us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-frontend:$$version; \
	docker push us-central1-docker.pkg.dev/markitos-es-ops/markitos-public-images/markitos.005-gke-terraform-backend:$$version;
