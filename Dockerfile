# Usa una versión específica de Tomcat con JDK 17
FROM tomcat:10.1.20-jdk17

# Descarga manager y host-manager (versión compatible)
RUN curl -o /usr/local/tomcat/webapps/manager.war \
    https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/manager.war && \
    curl -o /usr/local/tomcat/webapps/host-manager.war \
    https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/host-manager.war

# Instalación segura de paquetes
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server \
    nano \
    vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configuración SSH mejorada
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "root:$(openssl rand -base64 12)" | chpasswd

# Copia configuración de usuarios
COPY conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

# Script de inicialización
COPY init.sh /usr/local/tomcat/init.sh
RUN chmod +x /usr/local/tomcat/init.sh

# Healthcheck para monitoreo
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -sf http://localhost:8080/ || exit 1

EXPOSE 8080 22

# Ejecución en primer plano
CMD ["/usr/local/tomcat/init.sh"]
