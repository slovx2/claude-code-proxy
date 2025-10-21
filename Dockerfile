FROM ghcr.io/astral-sh/uv:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential cargo && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN uv sync --locked

COPY . .

EXPOSE 8082

CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082"]
