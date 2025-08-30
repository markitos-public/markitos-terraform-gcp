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