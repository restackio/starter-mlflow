# Use an appropriate base image for MLflow
FROM bitnami/mlflow:2.9.2-debian-11-r0
# Set the working directory to /mlflow/
WORKDIR /mlflow/

# Install a specific version of NumPy that is compatible with your MLflow version
RUN pip install --no-cache-dir numpy

# Downgrade protobuf to a potentially compatible version (adjust the version as needed)
RUN pip install --no-cache-dir protobuf==3.20.0
# Expose port 5000 for external access
EXPOSE 5000
# Define environment variables for MLflow configuration
ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts
# Start the MLflow server with the specified configuration
CMD mlflow server --backend-store-uri ${BACKEND_URI} --default-artifact-root ${ARTIFACT_ROOT} --host 0.0.0.0 --port 5000
