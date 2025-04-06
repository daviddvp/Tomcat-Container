#!/bin/bash

# Debug: Mostrar las variables si existen
echo "==> Entrypoint iniciado..."
echo "TOMCAT_USER: $TOMCAT_USER"
echo "TOMCAT_PASS: $TOMCAT_PASS"
echo "ROOT_PASS: ${ROOT_PASS:+"********"}"

# Validar que existe ROOT_PASS
if [ -z "$ROOT_PASS" ]; then
  echo "❌ ERROR: ROOT_PASS no está definido en el entorno."
  exit 1
fi

# Configurar la contraseña de root para SSH
echo "==> Configurando contraseña de root para SSH..."
echo "root:$ROOT_PASS" | chpasswd

# Sustituir las credenciales de Tomcat
if [ -n "$TOMCAT_USER" ] && [ -n "$TOMCAT_PASS" ]; then
  echo "==> Sustituyendo credenciales en tomcat-users.xml"
  sed -i "s/\${TOMCAT_USER}/$TOMCAT_USER/" /usr/local/tomcat/conf/tomcat-users.xml
  sed -i "s/\${TOMCAT_PASS}/$TOMCAT_PASS/" /usr/local/tomcat/conf/tomcat-users.xml
else
  echo "⚠️  TOMCAT_USER o TOMCAT_PASS no están definidas. No se sustituyen credenciales en tomcat-users.xml"
fi

# Iniciar SSH y Tomcat
echo "✅ Iniciando SSH..."
/usr/sbin/sshd

echo "✅ Iniciando Tomcat..."
exec catalina.sh run
