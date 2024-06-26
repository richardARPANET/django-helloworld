# Use the official Python image as the base image
FROM python:3.9-slim-buster

ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_HOST=${POSTGRES_HOST}
ENV POSTGRES_PORT=${POSTGRES_PORT}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project code into the container
COPY . .

# Create the /data directory
RUN mkdir -p /data

# Create the helloworld.db file if it doesn't exist
RUN python -c "import os; os.makedirs('/data', exist_ok=True); open('/data/helloworld.db', 'a').close()"

# Collect the Django static files
RUN python manage.py collectstatic --no-input

# Expose the port that the Django app will run on
EXPOSE 8000

# Set the command to start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
