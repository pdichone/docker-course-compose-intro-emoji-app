# Use an official lightweight Python image.
# https://hub.docker.com/_/python
# Improved! :)
FROM python:3.12-alpine

# Set the working directory inside the container to /app.
WORKDIR /app

# Set environment variables.
# 1. Forces Python’s stdout and stderr streams to be unbuffered.
# 2. Sets the Flask application to run.
# 3. Sets the default host for the Flask app.
ENV PYTHONUNBUFFERED=1 \
    FLASK_APP=app.py \
    FLASK_RUN_HOST=0.0.0.0

# Install gcc and other dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev linux-headers \
    && rm -rf /var/cache/apk/*

# Install Python dependencies.
# Copying just the requirements.txt first improves Docker cache utilization,
# since the requirements rarely change.
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code.
COPY . .

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 5000

# Use an unprivileged user to run the app for security reasons.
RUN adduser -D myuser
USER myuser

# Environment: 'production' for production settings,
# or 'development' to enable debug mode.
ENV FLASK_ENV=development

# Command to run the application.
CMD ["flask", "run"]




# OLD - first Step 
# FROM python:3.12-alpine

# WORKDIR /app

# ENV FLASK_APP=app.py

# ENV FLASK_RUN_HOST=0.0.0.0

# RUN apk add --no-cache gcc musl-dev linux-headers

# COPY requirements.txt /app/
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . /app

# EXPOSE 5000

# ENV FLASK_ENV=dev

# CMD ["flask", "run"]
