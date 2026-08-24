# Dockerfile personalizado de n8n con la librería "sharp" preinstalada
# Necesario porque n8n, por defecto, NO incluye sharp ni permite instalar
# módulos npm nativos desde el editor. Hay que "hornear" la imagen.
#
# Uso en Easypanel:
# 1. Sube este Dockerfile a un repositorio Git (GitHub/GitLab) junto a tu proyecto,
#    o pégalo directamente si Easypanel te permite build desde Dockerfile inline.
# 2. En Easypanel, en el servicio de n8n, cambia el "Source" de "Docker Image"
#    a "Dockerfile" / "Build from Git" apuntando a este archivo.
# 3. Vuelve a desplegar. Easypanel construirá la imagen la primera vez
#    (tarda un par de minutos) y luego arrancará normal.

FROM docker.n8n.io/n8nio/n8n:2.21.0

USER root

# Instala sharp como dependencia global accesible para los nodos Code
RUN npm install -g sharp

# Permite que el nodo Code (JavaScript) pueda hacer require('sharp')
ENV NODE_FUNCTION_ALLOW_EXTERNAL=sharp
ENV NODE_PATH=/usr/local/lib/node_modules

USER node
