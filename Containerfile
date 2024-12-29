# BASE-IMAGE ARGUMENTS
ARG SOURCE_IMAGE="fedora-bootc"
ARG SOURCE_TAG="latest"

# FETCH BASE-IMAGE
FROM quay.io/fedora/${SOURCE_IMAGE}:${SOURCE_TAG}

# COPY CONFIGUREATION FILES AND SCRIPTS
COPY packages /tmp/packages
COPY scripts /tmp/scripts
COPY system_files /tmp/system_files
COPY build.sh /tmp/build.sh

# RUN BUILD-SCRIPT AND MAKE COMMIT 
RUN /tmp/build.sh && \
    ostree container commit
