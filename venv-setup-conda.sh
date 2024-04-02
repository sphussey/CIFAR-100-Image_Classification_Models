#!/bin/bash

CONDA_ENV_NAME="py_3_9_17_version_manager"
PYTHON_VERSION="3.9.17"
VENV_DIR="venv"

# create a Conda environment for Python version management
if conda info --envs | grep -q "^${CONDA_ENV_NAME} "; then
  echo "Conda environment '${CONDA_ENV_NAME}' already exists."
else
  echo "Creating Conda environment '${CONDA_ENV_NAME}' with Python ${PYTHON_VERSION}..."
  conda create -n $CONDA_ENV_NAME python=$PYTHON_VERSION -y
fi

# activate the Conda environment
echo "Activating Conda environment '${CONDA_ENV_NAME}' to set up the venv..."
source activate $CONDA_ENV_NAME

# check if the venv directory already exists
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating a virtual environment in the '${VENV_DIR}' directory..."
  python -m venv $VENV_DIR
else
  echo "Virtual environment '${VENV_DIR}' already exists."
fi

# deactivate the the Conda environment
conda deactivate

# Activate the venv
echo "Activating the virtual environment..."
source $VENV_DIR/bin/activate

# install packages from requirements.txt if available
if [ -f "requirements.txt" ]; then
    echo "Installing required packages from requirements.txt..."
    pip install -r requirements.txt
else
    echo "requirements.txt not found. Skipping package installation."
fi

echo "Setup is complete. Virtual environment '${VENV_DIR}' is ready to use."