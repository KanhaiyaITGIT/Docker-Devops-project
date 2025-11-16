FROM nginx
COPY index.html /usr/share/nginx/html
EXPOSE 80
LABEL maintainer="kanhaiya"
LABEL project="Docker demo site"
HEALTHCHECK --interval 10s --timeout 30s --retries 3 \
   cmd curl -f http://localhost/ || exit 1

CMD echo "nginx started successfully" &&  nginx -g 'daemon off;'
