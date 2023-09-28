# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest
# Set the working directory inside the container
WORKDIR /mlflow/
# Copy the requirements.txt file from the host to the container
COPY requirements.txt .
# Install Python packages listed in requirements.txt and remove the file
RUN pip install --no-cache-dir -r requirements.txt && \
  rm requirements.txt

EXPOSE 5000
# Set the backend store URI for MLflow
ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts
# Start the MLflow server with the specified configuration
CMD mlflow server --backend-store-uri ${BACKEND_URI} --default-artifact-root ${ARTIFACT_ROOT} --host 0.0.0.0 --port 5000