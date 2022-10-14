# Builder : build "requirements.txt" from poetry files.
FROM python:3.11.0rc2 as builder
WORKDIR /app

RUN pip install poetry
COPY pyproject.toml .
COPY poetry.lock .

RUN poetry export -f requirements.txt -o requirements.txt --without-hashes

# Deploy : Install mkdocs
FROM python:3.11.0rc2 as deploy
LABEL org.opencontainers.image.description="mkdocs builder for educational websites"
WORKDIR /app
RUN apt-get update && apt-get install -y \
  zip
COPY --from=builder /app/requirements.txt .
RUN pip install -r requirements.txt

ENTRYPOINT ["mkdocs"]
