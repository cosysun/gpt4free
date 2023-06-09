FROM python:3.12.0b1-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp
RUN pip install --upgrade pip \
 && pip install -r /tmp/requirements.txt \
 && rm /tmp/requirements.txt

COPY . /root/gpt4free

WORKDIR /root/gpt4free

CMD ["uvicorn", "--host 0.0.0.0", "main:app"]
  
EXPOSE 8000