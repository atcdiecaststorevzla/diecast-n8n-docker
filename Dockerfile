# Dockerfile personalizado de n8n con la librería "sharp" preinstalada
# Necesario porque n8n, por defecto, NO incluye sharp ni permite usarla en el
# nodo Code. Desde que n8n usa "Task Runners", instalar el paquete no basta:
# hay que instalarlo DENTRO de la carpeta del runner de JavaScript y además
# permitirlo explícitamente en /etc/n8n-task-runners.json (ver ese archivo,
# adjunto junto a este Dockerfile).
#
# Uso en Easypanel:
# 1. Sube este Dockerfile Y el archivo n8n-task-runners.json al mismo
#    repositorio de GitHub, ambos en la raíz.
# 2. En Easypanel, en el servicio de n8n, Source = GitHub, apuntando a ese
#    repositorio, con "Dockerfile" como método de compilación.
# 3. Implementa (Deploy). Easypanel construirá la imagen desde cero.

FROM docker.n8n.io/n8nio/n8n:2.21.0

USER root

# Instala sharp DENTRO de la carpeta del runner de JavaScript (no global),
# que es donde el resolvedor de módulos del task runner busca los paquetes.
RUN cd /opt/runners/task-runner-javascript && npm install sharp

# Copia la configuración que autoriza explícitamente el uso de "sharp"
# en el nodo Code (el ENV por sí solo ya no es suficiente en esta versión).
COPY n8n-task-runners.json /etc/n8n-task-runners.json

USER node
