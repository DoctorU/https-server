#!/usr/bin/env sh
echo $*
test_setup () {
	# is http-server present?
	http-server --version || { echo 'http-server not installed. Halting.' >&2; exit 1; }
	openssl version || { echo 'openssl not installed. Halting.' >&2; exit 1; }
}
_cleanup() {
	echo 'interrupted... cleaning up'
	rm -vrf $(pwd)/tmp/
}
test_webroot() {
	test -d ${1} || { echo "${1}"' does not exist. Halting.'>&2; exit 1; }
}
https_server () {
	# generate certificates locally
	local certpath=$(pwd)/tmp/https-server-certs
	mkdir -p "${certpath}";
	openssl req -x509 -newkey rsa:4096 -sha256 -days 1 \
  	-nodes -keyout "${certpath}/localhost.key" -out "${certpath}/localhost.crt" -subj "/CN=localhost" \
	-addext "subjectAltName=DNS:localhost,DNS:*.localhost,IP:127.0.0.1" > /dev/null
  	http-server ${1} --ssl --cert "${certpath}/localhost.crt" --key "${certpath}/localhost.key" -o
}
trap '_cleanup' INT
test_setup
test_webroot ${1:-./docs}
https_server ${1:-./docs}
