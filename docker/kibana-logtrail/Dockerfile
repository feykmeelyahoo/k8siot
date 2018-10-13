FROM docker.elastic.co/kibana/kibana-oss:6.3.2
RUN ./bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v0.1.29/logtrail-6.3.2-0.1.29.zip
COPY logtrail.json ./plugins/logtrail/logtrail.json