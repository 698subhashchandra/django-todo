FROM python:3.13-alpine

WORKDIR /data

RUN pip install --upgrade django==3.2

COPY . .


RUN python manage.py migrate

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]


FROM python:3.13-alpine

# Install build dependencies, including distutils
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    python3-dev \
    build-base \
    postgresql-dev

# Create and set the working directory
WORKDIR /data

# Install Django and any other Python dependencies
RUN pip install --upgrade pip && \
    pip install --upgrade django==3.2

# Copy the project files to the working directory
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Expose the necessary port
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
