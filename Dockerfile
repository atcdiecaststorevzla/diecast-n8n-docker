# Dockerfile personalizado para el SERVICIO "n8n-runner" (no para "n8n")
# ---------------------------------------------------------------------
# Tu n8n corre con N8N_RUNNERS_MODE=external, es decir, el runner de
# JavaScript vive en un contenedor APARTE (el servicio "n8n-runner" que
# ya tienes en Easypanel), no dentro del contenedor de n8n. Por eso hay
# que aplicar este Dockerfile al servicio "n8n-runner", usando la imagen
# n8nio/runners (no n8nio/n8n), en la MISMA versión que tu n8n (2.21.0).

FROM n8nio/runners:2.21.0

USER root

# Instala sharp dentro de la carpeta del runner de JavaScript.
# Esta imagen usa pnpm (no npm).
RUN cd /opt/runners/task-runner-javascript && pnpm add sharp

# Autoriza explícitamente el uso de "sharp" en el nodo Code.
COPY n8n-task-runners.json /etc/n8n-task-runners.json

USER runner
