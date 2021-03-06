## BUILDING
##   (from project root directory)
##   $ docker build -t angelmmiguel-docker-react-redux-boilerplate .
##
## RUNNING
##   $ docker run -p 3000:3000 angelmmiguel-docker-react-redux-boilerplate
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/debian-buildpack:wheezy-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="3f2hk0y" \
    STACKSMITH_STACK_NAME="Angelmmiguel/docker-react-redux-boilerplate" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install node-6.3.1-0 --checksum afc84696d6aeaf8a3d058ecda07f72bfa54392207fa939e6b11ef8eba986aff9

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Add an user to prevent errors from npm install
RUN useradd yoshi -m && \
    sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
    echo "yoshi ALL=NOPASSWD: ALL" >> /etc/sudoers

# Set the user
USER yoshi

# Entrypoint
COPY ./scripts/entrypoint.sh /

# Node base template
WORKDIR /app

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

CMD ["node"]
