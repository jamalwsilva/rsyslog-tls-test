Rsyslog TLS Config Example

Running:
```
git clone https://github.com/jamal.silva/rsyslog-tls-test
pushd config/tls
./create-ca-client-certs.sh
popd
docker-compose up --build
```

Testing:
```
docker ps --format 'table {{.ID}}\t{{.Names}}'
# CONTAINER ID        NAMES
# 7682ed5335f3        rsyslog-tls-test_client_1
# 297e0561f1f1        rsyslog-tls-test_server_1

# send some logs
docker exec -i rsyslog-tls-test_client_1 logger < ./example.log

# check if logs are being saved correctly
docker exec -it rsyslog-tls-test_server_1 tailf /var/log/messages

# check if TLS is working (must not see any text/plain message)
docker exec -it rsyslog-tls-test_server_1 tcpdump -X port 10514
```
