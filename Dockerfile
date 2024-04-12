# Use the official Python image as the base image
FROM python:3.9-slim-buster

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
RUN touch /data/helloworld.db || true

# Collect the Django static files
RUN python manage.py collectstatic --no-input

# Expose the port that the Django app will run on
EXPOSE 8000

# Set the command to start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
