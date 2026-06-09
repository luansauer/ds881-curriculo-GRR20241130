# Dockerfile — DS881 Currículo Online
# Serve o site estático (HTML/CSS puro) via nginx na porta 8080.
# Não exige Node.js nem Ruby instalados no host.

FROM nginx:1.27-alpine

# Remove a config padrão do nginx e copia a nossa
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia o site para o diretório padrão do nginx
WORKDIR /usr/share/nginx/html
COPY index.html style.css ./

# Expõe a porta 8080 (mapeada pelo Compose para o host)
EXPOSE 8080
