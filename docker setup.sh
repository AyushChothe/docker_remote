openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr
echo subjectAltName = DNS:$HOST,IP:$HOST,IP:127.0.0.1 >>extfile.cnf
echo extendedKeyUsage = serverAuth >>extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
-CAcreateserial -out server-cert.pem -extfile extfile.cnf
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth >extfile-client.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
-CAcreateserial -out cert.pem -extfile extfile-client.cnf
rm -v client.csr server.csr extfile.cnf extfile-client.cnf
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
mkdir -pv ~/.docker
cp -v *.pem ~/.docker
# Modify: /lib/systemd/system/docker.service
# Add: --tlsverify --tlscacert=~/.docker/ca.pem --tlscert=~/.docker/server-cert.pem --tlskey=~/.docker/server-key.pem -H fd:// -H tcp://0.0.0.0:2376 --containerd=/run/containerd/containerd.sock
# systemctl daemon-reload
# sudo service docker restart
