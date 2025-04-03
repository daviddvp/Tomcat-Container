FROM tomcat:latest

# Instalar OpenSSH, Nano y Vim
RUN apt-get update && apt-get install -y \
    openssh-server nano vim \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir /var/run/sshd && echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exponer los puertos (Tomcat y SSH)
EXPOSE 8080 22

# Ejecutar SSH y Tomcat
CMD service ssh start && catalina.sh run

# Ejecutar dockerfile
# podman build -t tomcat-container .