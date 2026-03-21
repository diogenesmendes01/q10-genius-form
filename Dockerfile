FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY success.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY app.js /usr/share/nginx/html/

# Custom nginx config for SPA
RUN printf 'server {\n\
    listen 3130;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
\n\
    location ~* \\.(css|js|png|jpg|jpeg|gif|ico|svg|woff2?)$ {\n\
        expires 7d;\n\
        add_header Cache-Control "public, immutable";\n\
    }\n\
\n\
    gzip on;\n\
    gzip_types text/css application/javascript text/html;\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 3130

CMD ["nginx", "-g", "daemon off;"]
