#Please make sure to adjust the pytorch/pytorch Docker image version as per your CUDA version requirement.
#To build the Docker image, save the above Dockerfile in the same folder as your main.py and then run docker build -t my-python-app . in your terminal.
#To run the Docker container, you can use docker run --gpus all my-python-app.
#Please note that CUDA must be installed on the host machine to use it in a Docker container, and the NVIDIA Container Toolkit must be installed to allow Docker to use GPUs.

# Start from the PyTorch version, which comes with CUDA pre-installed
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime

# Install wget, git, cmake, make and compilers
RUN apt-get update && apt-get install -y wget bzip2 git cmake build-essential

# Copy the environment.yml file
COPY ./environment/environment.yml /workspace/environment.yml

# Install conda via Miniconda install (adjust version if needed)
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Adding the miniconda install location to PATH
ENV PATH /miniconda/bin:$PATH

# Create the environment
RUN conda env create -f /workspace/environment.yml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "Barbershop", "/bin/bash", "-c"]

# Copy your scripts into the container
COPY ./main.py /workspace/main.py

# Set the default command for the container
CMD ["python", "/workspace/main.py"]


