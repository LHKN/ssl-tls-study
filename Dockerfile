# Install Operating system and dependencies
FROM ubuntu:20.04 as build-env

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

ENV DEBIAN_FRONTEND=dialog
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web

#----------------------------------------------------------------
# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Remove the default.conf file from the container
RUN rm /etc/nginx/conf.d/default.conf

# # Copy the Nginx configuration file to the container
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-env /app/build/web /usr/share/nginx/html

COPY nginx/ssl/localhost+3.pem /etc/nginx/ssl/localhost.pem
COPY nginx/ssl/localhost+3-key.pem /etc/nginx/ssl/localhost-key.pem  
#----------------------------------------------------------------

# Record the exposed port
EXPOSE 80:443

# Start Nginx when the container launchess
CMD ["nginx", "-g", "daemon off;"]


# make server startup script executable and start the web server
# RUN ["chmod", "+x", "/app/server/server.sh"]

# ENTRYPOINT [ "/app/server/server.sh"]