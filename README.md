# Nextcloud Deployment with Fast-Sync & AI Search Pipeline

## Docker Architecture
This stack is managed via Docker Compose and optimized for high-performance self-hosting:
- **App:** Nextcloud (Latest).
- **Search Engine:** Elasticsearch 8.x – Provides lightning-fast full-text indexing for family and study documents.
- **OCR Engine:** Tesseract OCR – Integrated within the app container to process images and PDFs in English, Hebrew, and Russian.
- **DB:** MariaDB 10.11 with READ-COMMITTED isolation.
- **Cache:** Redis for performance and file locking.
- **Push:** High-performance-backend (notify_push) for instant sync.
- **Proxy:** Nginx Proxy Manager (NPM) handling SSL and Websockets.

## Critical Configurations & Bug Fixes
- **Vector & Handwriting Support:** Optimized for PDF exports from Xournal++, allowing full-text search of handwritten notes created with XP-Pen.
- **Elasticsearch Integration:** Configured with a 1GB JVM Heap limit to ensure stability on homelab hardware.
- **Multi-Language OCR:** Tesseract is configured to recognize English, Hebrew, and Russian text, including printed medical documents and clear handwriting.
- **Background Tasks:** Switched from AJAX to system `Cron` for reliable automation.

## Client-Side Automation (Arch Linux)
1. `sync_to_clipboard.sh`: A watcher script using `inotifywait`.
2. `sync-clip.service`: A Systemd user service to run the watcher in the background.