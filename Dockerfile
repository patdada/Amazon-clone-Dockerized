FROM scratch

COPY etc_passwd /etc/passwd
# contains "nonroot:x:1337:1337:nonroot:/nonroot:/usr/sbin/nologin"

USER nonroot

COPY production_binary /app

ENTRYPOINT ["/app/production_binary"]
