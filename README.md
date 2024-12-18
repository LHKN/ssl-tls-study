# SSL/TLS

## About this project

This project aims to set up SSL/TLS communication, using nginx in Dockerfile to build reverse proxy. This allows us to configure https connection with port 443.

## Necessary environment files

To build this project, you will need to install certificate and key files in directory **/nginx/ssl/**

In this scenario, I'm using [mkcert library](https://github.com/FiloSottile/mkcert), which results in the following files: **localhost+3.pem** and **localhost+3-key.pem**

## Quick demonstration

Demo link: [HTTPS showcase](https://drive.google.com/file/d/13a9hF98O9Ral4cMxbAgTXY_SEbEWMVz1/view?usp=sharing)

The demo video is showcasing secure connection and redirection to https when accessing http connection.

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
