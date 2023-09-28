# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest

# Set the working directory to /mlflow/
WORKDIR /home/mlflow

# Copy your application code and requirements
COPY requirements.txt .

# Install Python packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 
EXPOSE 5000

# Set environment variables
ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts

# Command to start MLflow with custom parameters
CMD ["mlflow", "server"]

