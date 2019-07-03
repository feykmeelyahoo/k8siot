
DOMAIN ?= dockerepo.dc02.havelsan.io

COUNTRY :=TR
STATE := Ankara
COMPANY := HAVELSAN BOTAS
# credits to: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

# usage:
# make botasCA.crt # (botasCA.key implicitly created)
# make DOMAIN=somedomain.dev somedomain.dev.csr somedomain.dev.crt   or   make DOMAIN=somedomain.dev
# make DOMAIN=somedomain.dev verify-csr
# make DOMAIN=somedomain.dev verify-crt

# import botasCA.crt to the client (chrome)
# upload somedomain.dev.crt   and   somedomain.dev.key   to the host

all: $(DOMAIN).csr $(DOMAIN).crt


$(DOMAIN).key:
	openssl genrsa -out $@ 2048

$(DOMAIN).conf:
	sh mkconf.sh $(DOMAIN) >$@

$(DOMAIN).csr: $(DOMAIN).key $(DOMAIN).conf
	openssl req -new -sha256 -key $(DOMAIN).key -subj "/C=$(COUNTRY)/ST=$(STATE)/O=$(COMPANY)/CN=$(DOMAIN)" \
		-reqexts SAN \
		-config $(DOMAIN).conf \
		-out $@

# verify .csr content
.PHONY: verify-csr
verify-csr:
	openssl req  -in $(DOMAIN).csr -noout -text

$(DOMAIN).san.conf:
	sh mksan.sh $(DOMAIN) $(COUNTRY) $(STATE) "$(COMPANY)" >$@

$(DOMAIN).crt: $(DOMAIN).csr $(DOMAIN).san.conf
	openssl x509 -req -in $(DOMAIN).csr -CA ../CA/botasCA.crt -CAkey ../CA/botasCA.key \
		-CAcreateserial -out $@ -days 36500 -sha256 \
		-extfile $(DOMAIN).san.conf -extensions req_ext

# verify the certificate
.PHONY: verify-crt
verify-crt:
	openssl x509 -in $(DOMAIN).crt -text -noout

.PHONY: clean
clean:
	-rm -f $(DOMAIN).key $(DOMAIN).csr $(DOMAIN).conf $(DOMAIN).san.conf $(DOMAIN).crt
