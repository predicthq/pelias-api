FROM ubuntu:14.04
MAINTAINER PredictHQ

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository ppa:chris-lea/node.js \
    && apt-get update \
    && apt-get install -y \
        nodejs \
        git \
        python \
        build-essential \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV PORT=3100
EXPOSE 3100
LABEL io.openshift.expose-services 3100:http

# Where the app is built and run inside the docker fs
ENV WORK=/opt/pelias

# Used indirectly for saving npm logs etc.
ENV HOME=/opt/pelias

WORKDIR ${WORK}
ADD . ${WORK}

ADD pelias.json.docker pelias.json

# Install, and remove a module that causes strict mode issues.
RUN npm install \
  && rm -rf node_modules/pelias-schema/node_modules/pelias-config

CMD npm start
