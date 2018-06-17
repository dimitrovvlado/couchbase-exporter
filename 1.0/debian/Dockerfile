FROM python:3.6.5-slim

MAINTAINER dimitrov.vlado at gmail.com

RUN pip install prometheus-couchbase-exporter && apt-get update && apt-get -y install curl

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
