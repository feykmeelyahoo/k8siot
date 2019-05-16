
COUNTRY :=TR
STATE := Ankara
COMPANY := HAVELSAN BOTAS
# credits to: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

# make all

all: botasCA.crt


botasCA.key:
	openssl genrsa -out botasCA.key 4096

# create and self sign botasCA certificate
botasCA.crt: botasCA.key
	echo -ne "$(COUNTRY)\n$(STATE)\n\n$(COMPANY)\n\n\n\n" | openssl req -x509 -new -nodes -key botasCA.key -sha256 -days 36500 -out $@

.PHONY: clean
clean:
	-rm -f rootCA.crt rootCA.key

