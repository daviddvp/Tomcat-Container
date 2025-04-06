# 🐱 Tomcat Container

Este proyecto proporciona un contenedor Docker listo para usar con **Apache Tomcat**, un servidor web y contenedor de servlets para aplicaciones Java.

---

## 📖 Descripción

Este contenedor está pensado para facilitar el despliegue, prueba y gestión de aplicaciones web Java. Ofrece una configuración básica de **Apache Tomcat**, fácilmente adaptable y extensible según las necesidades del proyecto.

Ideal para entornos de desarrollo, pruebas o despliegues ligeros en producción.

---

## 📁 Estructura del Proyecto

Distribución aproximada por tecnologías usadas:

- **Java**: 79.9%
- **CSS**: 8.9%
- **XSLT**: 7.5%
- **Dockerfile**: 2.1%
- **Shell**: 1.6%

---

## ✅ Requisitos

- [Docker](https://www.docker.com/)
- [JDK 11+](https://adoptium.net/) (solo si compilas o desarrollas localmente)

---

## 🚀 Uso

### 🏗️ Construcción de la imagen Docker

Para construir la imagen Docker desde el directorio raíz del proyecto:

```bash
docker build -t tomcat-container .
```

Desplegamos con docker compose:

```bash
docker compose up -d