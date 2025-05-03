# Self-Hosted Home Server Configuration

A Docker-based home server setup managing multiple services via `docker-compose`.

## Services

| Service | Description | Access | Data Location |
|---------|-------------|--------|--------------|
| **Joplin** | Open-source note-taking app with sync | [joplin.marceloborges.dev](https://joplin.marceloborges.dev) | `./volumes/joplin` |
| **Vaultwarden** | Self-hosted password manager (Bitwarden compatible) | [vaultwarden.marceloborges.dev](https://vaultwarden.marceloborges.dev) | `./volumes/vaultwarden` |
| **AdGuard Home** | Network-wide ad and tracker blocking DNS server | [adguard.marceloborges.dev](https://adguard.marceloborges.dev) | `./volumes/adguardhome` |
| **Paperless-ngx** | Document management system with OCR | [paperless.marceloborges.dev](https://paperless.marceloborges.dev) | `./volumes/paperless/*` |
| **Caddy** | Reverse proxy and SSL manager | N/A | `./Caddyfile` |
| **Cloudflare DDNS** | Dynamic DNS updater for Cloudflare domains | N/A | N/A |
| **Uptime Kuma** | Self-hosted monitoring tool | [uptime.marceloborges.dev](https://uptime.marceloborges.dev) | `./volumes/uptime-kuma` |

## Quick Start

### Prerequisites
- Docker and Docker Compose
- DNS configuration for domains

### Setup
1. Clone repo and navigate to directory
2. Create `.env` file with required environment variables
3. Create `docker-compose.env` file for Paperless-ngx configuration
4. Set Joplin permissions: `sudo chmod -R 777 volumes/joplin`
5. Create directories for AdGuard Home: `mkdir -p volumes/adguardhome/work volumes/adguardhome/conf`
6. Start services: `docker-compose up -d`

### Management
- Start: `docker-compose up -d`
- Stop: `docker-compose down`

All services auto-restart unless manually stopped. SSL certificates are managed automatically by Caddy.

### AdGuard Home Setup
After initial deployment, access the AdGuard Home setup wizard at [adguard.marceloborges.dev](https://adguard.marceloborges.dev) to complete configuration. The service uses port 53 for DNS queries, so ensure no other DNS service is running on your host machine.

To use AdGuard Home as your DNS server:
1. Complete the setup wizard
2. Configure your router's DHCP to use your server's IP address as the DNS server
3. Alternatively, configure individual devices to use your server's IP for DNS

### Uptime Kuma Setup
After initial deployment, access Uptime Kuma at [uptime.marceloborges.dev](https://uptime.marceloborges.dev) to complete setup. On first access, you'll be prompted to create an administrator account.

To monitor your services:
1. Complete the initial setup by creating an admin account
2. Add monitors for your websites and services
3. Configure notification methods (email, Telegram, Discord, etc.)
4. Optionally set up status pages to share with others

### Cloudflare DDNS Setup
The Cloudflare DDNS service automatically updates your domain's DNS records with your current IP address. This is useful if your ISP assigns you a dynamic IP address.

To set up Cloudflare DDNS:
1. Create a Cloudflare API token with Edit Zone DNS permissions
2. Add the token to your `.env` file as `CLOUDFLARE_API_TOKEN`
3. Configure the domains to update in the `docker-compose.yml` file under the `cloudflare-ddns` service

## License
MIT License

## Configuration Examples

### `.env` Example
```
# Token for Vaultwarden admin access
VAULTWARDEN_ADMIN_TOKEN='$argon2id$v=19$m=65540,t=3,p=4$your_generated_hash'

# Token for Cloudflare Edit Zone DNS API token
CLOUDFLARE_API_TOKEN=your_generated_edit_zone_dns_api_token

# Project name for docker-compose (prefixes containers, isolates networks)
COMPOSE_PROJECT_NAME=homeserver
```

### `docker-compose.env` Example
```ini
###############################################################################
# Paperless-ngx settings                                                      #
###############################################################################

# See http://docs.paperless-ngx.com/configuration/ for all available options.

# The UID and GID of the user used to run paperless in the container. Set this
# to your UID and GID on the host so that you have write access to the
# consumption directory.
USERMAP_UID=1000
USERMAP_GID=1000

# This is required if you will be exposing Paperless-ngx on a public domain
PAPERLESS_URL=https://paperless.marceloborges.dev

# Adjust this key if you plan to make paperless available publicly. It should
# be a very long sequence of random characters.
PAPERLESS_SECRET_KEY=

# Use this variable to set a timezone for the Paperless Docker containers.
PAPERLESS_TIME_ZONE=Europe/Lisbon

# The default language to use for OCR.
PAPERLESS_OCR_LANGUAGE=eng

# Additional languages to install for text recognition
PAPERLESS_OCR_LANGUAGES=por fra deu
```
