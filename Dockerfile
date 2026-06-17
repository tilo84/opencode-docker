FROM debian:bookworm-slim AS base
RUN apt-get update && apt-get install -y curl inetutils-ping xdg-utils python3 python3-pip python3-venv

FROM base AS opencode_base
RUN groupadd -r opencode && useradd -r -g opencode opencode
RUN mkdir /home/opencode && chown opencode:opencode /home/opencode


RUN curl -fsSL https://opencode.ai/install | bash
# 3. Zum neuen Nutzer wechseln
USER opencode

FROM opencode_base AS opencode
USER opencode
WORKDIR /app
CMD [ "/root/.opencode/bin/opencode" ]