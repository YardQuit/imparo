# BASE-IMAGE ARGUMENTS
ARG SOURCE_IMAGE="fedora-bootc"
ARG SOURCE_TAG="latest"

# FETCH BASE-IMAGE
FROM quay.io/fedora/${SOURCE_IMAGE}:${SOURCE_TAG}

# COPY CONFIGUREATION FILES AND SCRIPTS
COPY / /tmp/

# prerequisite
RUN dnf install rsync &&

# RUN BUILD-SCRIPT AND MAKE COMMIT 
RUN /tmp/build.sh && \
    ostree container commit
