FROM python:3.9.7

RUN apt-get update && apt-get install -y \
  zip
RUN  pip install --upgrade pip
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

ENTRYPOINT ["mkdocs"]
