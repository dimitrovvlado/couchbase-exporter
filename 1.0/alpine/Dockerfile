FROM python:3.6.5-alpine

MAINTAINER dimitrov.vlado at gmail.com

RUN pip install prometheus-couchbase-exporter && apk add --no-cache curl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
