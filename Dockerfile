FROM alpine:edge
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
  py-inotify \
  git \
  py-pip \
  musl-dev \
  linux-headers \
  gcc \
  zlib-dev \
  jpeg-dev \
  wkhtmltopdf-dev \
  freetype-dev \
  py-imaging 

COPY ./requirements.txt /tmp/
RUN cd /tmp/ && pip install -r requirements.txt

RUN pip install reportlab

RUN git clone https://github.com/LevelupSolutions/odoo.git --depth 1 --single-branch --branch $GIT_BRANCH /app/

RUN pip install reportlab

RUN adduser -D odoo && chown -R odoo /app

COPY ./launch.sh /app/

RUN chmod +x /app/launch.sh
USER odoo
CMD /app/launch.sh
