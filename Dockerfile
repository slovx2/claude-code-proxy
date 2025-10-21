FROM ghcr.io/astral-sh/uv:bookworm-slim

# Copy the project into the image
ADD . /app

# Sync the project into a new environment, asserting the lockfile is up to date
WORKDIR /app
RUN apt-get update && \
    apt-get install -y build-essential && \
    uv sync --locked && \
    rm -rf /var/lib/apt/lists/*

CMD ["uv", "run", "start_proxy.py"]
