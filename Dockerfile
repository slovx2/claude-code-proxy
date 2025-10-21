FROM python:3.12-slim

ENV UV_INSTALL_DIR=/usr/local/bin

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN uv sync --locked

CMD ["uv", "run", "start_proxy.py"]
