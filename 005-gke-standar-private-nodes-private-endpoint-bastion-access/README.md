# Proyecto Terraform GCP: GKE Estándar Privado


## Descripción
Este proyecto implementa una infraestructura en Google Cloud Platform (GCP) utilizando Terraform, enfocada en la creación de un clúster GKE privado, redes privadas y acceso mediante bastión.

---

## Acciones disponibles en el Makefile

- **init**: Inicializa el entorno de Terraform.
- **plan**: Muestra el plan de ejecución de Terraform.
- **apply**: Aplica los cambios definidos en la infraestructura.
- **destroy**: Elimina la infraestructura creada.
- **validate**: Valida la sintaxis y configuración de los archivos Terraform.
- **list**: Lista los recursos gestionados por Terraform.
- **show**: Muestra detalles de un recurso específico del estado de Terraform. Requiere el parámetro `uri`, por ejemplo:
  ```bash
  make show uri="google_container_cluster.cluster_name"
  ```
- **clean**: Elimina archivos y carpetas generados por Terraform.
- **install-terraform**: Instala la versión 1.12.2 de Terraform en el sistema.

---

## Variables definidas (`variables.tf`)

- **region**: Región de GCP donde se desplegarán los recursos. (default: `us-central1`)
- **project_id**: ID del proyecto de GCP. (default: `project-name-ops`)
- **project**: Nombre del proyecto. (default: `project-name`)
- **environment**: Entorno de despliegue (dev, staging, prod). (default: `dev`)
- **team**: Equipo responsable. (default: `devops`)
- **network_ssh_tags**: Lista de tags para hosts con acceso SSH. (default: `["ssh-host"]`)
- **firewall_ports**: Puertos permitidos en reglas de firewall. (default: `["22"]`)
- **subnet_ip_range**: Rango de IP para la subred. (default: `10.129.0.0/21`)
- **pods_ip_range**: Rango de IP para los pods. (default: `10.11.0.0/21`)
- **services_ip_range**: Rango de IP para los servicios. (default: `10.12.0.0/21`)
- **master_ip_range**: Rango de IP para el master. (default: `10.13.0.0/28`)

---

## Locales definidos (`locals.tf`)

- **prefix**: Prefijo común para recursos, formado por proyecto, entorno y equipo.
- **service_account_path**: Ruta al archivo de credenciales del service account.
- **network_ssh_tags**: Tags de SSH con prefijo personalizado.
- **deletion_cluster_protection**: Protección contra eliminación en entorno `prod`.
- **cluster_zone_location**: Zona principal del clúster.
- **cluster_node_locations**: Zonas secundarias para nodos.
- **common_tags**: Tags comunes para todos los recursos.

---

## Configuración del backend (`versions.tf`)

- **Backend GCS**: Utiliza Google Cloud Storage para almacenar el estado de Terraform.
  - **bucket**: `project-name-terraform-states`
  - **prefix**: `dev/project-name-devops`
- **Provider Google**: Configurado con las variables de proyecto, región y credenciales.
- **Versiones requeridas**:
  - **Terraform**: `>= 1.12.0, < 2.0.0`
  - **Provider Google**: `>= 6.0.0`

---

## Requisitos
- Tener configurado el archivo de credenciales en la ruta indicada en `locals.tf`.
- Acceso a GCP y permisos suficientes para crear recursos.
- Terraform >= 1.12.0

---

## Uso rápido
```bash
make init
make plan
make apply
```

---

## Permisos del Rol Personalizado
El rol personalizado (`terraformers-custom-role`) debe tener los siguientes permisos asignados:

```
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

## Autor
**Marco Antonio - markitos**  
DevSecOps Kulture  
El Camino del Artesano


---

## Licencia
Uso interno y educativo.

---
