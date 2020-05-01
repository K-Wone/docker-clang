# stage 1: build LLVM with latest spack
ARG GCC_VERSION="9.2.0"
FROM leavesask/gcc:${GCC_VERSION} AS builder

USER root

ARG GCC_VERSION="9.2.0"
ENV GCC_VERSION=${GCC_VERSION}
ARG LLVM_VERSION="9.0.1"
ENV LLVM_VERSION=${LLVM_VERSION}
ARG LLVM_OPTIONS=""
ENV LLVM_OPTIONS=${LLVM_OPTIONS}

# install LLVM
RUN spack install --show-log-on-error -y llvm@${LLVM_VERSION} ${LLVM_OPTIONS}


# stage 2: build the runtime environment
ARG GCC_VERSION
FROM leavesask/gcc:${GCC_VERSION}

LABEL maintainer="Wang An <wangan.cs@gmail.com>"

USER root

ENV SPACK_ROOT=/opt/spack
ENV PATH=${SPACK_ROOT}/bin:$PATH

# copy artifacts from stage 1
COPY --from=builder ${SPACK_ROOT} ${SPACK_ROOT}

# initialize spack environment for all users
ARG LLVM_VERSION="9.0.1"
RUN set -eu; \
      \
      source ${SPACK_ROOT}/share/spack/setup-env.sh; \
      spack load llvm@${LLVM_VERSION}; \
      spack compiler add

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
