Here is the config I use for all things pain.agency. This is here so I can easily recommend configurations I use to others running dendrite.

unfuck certs for caddy from [a clanker](https://gemini.google.com/share/d2ca49100721):
```
# Grant traversal access to all the parent directories
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy/.local
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy/.local/share
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy/.local/share/caddy
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy/.local/share/caddy/certificates
sudo setfacl -m u:stalwart-mail:rx /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory

# Grant read access to the specific domain folder and the files inside it
sudo setfacl -R -m u:stalwart-mail:rx /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/mail.pain.agency

# Restart Stalwart to apply
sudo systemctl restart stalwart-mail
```
