FROM node:18-slim

# Installation de Chromium et des bibliothèques requises
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libnss3 \
    libxss1 \
    xdg-utils \
    --no-install-recommends \
    && rm -rf /var/lib/apt-get/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

# Installation globale de l'interface OpenWA
RUN npm install -g @open-wa/wa-automate

# Le port d'écoute par défaut sur Render est 10000
EXPOSE 10000

CMD ["npx", "@open-wa/wa-automate", "--api-cli", "--port", "10000", "--use-chrome", "/usr/bin/chromium", "--no-sandbox"]
