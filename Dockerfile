FROM ghcr.io/mygento/android:v36

LABEL org.opencontainers.image.source=https://github.com/mygento/docker-flutter

ENV FLUTTER_VERSION=3.47.0

# Install dependencies and download/extract Flutter
RUN apt-get -q update && apt-get install -qqy \
      curl \
      xz-utils \
      git \
      unzip \
      && curl -o flutter_linux.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
      && tar -xf flutter_linux.tar.xz -C /opt \
      && rm flutter_linux.tar.xz \
      && git config --global --add safe.directory /opt/flutter

# Fastlane
RUN apt-get -q update && apt-get install -qqy ruby-full build-essential && \
    gem install fastlane

ENV PATH="/opt/flutter/bin:${PATH}"

RUN flutter --disable-analytics && \
    flutter doctor --android-licenses && \
    flutter precache --android