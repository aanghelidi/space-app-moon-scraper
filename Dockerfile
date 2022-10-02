FROM ubuntu:22.04 as builder

ARG DEBIAN_FRONTEND=interactive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Update and install
RUN apt-get update \
   && apt-get install -y --no-install-recommends python3 python3-dev python3-distutils python3-venv \
   && apt-get clean \
   && apt-get autoremove

RUN python3 -m venv /opt/venv
# Add venv to $PATH to activate it
ENV PATH="/opt/venv/bin:$PATH"

# Tell pip to not use cache
ENV PIP_NO_CACHE_DIR=true

# Use pip to install requirements
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

FROM ubuntu:22.04 as runner

ARG DEBIAN_FRONTEND=interactive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Update and install
RUN apt-get update \
   && apt-get install -y --no-install-recommends python3 python3-dev python3-distutils python3-venv \
   && rm -rf /var/lib/apt/lists/* \
   && apt-get clean \
   && apt-get autoremove

# Create an app user
ENV APP_USER=userscaper
RUN groupadd -r $APP_USER && \
    useradd -m -g $APP_USER -s /sbin/nologin -c "scraper app user" $APP_USER
ENV APP_USER_HOME=/home/$APP_USER

# Change user and go to home
USER $APP_USER
WORKDIR $APP_USER_HOME

# Copy and clean
RUN mkdir -p app/spaceAppScraper
COPY app/scrapy.cfg app/
COPY app/spaceAppScraper app/spaceAppScraper

# Change ownership
USER root
RUN chown -R $APP_USER:users app/


USER $APP_USER
RUN find app/ -name "__pycache*" | xargs rm -rf
# Cd into app directory
WORKDIR app/spaceAppScraper

# Activate venv
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Use scrapy
ENTRYPOINT ["scrapy","crawl"]
