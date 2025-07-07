# 🚀 Terraform GCP Boilerplates

> **"El camino del artesano"** - Marco Antonio (markitos) - DevsecopsKulture

---

## 🎯 **¿Qué es este repositorio?**

Colección de **boilerplates listos para producción** en Terraform + Google Cloud Platform, diseñados para acelerar el desarrollo siguiendo las mejores prácticas de Infrastructure as Code.

### **Filosofía del proyecto:**
- ⚡ **Velocidad de desarrollo** - Boilerplates listos para usar
- 🏗️ **Arquitectura sólida** - Patrones probados en producción
- 🔒 **Seguridad por defecto** - Configuración segura desde el inicio
- 📋 **Documentación completa** - Cada boilerplate auto-explicado

---

## 📁 **Estructura del repositorio**

```
markitos-terraform-gcp/
├── 001-welcome/            # 🎉 Boilerplate básico - Hello World
├── 002-gcp-bucket/         # 💾 Storage con Cloud Storage
└── 000-assets/             # 🔒 Credenciales compartidas (ignorado)
```

---

## 🏗️ **Boilerplates disponibles**

### **🎉 001-welcome** ⭐ RECOMENDADO
**Descripción:** Boilerplate base perfecto para empezar cualquier proyecto GCP
- ✅ **Variables estandarizadas** con validaciones
- ✅ **Tags automáticos** para todos los recursos
- ✅ **Sin tfvars** - usa env vars o defaults inteligentes
- ✅ **Naming semántico** y consistente
- ✅ **Documentación completa**

**Casos de uso:**
- Punto de partida para cualquier proyecto
- Base para boilerplates más complejos
- Ejemplos de mejores prácticas

### **💾 002-gcp-bucket**
**Descripción:** Gestión de almacenamiento con Cloud Storage
- Creación de buckets GCP
- Configuración de lifecycle policies
- Gestión de permisos y accesos

---

## 🚀 **Uso rápido**

### **1. Elige tu boilerplate**
```bash
# Para empezar rápido
cd 001-welcome

# Para storage
cd 002-gcp-bucket
```

### **2. Configura credenciales**
```bash
# Coloca tu service account key
cp /path/to/your/service-account.json ./key.json

# Activa gitignore
mv dot.gitignore .gitignore
```

### **3. Despliega**
```bash
# Variables requeridas para 001-welcome
TF_VAR_environment_target=dev TF_VAR_group_category=testing terraform init
TF_VAR_environment_target=dev TF_VAR_group_category=testing terraform plan
TF_VAR_environment_target=dev TF_VAR_group_category=testing terraform apply
```

---

## 🏷️ **Sistema de tags estandarizado**

Todos los boilerplates aplican tags consistentes:

```hcl
{
  environment = "dev"                     # Environment target
  creator     = "Marco Antonio - markitos - DevsecopsKulture"
  category    = "networking"              # Business area
  managed_by  = "terraform"              # Always terraform
  project     = "your-gcp-project-id"   # GCP project
}
```

---

## 🔧 **Variables estándar**

### **En todos los boilerplates:**
- `environment_target` - Entorno de despliegue (requerida)
- `group_category` - Categoría del grupo de recursos (requerida)
- `resource_creator_information` - Información del creador (default)
- `project_identifier` - ID del proyecto GCP (default)
- `deployment_region` - Región de despliegue (default)

### **Filosofía de variables:**
- Sin tfvars por defecto
- Variables de entorno para overrides
- Validaciones incluidas
- Defaults para valores comunes

---

## **Mejores prácticas aplicadas**

- Naming consistente y descriptivo
- Seguridad incluida con gitignore automático
- Estructura modular y reutilizable
- Documentación completa en cada boilerplate

---

## 🛠️ **Comandos útiles**

```bash
# En cualquier boilerplate
terraform init      # Inicializar
terraform plan      # Ver cambios
terraform apply     # Aplicar
terraform output    # Ver outputs
terraform destroy   # Limpiar

# Con variables de entorno
export TF_VAR_environment_target=prod
export TF_VAR_group_category=platform
terraform plan
```

---

## 🤝 **Contribuciones**

**Principios para nuevos boilerplates:**
1. Seguir la estructura de 001-welcome
2. Documentación completa obligatoria
3. Variables estándar + específicas
4. Tags estandarizados aplicados
5. Ejemplos prácticos incluidos

**Creado por:** Marco Antonio (markitos) - DevsecopsKulture

---

**¡Construye infraestructura como un artesano! 🚀**

> *"La excelencia no es un acto, sino un hábito"* - Aristóteles
