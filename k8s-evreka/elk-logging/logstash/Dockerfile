# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash-oss:6.3.2

# Add your logtash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json
RUN logstash-plugin install logstash-input-gelf
RUN logstash-plugin install logstash-filter-mutate

RUN logstash-plugin install logstash-input-syslog
RUN logstash-plugin install logstash-filter-date
RUN logstash-plugin install logstash-filter-grok
RUN logstash-plugin install logstash-filter-useragent
RUN logstash-plugin install logstash-output-elasticsearch

LABEL org.label-schema.group: "monitoring"