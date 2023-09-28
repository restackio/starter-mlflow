# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest
LABEL maintainer="Alexander Thamm GmbH <contact@alexanderthamm.com>"

WORKDIR /mlflow/

# Install protobuf compiler and necessary build dependencies
RUN apt-get update && \
    apt-get install -y protobuf-compiler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your application code and requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
  rm requirements.txt

EXPOSE 5000

ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts

CMD mlflow server --backend-store-uri ${BACKEND_URI} --default-artifact-root ${ARTIFACT_ROOT} --host 0.0.0.0 --port 5000
