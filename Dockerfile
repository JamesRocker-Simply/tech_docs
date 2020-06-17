ARG ACCOUNT_ID=129462528407
ARG ENVIRONMENT=dev
ARG REGION
ENV APP_PORT

# start with our base hardened image.
FROM ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/sb-hardened-centos-master-dab30fb-0-${ENVIRONMENT}-base-${REGION}:latest

# Example of installing dependencies
RUN /usr/bin/yum install -y \
	sqlite-devel \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER sbopr

# Copy the app code to the image
COPY --chown=sbopr . $APP_HOME

# Expose the port the app listens on
EXPOSE $APP_PORT

# Run the app
CMD /bin/bash
