# Build LLVM with latest spack
ARG SPACK_IMAGE="spack/ubuntu-bionic"
ARG SPACK_VERSION="0.14"
FROM ${SPACK_IMAGE}:${SPACK_VERSION}

LABEL maintainer="Wang An <wangan.cs@gmail.com>"

USER root

ARG LLVM_VERSION="9"
ENV LLVM_VERSION=${LLVM_VERSION}

# install LLVM
RUN set -eu; \
      \
      apt-get update; \
      apt-get install -y \
              clang-${LLVM_VERSION} \
              libc++-${LLVM_VERSION}-dev \
              libc++abi-${LLVM_VERSION}-dev

# create symbolic links
RUN set -eu; \
      \
      rm -f /usr/bin/clang /usr/bin/clang++; \
      ln -s /usr/bin/clang-${LLVM_VERSION} /usr/bin/clang; \
      ln -s /usr/bin/clang++-${LLVM_VERSION} /usr/bin/clang++

# set environment variables
ENV LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/:${LIBRARY_PATH}"
ENV LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/:${LD_LIBRARY_PATH}"

# expose the compiler to spack
RUN spack compiler add


# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL="https://github.com/alephpiece/docker-llvm"
LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="LLVM docker image" \
      org.label-schema.description="An image for LLVM" \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.schema-version="1.0"

# setup entrypoint
ENTRYPOINT ["/bin/bash"]
CMD [""]
