# image-smtp
Setup Postfix SMTP relay using Docker

### What for?

Able to sending email without using an external SMTP server

## How to use this image

### Build the image

```
git clone https://github.com/kadasz/image-smtp
cd image-smtp
docker build -t image-smtp .
```

### Run a container

The env variables should to be passed during starts container:

- `DOMAIN` the domain name your server is using
- `HOSTNAME` should be set to the FQDN of your mail server
- `NETWORKS` option means that relay mail from these IP without authentication

```
 docker run -d --name mail --hostname mail -p 25:25 -e DOMAIN="domain.com" -e HOSTNAME="mail.domain.com" -e NETWORKS="127.0.0.0/8 192.168.10.0/24" image-smtp
```

The mail container will be started with exposed the 25 port  to the docker host server.
