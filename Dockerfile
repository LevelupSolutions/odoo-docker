FROM alpine:edge

ENV GIT_BRANCH 9.0
ENV DATABASE_HOST database
ENV DATABASE_PORT 5432
ENV DATABASE_USER postgres
ENV DATABASE_PASSWORD po$tgres
ENV DATABASE_NAME odoo

RUN apk add wkhtmltopdf --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted 

RUN apk add --no-cache \
  postgresql-dev \
  libxml2-dev \
  libxslt-dev \
  libevent-dev \
  cyrus-sasl-dev \
  openldap-dev \
  python-dev \
  py-setuptools \
  git \
  py-pip \
  musl-dev \
  linux-headers \
  gcc \
  nodejs 

RUN npm install -g less clean-css


RUN git clone https://github.com/LevelupSolutions/odoo.git --depth 1 --single-branch --branch $GIT_BRANCH /app/

COPY ./requirements.txt /tmp/
RUN cd /tmp/ && pip install -r requirements.txt


CMD ["/app/odoo.py --db_host=$DATABASE_HOST --db_port=$DATABASE_PORT --db_user=$DATABASE_USER --db_password=$DATABASE_PASSWORD --database=$DATABASE_NAME"]
