# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest

# Set the working directory to /mlflow/
WORKDIR /home/mlflow

# Copy your application code and requirements
COPY requirements.txt .
# Install or upgrade protobuf to a compatible version (adjust the version as needed)
RUN pip install --no-cache-dir protobuf==3.20.0
# Install Python packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 
EXPOSE 5000

# Command to start MLflow with custom parameters
CMD ["mlflow", "server"]

