# 004-gke-standar-private-nodes-public-endpoint

## Descripción
Este proyecto utiliza **Terraform** para desplegar un clúster de Google Kubernetes Engine (GKE) en Google Cloud Platform (GCP) con nodos privados y un endpoint público. El stack está diseñado para crear la infraestructura de red, roles personalizados, cuentas de servicio y todos los recursos necesarios para operar un clúster GKE seguro y funcional.

## Stack Tecnológico
- **Terraform**: Orquestación de infraestructura como código.
- **Google Cloud Platform (GCP)**: Proveedor de nube donde se despliega la infraestructura.
- **GKE (Google Kubernetes Engine)**: Servicio de Kubernetes administrado.

## ¿Qué hace este proyecto?
- Crea una red VPC y subredes en GCP.
- Despliega un clúster GKE con nodos privados y acceso público al endpoint de Kubernetes.
- Configura reglas de firewall, routers y otros recursos de red.
- Crea un rol personalizado en GCP con permisos específicos para operar la infraestructura.
- Asigna el rol personalizado a una cuenta de servicio y genera una clave en formato JSON para autenticación.

## Requisitos
- Tener una cuenta en Google Cloud Platform con permisos para crear recursos.
- Instalar [Terraform](https://www.terraform.io/downloads.html).
- Instalar [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (opcional, para pruebas locales).

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

## Uso del Makefile
## Explicación del Makefile
El `Makefile` incluido en este proyecto simplifica la ejecución de los comandos más comunes de Terraform. A continuación se explica cada uno de sus objetivos:

- **init**: Inicializa el directorio de trabajo de Terraform, descargando los proveedores y configurando el backend.
- **plan**: Muestra el plan de ejecución de Terraform, indicando los cambios que se aplicarán en la infraestructura.
- **apply**: Aplica los cambios definidos en los archivos de Terraform de forma automática (sin pedir confirmación).
- **destroy**: Elimina todos los recursos creados por Terraform en el proyecto, también de forma automática.
- **validate**: Valida la sintaxis y la configuración de los archivos de Terraform.
- **list**: Lista todos los recursos gestionados actualmente en el estado de Terraform.
- **show**: Muestra información detallada de cualquier recurso gestionado por Terraform. Este comando requiere definir el parámetro `uri`, que corresponde al nombre completo del recurso tal como aparece en el estado. Puedes obtener la lista de recursos con `make list` y luego usar uno de ellos como argumento.

Ejemplo de uso:
```bash
make list
# Supongamos que aparece 'google_container_cluster.my_cluster'
make show uri=google_container_cluster.my_cluster
```
- **clean**: Elimina archivos y carpetas generados por Terraform, incluyendo el estado local y la configuración interna.

Este Makefile es útil para automatizar tareas y evitar errores de tipeo en los comandos más frecuentes.
No es necesario modificar el `Makefile` para indicar la ruta de la clave JSON. La ruta debe especificarse directamente en el archivo `variables.tf` mediante la variable correspondiente.

Ejemplo:
```hcl
variable "credentials_file" {
	description = "Ruta al archivo de la clave JSON del service account"
	type        = string
	default     = "/ruta/a/tu/service-account-key.json"
}
```

Recuerda cambiar `/ruta/a/tu/service-account-key.json` por la ruta real donde guardaste la clave JSON generada para la cuenta de servicio con el rol personalizado.

## Variables principales
Las variables de configuración se encuentran en el archivo `variables.tf`. Puedes personalizar el nombre del clúster, la red, las regiones, el tipo de máquina, entre otros parámetros.

## Salidas
Las salidas principales del despliegue se encuentran en el archivo `outputs.tf`, incluyendo información relevante del clúster y la red creada.

## Estructura de archivos
- `datas.tf`: Definiciones de datos externos.
- `gke.tf`: Recursos del clúster GKE.
- `locals.tf`: Variables locales.
- `network.tf`: Recursos de red (VPC, subredes, firewalls, routers).
- `outputs.tf`: Salidas del despliegue.
- `variables.tf`: Variables de configuración.
- `versions.tf`: Versiones requeridas de proveedores y Terraform.
- `Makefile`: Automatización de comandos.

## Referencias

## Backend de Terraform
Esta versión utiliza **backend local** para almacenar el estado de Terraform. Si deseas utilizar un backend remoto en Google Cloud Storage (GCS), añade el siguiente bloque al archivo `versions.tf` o crea un archivo `backend.tf`:

```hcl
terraform {
	backend "gcs" {
		bucket  = "<nombre-del-bucket>"
		prefix  = "<ruta/opcional/al/estado>"
		project = "<id-del-proyecto>"
		credentials = var.credentials_file
	}
}
```

Reemplaza los valores entre `< >` por los datos de tu proyecto y bucket.

- [Documentación oficial de Terraform GCP](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Documentación de GKE](https://cloud.google.com/kubernetes-engine/docs)

---

**Autor:**
Marco Antonio - markitos devsecops kulture
El Camino del Artesano

