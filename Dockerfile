FROM python:3.10-slim

# 避免 Python 在容器内生成 .pyc，加快启动
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 让 uv 创建的虚拟环境在固定位置，并添加到 PATH
ENV UV_PROJECT_ENV=.venv
ENV PATH="/app/.venv/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential cargo git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN python -m pip install --no-cache-dir --upgrade pip uv && \
    uv sync --locked && \
    rm -rf /root/.cache

COPY . .

EXPOSE 8082

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082"]
