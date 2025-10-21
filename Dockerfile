FROM ghcr.io/astral-sh/uv:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN uv sync --locked

CMD ["uv", "run", "start_proxy.py"]
