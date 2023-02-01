@REM  Generate Certicicate for .msix signing
openssl genrsa -out AshTech.key 2048
openssl req -new -key AshTech.key -out AshTech.csr
openssl x509 -in AshTech.csr -out AshTech.crt -req -signkey AshTech.key -days 10000
openssl pkcs12 -export -out AshTech.pfx -inkey AshTech.key -in AshTech.crt
