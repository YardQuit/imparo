### BASE-IMAGE ARGUMENTS
ARG SOURCE_REPO="quay.io/fedora"
ARG SOURCE_IMAGE="fedora-bootc"
ARG SOURCE_TAG="42"

### FETCH BASE-IMAGE
FROM ${SOURCE_REPO}/${SOURCE_IMAGE}:${SOURCE_TAG}

### COPY CONFIGUREATION FILES AND SCRIPTS
COPY sysfiles /tmp/sysfiles
COPY packages /tmp/packages
COPY build.sh /tmp/build.sh

### RUN BUILD-SCRIPT AND MAKE COMMIT 
RUN /tmp/build.sh && \
    dnf clean all && \
    ostree container commit

### PERFORM ANALYSIS CHECKS
RUN bootc container lint

