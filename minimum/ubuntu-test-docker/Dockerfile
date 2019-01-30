FROM ubuntu
RUN apt-get update
ADD PCAcer.crt /usr/local/share/ca-certificates
RUN apt-get install -y apt-file && apt-file update
RUN apt-get install -y iputils-ping dnsutils vim net-tools
RUN apt-get install ca-certificates
RUN update-ca-certificates
CMD bash
