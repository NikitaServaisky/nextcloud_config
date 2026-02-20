# Nextcloud Deployment with Fast-Sync Pipeline

## Docker Architecture
This stack is managed via Docker Compose and includes:
- **App:** Nextcloud (Latest).
- **DB:** MariaDB 10.11 with READ-COMMITTED isolation.
- **Cache:** Redis for performance and file locking.
- **Push:** High-performance-backend (notify_push).
- **Proxy:** Nginx Proxy Manager (NPM) handling SSL and Websockets.

## Critical Configurations & Bug Fixes
- **Websocket Support:** Must be enabled in NPM for the Push notifications to function correctly.
- **Trusted Proxies:** Added the proxy internal IP to `config.php` to prevent header stripping.
- **Background Tasks:** Switched to `Cron` mode for optimal performance.

## Client-Side Automation (Arch Linux)
The automation consists of two files (included in this repo):
1. `sync_to_clipboard.sh`: The watcher script.
2. `sync-clip.service`: The Systemd user service.

### Installation:
1. Copy `sync_to_clipboard.sh` to your home directory.
2. Copy `sync-clip.service` to `~/.config/systemd/user/`.
3. Run: `systemctl --user enable --now sync-clip.service`.