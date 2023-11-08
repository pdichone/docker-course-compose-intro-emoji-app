FROM python:3.12-alpine

WORKDIR /app

ENV FLASK_APP=app.py

ENV FLASK_RUN_HOST=0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers



COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

EXPOSE 5000

ENV FLASK_ENV=dev

CMD ["flask", "run"]
