
# Proyecto Terraform GCP: GKE Estándar Privado + Bastion

## Descripción
Este stack despliega un clúster GKE privado en Google Cloud Platform (GCP), con nodos sin IP pública y acceso seguro mediante una instancia bastion. Incluye la infraestructura de red, reglas de firewall, NAT, bastion y todos los recursos necesarios para operar el clúster de forma segura y aislada.

---

## Acciones disponibles en el Makefile

- `make init`: Inicializa el entorno de Terraform.
- `make plan`: Muestra el plan de ejecución.
- `make apply`: Aplica los cambios definidos en la infraestructura.
- `make destroy`: Elimina la infraestructura creada.
- `make validate`: Valida la sintaxis y configuración.
- `make list`: Lista los recursos gestionados por Terraform.
- `make show`: Muestra detalles de un recurso específico (`make show uri="google_container_cluster.cluster_name"`).
- `make clean`: Elimina archivos y carpetas generados por Terraform.
- `make install-terraform`: Instala la versión recomendada de Terraform.

---

## Variables principales (`variables.tf`)

- `region`: Región de GCP (default: `us-central1`)
- `project_id`: ID del proyecto (default: `markitos-es-ops`)
- `project`: Nombre del proyecto (default: `markitos-es`)
- `environment`: Entorno (`dev`, `staging`, `prod`)
- `team`: Equipo responsable (default: `devops`)
- `network_ssh_tags`: Tags para hosts con acceso SSH
- `firewall_ports`: Puertos permitidos en firewall (default: `["22"]`)
- `subnet_ip_range`, `pods_ip_range`, `services_ip_range`, `master_ip_range`: Rangos de IP para red y clúster

---

## Locales (`locals.tf`)

- `prefix`: Prefijo común para recursos
- `service_account_path`: Ruta al archivo de credenciales
- `network_ssh_tags`: Tags SSH con prefijo personalizado
- `deletion_cluster_protection`: Protección contra eliminación en `prod`
- `cluster_zone_location`, `cluster_node_locations`: Zonas del clúster
- `common_tags`: Tags comunes para todos los recursos

---

## Backend (`versions.tf`)

- **Backend GCS**: Estado de Terraform en Google Cloud Storage
  - `bucket`: `markitos-es-terraform-states`
  - `prefix`: `dev/markitos-es-devops`
- **Provider Google**: Configurado con variables de proyecto, región y credenciales
- **Versiones requeridas**:
  - Terraform: `>= 1.12.0, < 2.0.0`
  - Provider Google: `>= 6.0.0`

---

## Requisitos

- Archivo de credenciales configurado en la ruta indicada en `locals.tf`
- Permisos suficientes en GCP para crear recursos
- Terraform >= 1.12.0

---

## Uso rápido

```bash
make init
make plan
make apply
```

---

## Acceso seguro por IAP al bastion y a los nodos privados

Cuando el clúster y los nodos son privados, el acceso recomendado es mediante el bastion usando IAP (Identity-Aware Proxy). Desde el bastion puedes acceder por SSH a los nodos privados.

**Conexión al bastion:**

```bash
gcloud compute ssh --zone=us-central1-a markitos-es-dev-devops-bastion --tunnel-through-iap --project=markitos-es-ops
```

**Copiar archivos al bastion:**

```bash
gcloud compute scp --zone=us-central1-a --tunnel-through-iap --project=markitos-es-ops archivo1.txt archivo2.sh markitos-es-dev-devops-bastion:~/
```

**SSH a los nodos privados desde el bastion:**

```bash
ssh usuario@ip_privada_nodo
```

O también puedes usar `gcloud compute ssh` desde el bastion, especificando la IP interna del nodo:

```bash
gcloud compute ssh nombre-nodo --zone us-central1-a --internal-ip --project=markitos-es-ops
```

Asegúrate de tener la clave SSH correspondiente en el bastion y que las reglas de firewall permitan el acceso.

**Requisitos:**
- Rol `IAP-secured Tunnel User` y permisos de acceso SSH en el proyecto
- Bastion en la misma VPC/subred que los nodos privados
- Reglas de firewall que permitan tráfico SSH interno (puerto 22) desde el bastion a los nodos

**Referencia:** [Documentación oficial de IAP para SSH](https://cloud.google.com/iap/docs/using-tcp-forwarding)

---

## Permisos del Rol Personalizado

El rol personalizado (`terraformers-custom-role`) debe tener los siguientes permisos asignados:
```
86 assigned permissions

compute.addresses.create
compute.addresses.createInternal
compute.addresses.createTagBinding
compute.addresses.delete
compute.addresses.deleteInternal
compute.addresses.deleteTagBinding
compute.addresses.get
compute.addresses.list
compute.addresses.setLabels
compute.addresses.useInternal
compute.disks.create
compute.firewalls.create
compute.firewalls.createTagBinding
compute.firewalls.delete
compute.firewalls.deleteTagBinding
compute.firewalls.get
compute.firewalls.list
compute.firewalls.listEffectiveTags
compute.firewalls.listTagBindings
compute.firewalls.update
compute.instanceGroupManagers.create
compute.instanceGroupManagers.delete
compute.instanceGroupManagers.get
compute.instanceGroupManagers.list
compute.instanceGroupManagers.update
compute.instances.create
compute.instances.createTagBinding
compute.instances.delete
compute.instances.deleteAccessConfig
compute.instances.deleteNetworkInterface
compute.instances.deleteTagBinding
compute.instances.detachDisk
compute.instances.get
compute.instances.getEffectiveFirewalls
compute.instances.getGuestAttributes
compute.instances.getIamPolicy
compute.instances.getScreenshot
compute.instances.getSerialPortOutput
compute.instances.getShieldedInstanceIdentity
compute.instances.getShieldedVmIdentity
compute.instances.list
compute.instances.listEffectiveTags
compute.instances.listReferrers
compute.instances.listTagBindings
compute.instances.setLabels
compute.instances.setMetadata
compute.instances.setTags
compute.instances.update
compute.networks.create
compute.networks.delete
compute.networks.get
compute.networks.list
compute.networks.update
compute.networks.updatePolicy
compute.routers.create
compute.routers.delete
compute.routers.get
compute.routers.getRoutePolicy
compute.routers.update
compute.subnetworks.create
compute.subnetworks.delete
compute.subnetworks.get
compute.subnetworks.list
compute.subnetworks.update
compute.subnetworks.use
compute.zones.get
compute.zones.list
container.clusters.create
container.clusters.delete
container.clusters.get
container.clusters.list
container.clusters.update
container.operations.get
container.operations.list
iam.serviceAccounts.create
iam.serviceAccounts.delete
iam.serviceAccounts.get
iam.serviceAccounts.list
iam.serviceAccounts.update
storage.objects.create
storage.objects.delete
storage.objects.get
storage.objects.getIamPolicy
storage.objects.list
storage.objects.setIamPolicy
storage.objects.setRetention
```

---

## Autor

**Marco Antonio - markitos**  
DevSecOps Kulture  
El Camino del Artesano

---

## Licencia

MIT License  
Este proyecto se distribuye bajo la licencia MIT. Puedes usar, modificar, copiar y distribuir el código libremente, con o sin fines comerciales, siempre que se conserve el aviso de copyright y la licencia original.

---
