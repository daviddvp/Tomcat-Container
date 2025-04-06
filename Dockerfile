FROM tomcat:10.1.20-jdk17

# Descargar manager y host-manager
RUN curl -o /usr/local/tomcat/webapps/manager.war https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/manager.war && \
    curl -o /usr/local/tomcat/webapps/host-manager.war https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/host-manager.war

# Instalación con versión específica y sin paquetes recomendados (corrige DL3008 y DL3015)
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server=1:9.2p1-2 \
    nano=7.2-1 \
    vim=2:9.0.1378-2 && \
    rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Copiar usuarios de Tomcat
COPY conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

# Copiar y dar permisos al script de inicialización
COPY init.sh /usr/local/tomcat/init.sh
RUN chmod +x /usr/local/tomcat/init.sh

# Exponer puertos
EXPOSE 8080 22

# Comando de inicio
CMD ["/usr/local/tomcat/init.sh"]
