# Azure VNet Peering & Key Vault Infrastructure with Terraform

## 🚀 Visión General
Este repositorio contiene un proyecto de Infraestructura como Código (IaC) construido con **Terraform** para aprovisionar un entorno seguro e interconectado en **Microsoft Azure**. 

El objetivo principal de este proyecto es demostrar la capacidad de desplegar topologías de red, implementar una gestión segura de secretos y automatizar el aprovisionamiento de máquinas virtuales utilizando las mejores prácticas de la industria. Ideal para demostrar conocimientos en Cloud Computing y DevOps.

## 🏗️ Arquitectura y Características
La infraestructura aprovisiona los siguientes recursos:
- **Grupo de Recursos**: Un contenedor centralizado (`proyecto_peering`) en la región `spain central` para agrupar todos los recursos.
- **Redes Virtuales (VNets) y Subredes**: Dos VNets distintas (`vnet1` y `vnet2`) con sus respectivas subredes para simular entornos de red aislados.
- **VNet Peering (Emparejamiento de Redes)**: Una conexión bidireccional entre las dos VNets, permitiendo una comunicación privada, segura y fluida entre las máquinas virtuales como si estuvieran en la misma red local.
- **Azure Key Vault**: Almacenamiento centralizado y seguro para información confidencial. Asigna dinámicamente políticas de acceso al usuario que despliega la infraestructura y almacena la contraseña de administrador de las máquinas virtuales.
- **Máquinas Virtuales**: Dos VMs con Ubuntu Server 22.04 LTS, desplegadas en cada una de las subredes. Obtienen su contraseña de administrador de forma segura y directa desde el Key Vault durante su creación.

## 📂 Estructura del Proyecto
- `provieder.tf`: Define el proveedor de Azure (`azurerm`), las versiones requeridas y configuraciones específicas como la protección de borrado en Key Vault.
- `network.tf`: Contiene las definiciones de las Redes Virtuales, Subredes y las conexiones bidireccionales de VNet Peering.
- `keyvaul.tf`: Aprovisiona el Azure Key Vault, establece políticas de acceso dinámicas utilizando `azurerm_client_config` para no exponer IDs, y crea el secreto para almacenar la contraseña de las VMs.
- `vm.tf`: Automatiza la creación de las Interfaces de Red (NICs) y las Máquinas Virtuales, distribuyéndolas entre las subredes y extrayendo la contraseña del Key Vault.
- `variable.tf`: Parametriza el proyecto (ubicaciones, nombres, cantidad de VMs y contraseñas sensibles) para hacer el código modular y reutilizable.
- `outputs.tf`: Muestra información crítica post-despliegue, como los nombres de las VMs, sus IPs privadas y la URI del Key Vault.

## 🛠️ Tecnologías y Herramientas
- **Terraform (HCL)**: Para la automatización de la infraestructura y gestión del estado.
- **Microsoft Azure**: Proveedor de la nube (Redes, Cómputo y Seguridad).
- **Azure CLI**: Para la autenticación y gestión del entorno de despliegue.

## 💡 Aprendizajes Clave y Mejores Prácticas Demostradas
- **Seguridad desde el Diseño**: Cero credenciales en texto plano. Las contraseñas se tratan como variables sensibles y se almacenan directamente en Azure Key Vault.
- **Fuentes de Datos Dinámicas**: Uso de `data "azurerm_client_config"` para obtener automáticamente los IDs de tenant y de objeto, evitando codificar IDs de la organización en el repositorio.
- **Escalabilidad y Modularidad**: Uso de funciones de Terraform como `count` y `element` para escalar dinámicamente el número de VMs y distribuirlas en las subredes disponibles.
- **Arquitectura de Red**: Implementación práctica de VNet Peering para conectar espacios de red separados de manera eficiente.

