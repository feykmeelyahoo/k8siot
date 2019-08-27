FROM docker.elastic.co/kibana/kibana-oss:6.3.2
COPY logtrail-6.3.2-0.1.29.zip /logtrail-6.3.2-0.1.29.zip
RUN ./bin/kibana-plugin install file:///logtrail-6.3.2-0.1.29.zip
COPY logtrail.json ./plugins/logtrail/logtrail.json
