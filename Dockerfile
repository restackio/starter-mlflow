# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest

# Set the working directory to /mlflow/
WORKDIR /mlflow/
# Install protoc (protobuf compiler)
RUN apt-get update && apt-get install -y protobuf-compiler
# Generate protobuf files (adjust paths as needed)
RUN protoc -I /mlflow/protos/ --python_out=/mlflow/protos/
# Copy your application code and requirements
COPY requirements.txt .

# Install Python packages from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080
EXPOSE 8080

# Set environment variables
ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts

# Command to start MLflow with custom parameters
CMD ["mlflow", "server", \
     "--backend-store-uri", "${BACKEND_URI}", \
     "--default-artifact-root", "${ARTIFACT_ROOT}", \
     "--host", "0.0.0.0", "--port", "8080", \
     "--workers", "4", "--model-store", "/custom-models"]

