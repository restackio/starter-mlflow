# Use an appropriate base image for MLflow
FROM burakince/mlflow:latest

LABEL maintainer="Alexander Thamm GmbH <contact@alexanderthamm.com>"

WORKDIR /mlflow/

# Copy your application code and requirements
COPY requirements.txt .

# Install a specific version of NumPy that is compatible with your MLflow version
RUN pip install --no-cache-dir numpy==1.19.5

# Downgrade protobuf to a potentially compatible version (adjust the version as needed)
RUN pip install --no-cache-dir protobuf==3.20.0

# Install the remaining requirements
RUN pip install --no-cache-dir -r requirements.txt \
  && rm requirements.txt

EXPOSE 5000

ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts

CMD mlflow server --backend-store-uri ${BACKEND_URI} --default-artifact-root ${ARTIFACT_ROOT} --host 0.0.0.0 --port 5000

