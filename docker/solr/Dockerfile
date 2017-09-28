FROM solr:5.3

ENV SOLR_HOME /opt/solr/server/solr
ENV SOLR_PORT 8983
ENV SOLR_USER root

USER $SOLR_USER

COPY ./core $SOLR_HOME
COPY ./configsets $SOLR_HOME/configsets

EXPOSE $SOLR_PORT
CMD /opt/solr/bin/solr -f -p $SOLR_PORT