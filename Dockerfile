FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY success.html /usr/share/nginx/html/
COPY matricula.css /usr/share/nginx/html/
COPY app.js /usr/share/nginx/html/

RUN printf 'server {\n\
    listen 3130;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
        add_header Cache-Control "no-cache, no-store, must-revalidate";\n\
        add_header Pragma "no-cache";\n\
    }\n\
\n\
    location ~* \\.(css|js)$ {\n\
        add_header Cache-Control "no-cache, must-revalidate";\n\
        etag on;\n\
    }\n\
\n\
    gzip on;\n\
    gzip_types text/css application/javascript text/html;\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 3130

CMD ["nginx", "-g", "daemon off;"]
