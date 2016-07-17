FROM alpine:3.4
ENV GIT_BRANCH 9.0
ENV DATABASE_HOST database
ENV DATABASE_PORT 5432
ENV DATABASE_USER postgres
ENV DATABASE_PASSWORD po$tgres
ENV DATABASE_NAME odoo

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
  gcc

COPY ./requirements.txt /tmp/
RUN cd /tmp/ && pip install -r requirements.txt


RUN git clone https://github.com/LevelupSolutions/odoo.git --depth 1 --single-branch --branch $GIT_BRANCH /app/

CMD ["/app/odoo.py --db_host=$DATABASE_HOST --db_port=$DATABASE_PORT --db_user=$DATABASE_USER --db_password=$DATABASE_PASSWORD --database=$DATABASE_NAME"]
