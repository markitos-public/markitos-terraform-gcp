# 🚀 Terraform GCP Stacks - Boilerplate Multi-Project

Bienvenido a este repositorio que reúne varios stacks independientes de infraestructura en Google Cloud Platform (GCP) usando Terraform. Cada subproyecto está documentado y listo para usarse de forma modular, siguiendo el "Camino del Artesano" y las mejores prácticas DevSecOps.

---

## 📚 Índice de Stacks

Cada stack es autónomo y tiene su propio README con instrucciones detalladas. Puedes navegar a cada uno para ver ejemplos, variables, outputs y recomendaciones específicas.

| Stack | Descripción | Enlace |
|-------|-------------|--------|
| **001-welcome** | Boilerplate base para iniciar proyectos Terraform en GCP. Incluye buenas prácticas, naming, validaciones y tags estandarizados. | [Ver README](./001-welcome/README.md) |
| **002-gcp-bucket** | Ejemplo de despliegue de un bucket de almacenamiento en GCP. Ideal para aprender sobre recursos de storage. | [Ver README](./002-gcp-bucket/README.md) |
| **003-gcp-vpc** | Stack para crear una VPC en GCP, con Makefile para automatizar tareas y variables configurables. | [Ver README](./003-gcp-vpc/README.md) |
| **004-gke-standar-private-nodes-public-endpoint** | Despliega un clúster GKE con nodos privados y endpoint público, incluyendo red, roles y cuentas de servicio. | [Ver README](./004-gke-standar-private-nodes-public-endpoint/README.md) |
| **005-gke-standar-private-nodes-private-endpoint-bastion-access** | Stack avanzado para GKE privado con acceso seguro vía bastión, redes privadas y protección de recursos. | [Ver README](./005-gke-standar-private-nodes-private-endpoint-bastion-access/README.md) |

---

## 🛠️ Requisitos Generales

- Terraform >= 1.12.0
- Cuenta y credenciales de GCP (Service Account con permisos adecuados)
- Google Cloud SDK (opcional para pruebas locales)
- Make instalado para automatización (opcional)

---

## 🧩 Filosofía y Buenas Prácticas

- **Simplicidad y modularidad:** Cada stack es independiente y puede usarse por separado.
- **Naming semántico y tags estandarizados:** Facilita la gestión y el monitoreo.
- **Validaciones robustas:** Prevención de errores comunes antes del despliegue.
- **Seguridad:** Gitignore completo, credenciales protegidas, state files ignorados.
- **Documentación clara:** Cada stack tiene ejemplos, variables y outputs explicados.

---

## 🚦 ¿Cómo empezar?

1. Elige el stack que necesitas y revisa su README.
2. Configura tus credenciales y variables según las instrucciones.
3. Usa los comandos del Makefile para inicializar, planificar y aplicar la infraestructura.
4. Consulta los outputs y verifica los recursos creados en GCP.

---

## 🤝 Autoría y Comunidad

Creado por **Marco Antonio (markitos)**  
DevSecOps Kulture  
El Camino del Artesano

---

## 📄 Licencia

Uso interno y educativo.  
Puedes adaptar los stacks según tus necesidades y contribuir mejoras siguiendo la filosofía del proyecto.

---

¿Listo para construir infraestructura como código en GCP?  
> *"La simplicidad es la máxima sofisticación"* — Leonardo da Vinci

---

## 🔐 Acceso seguro por IAP al bastion y a los nodos privados

Cuando todo el clúster y los nodos son privados, la forma recomendada de acceso es mediante el bastion usando IAP (Identity-Aware Proxy). Desde el bastion, puedes acceder por SSH a los nodos privados.

Conéctate al bastion usando:

```bash
gcloud compute ssh --zone=us-central1-a markitos-es-dev-devops-bastion --tunnel-through-iap --project=markitos-es-ops
```

Una vez dentro del bastion, podrás hacer SSH a los nodos privados del clúster, siempre que tengas las claves y permisos necesarios.

### 📦 Copiar archivos al bastion usando IAP

Puedes enviar uno o más ficheros al bastion con:

```bash
gcloud compute scp --zone=us-central1-a --tunnel-through-iap --project=markitos-es-ops archivo1.txt archivo2.sh markitos-es-dev-devops-bastion:~/
```

Esto copiará los archivos al directorio home del bastion. Puedes usar rutas relativas o absolutas según necesites.

**Requisitos:**
- El usuario debe tener el rol `IAP-secured Tunnel User` y permisos de acceso SSH en el proyecto.
- El bastion debe estar en la misma VPC/subred que los nodos privados.
- Las reglas de firewall deben permitir el tráfico SSH interno (puerto 22) desde el bastion a los nodos.

**Referencia:** [Documentación oficial de IAP para SSH](https://cloud.google.com/iap/docs/using-tcp-forwarding)

---
