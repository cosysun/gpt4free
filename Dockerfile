FROM python:3

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

CMD ["uvicorn", "main:app", "--host=0.0.0.0", "--port=${PORT}"]

EXPOSE 8000