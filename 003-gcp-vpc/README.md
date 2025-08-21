# Proyecto Terraform GCP VPC

## Descripción
Este proyecto permite desplegar una VPC en Google Cloud Platform (GCP) utilizando Terraform. Está diseñado para ser sencillo y reutilizable en diferentes entornos.

## Requisitos
- Tener instalado Terraform (puedes usar la acción `make install-terraform` para instalar la versión recomendada).
- Contar con un Service Account (SA) en GCP con una key (archivo JSON) y un rol personalizado con los permisos necesarios para la gestión de VPC.
- Guardar la key del SA y configurar la variable `credentials_file_path` en el archivo `variables.tf`:

```hcl
variable "credentials_file_path" {
  description = "Relative path to the GCP service account credentials JSON file from project root"
  type        = string
  default     = "/path/to/key.json"
}
```

## Uso del Makefile
Las siguientes acciones están disponibles:

- `make init`: Inicializa el proyecto Terraform.
- `make reinit`: Inicializa y actualiza los módulos/providers.
- `make plan`: Muestra el plan de ejecución.
- `make apply`: Aplica los cambios.
- `make aapply`: Aplica los cambios automáticamente (sin confirmación).
- `make validate`: Valida la sintaxis y configuración.
- `make format`: Formatea los archivos `.tf`.
- `make version`: Muestra la versión de Terraform.
- `make destroy`: Elimina la infraestructura creada.
- `make adestroy`: Elimina la infraestructura automáticamente (sin confirmación).
- `make show`: Muestra el estado actual del proyecto y los recursos creados. También puedes mostrar información detallada de un recurso específico usando su URI:
  ```bash
  make show uri="google_compute_network.default"
  # O directamente:
  terraform state show google_compute_network.default
  ```
  Es necesario pasar el parámetro `uri` para ver el detalle de un recurso concreto.
- `make clean`: Limpia archivos temporales y estados locales.
- `make install-terraform`: Instala Terraform en tu entorno local.

### Uso avanzado de `make show`
Puedes usar parámetros para mostrar detalles de algún recurso específico, por ejemplo:
```bash
terraform show -json | jq '.values.root_module.resources[] | select(.type=="google_compute_network")'
```
Esto permite ver información detallada de la VPC creada.

## Variables principales
- `credentials_file_path`: Ruta relativa al archivo JSON de credenciales del Service Account de GCP.
- `project_identifier`: Identificador único del proyecto en GCP.
- `project_name`: Nombre del proyecto para prefijar recursos.
- `deployment_region`: Región de despliegue.
- `deployment_zone`: Zona de despliegue.
- `environment_target`: Entorno objetivo (`dev`, `prod`, `pre`, `staging`, `qa`).
- `resource_creator_information`: Información del creador de la infraestructura.

## Autenticación
Es necesario crear un Service Account en GCP, asignarle un rol personalizado con los permisos requeridos y descargar la key en formato JSON. Esta key debe ser referenciada en la variable `credentials_file_path`.

## Autor
Marco Antonio - markitos
DevSecOps Kulture
El Camino del Artesano
