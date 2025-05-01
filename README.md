# Self-Hosted Home Server Configuration

A Docker-based home server setup managing multiple services via `docker-compose`.

## Services

| Service | Description | Access | Data Location |
|---------|-------------|--------|--------------|
| **Joplin** | Open-source note-taking app with sync | [joplin.marceloborges.dev](https://joplin.marceloborges.dev) | `./volumes/joplin` |
| **Vaultwarden** | Self-hosted password manager (Bitwarden compatible) | [vaultwarden.marceloborges.dev](https://vaultwarden.marceloborges.dev) | `./volumes/vaultwarden` |
| **Paperless-ngx** | Document management system with OCR | [paperless.marceloborges.dev](https://paperless.marceloborges.dev) | `./volumes/paperless/*` |
| **Caddy** | Reverse proxy and SSL manager | N/A | `./Caddyfile` |

## Quick Start

### Prerequisites
- Docker and Docker Compose
- DNS configuration for domains

### Setup
1. Clone repo and navigate to directory
2. Create `.env` file with `VAULTWARDEN_ADMIN_TOKEN` (generate with `docker run --rm -it vaultwarden/server /vaultwarden hash`)
3. Create `docker-compose.env` file for Paperless-ngx configuration
4. Set Joplin permissions: `sudo chmod -R 777 volumes/joplin`
5. Start services: `docker-compose up -d`

### Management
- Start: `docker-compose up -d`
- Stop: `docker-compose down`

All services auto-restart unless manually stopped. SSL certificates are managed automatically by Caddy.

## License
MIT License

## Configuration Examples

### `.env` Example
```
VAULTWARDEN_ADMIN_TOKEN='$argon2id$v=19$m=65540,t=3,p=4$your_generated_hash'
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
PAPERLESS_SECRET_KEY=7bb0bfdf686f7751165b4b7a019f3f39eec2210132833cadfe31ca5ffd5bce71

# Use this variable to set a timezone for the Paperless Docker containers.
PAPERLESS_TIME_ZONE=Europe/Lisbon

# The default language to use for OCR.
PAPERLESS_OCR_LANGUAGE=eng

# Additional languages to install for text recognition
PAPERLESS_OCR_LANGUAGES=por fra deu
```