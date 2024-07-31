# After upgrading docker, might have to...
```
docker buildx create --use
```

# Build for local testing
```
docker buildx build --platform linux/arm64 --tag horologger/btcshell:v0.0.1 --load .
```

# Build and push to docker hub (So we can install on Umbrel)
```
docker buildx build --platform linux/arm64,linux/amd64 --tag horologger/btcshell:v0.0.1 --output "type=registry" .
```

#First run on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-e APP_PASSWORD=Whatever8 \
-e BTCCLI_RPCSERVER=ragnar:10009 \
-v data:/data \
--mount type=bind,source="$(pwd)"/data,target=/data,readonly \
-p 8080:8080 \
--name btcshell \
-it horologger/btcshell:v0.0.1
```
#Subsequent runs on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-e APP_PASSWORD=Whatever8 \
-e BTCCLI_RPCSERVER=ragnar:10009 \
-v data:/data \
--mount type=bind,source="$(pwd)"/data,target=/data,readonly \
-p 8080:8080 \
-it horologger/btcshell:v0.0.1
```

# Inspect
```sh
docker exec -it btcshell /bin/bash
```
# Clean up
```sh
docker stop btcshell
docker rm btcshell
```

ragnar:~/bitcoin-25.0/bin # ./bitcoin-cli -named createwallet wallet_name="orange" descriptors=false
{
  "name": "orange",
  "warnings": [
    "Wallet created successfully. The legacy wallet type is being deprecated and support for creating and opening legacy wallets will be removed in the future."
  ]
}
