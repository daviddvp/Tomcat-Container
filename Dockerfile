FROM tomcat:latest

<<<<<<< HEAD
=======
# Descargar manager y host-manager
RUN curl -o /usr/local/tomcat/webapps/manager.war https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/manager.war && \
    curl -o /usr/local/tomcat/webapps/host-manager.war https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/extras/host-manager.war

<<<<<<< HEAD
<<<<<<< HEAD

>>>>>>> 63ab055 (Test)
=======
>>>>>>> 4e49d1f (Some edits to make this work fine)
# Instalar OpenSSH, Nano y Vim
RUN apt-get update && apt-get install -y \
    openssh-server nano vim \
    && rm -rf /var/lib/apt/lists/*
=======
# Instalar OpenSSH, nano y vim
RUN apt-get update && apt-get install -y openssh-server nano vim && rm -rf /var/lib/apt/lists/*
>>>>>>> ecdd75b (I think now its fine)

# Configurar SSH con la contraseña desde el argumento
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
# Exponer los puertos (Tomcat y SSH)
EXPOSE 8080 22

# Ejecutar SSH y Tomcat
CMD service ssh start && catalina.sh run

# Ejecutar dockerfile
# podman build -t tomcat-container .
=======
# Crear manager: copiamos usuarios
COPY tomcat-users.xml /usr/local/tomcat/conf/
=======
# Copiar tomcat-users.xml (solo una vez, asegurándote que es el correcto)
=======
# Copiar tomcat-users.xml (sin volumen externo, para poder modificarlo)
>>>>>>> ecdd75b (I think now its fine)
COPY conf/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
>>>>>>> 4e49d1f (Some edits to make this work fine)

# Copiar y dar permisos al init.sh
COPY init.sh /usr/local/tomcat/init.sh
RUN chmod +x /usr/local/tomcat/init.sh

# Puertos
EXPOSE 8080 22

<<<<<<< HEAD
<<<<<<< HEAD

# Iniciar SSH y Tomcat
CMD service ssh start && catalina.sh run

# Para construir la imagen:
# docker build -t tomcat-container .  
>>>>>>> 63ab055 (Test)
=======
# Iniciar SSH y Tomcat con el entrypoint.sh
CMD ["/entrypoint.sh"]
>>>>>>> 4e49d1f (Some edits to make this work fine)
=======
# Comando final
CMD ["/usr/local/tomcat/init.sh"]
>>>>>>> ecdd75b (I think now its fine)
