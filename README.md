# Minimal Golang Docker Image

This repo shows how to build minimal (distroless) images for Golang applications and compares image sizes of the different options.

Good writeups on advantages / disadvantages of distroless images:
- [Stop using Alpine Docker images](https://medium.com/inside-sumup/stop-using-alpine-docker-images-fbf122c63010)
- [Docker Distroless PoC](https://github.com/erickduran/docker-distroless-poc)

## Example application

Our go application for this experiment is really basic, it only requests https://google.com and logs the response.

## Builds

### Alpine Build

This build uses an alpine base image.

```bash
make build-alpine
```

### Distroless Build

This build uses the [Google distroless](https://github.com/GoogleContainerTools/distroless) image.

```bash
make build-distroless
```

### Scratch Build

```bash
make build-scratch
```

Our application requires ca certificates to validate the google.com certificate when calling, without ca certificates our application shows the following error:

```bash
2022/05/15 14:39:31 Get "https://google.com": x509: certificate signed by unknown authority
```

To fix this error we copy the ca certificates in our multi step build from the alpine image into our scratch image

## Size comparison

To list all images after building, run the following command:

```bash
make list-images
```

```bash
REPOSITORY             TAG          IMAGE ID       SIZE
minimal-golang-image   scratch      cb5b0ddfa5eb   4.66MB
minimal-golang-image   distroless   413ba53147b8   6.82MB
minimal-golang-image   alpine       bba979b9524a   10.5MB
```

The smallest image is our multi step scratch image, followed by the distroless build, the biggest image in our comparison is the alpine one.
