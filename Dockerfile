#Please make sure to adjust the pytorch/pytorch Docker image version as per your CUDA version requirement.
#To build the Docker image, save the above Dockerfile in the same folder as your main.py and then run docker build -t my-python-app . in your terminal.
#To run the Docker container, you can use docker run --gpus all my-python-app.
#Please note that CUDA must be installed on the host machine to use it in a Docker container, and the NVIDIA Container Toolkit must be installed to allow Docker to use GPUs.

# Start from the PyTorch version, which comes with CUDA pre-installed
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime

# Install other requirements
RUN pip install certifi==2023.7.22 \
    charset-normalizer==3.3.0 \
    dlib==19.24.2 \
    filelock==3.12.4 \
    fsspec==2023.10.0 \
    idna==3.4 \
    Jinja2==3.1.2 \
    MarkupSafe==2.1.3 \
    mpmath==1.3.0 \
    networkx==3.2 \
    ninja==1.11.1.1 \
    numpy==1.26.1 \
    Pillow==10.1.0 \
    requests==2.31.0 \
    scipy==1.11.3 \
    sympy==1.12 \
    torchvision==0.16.0 \
    typing_extensions==4.8.0 \
    urllib3==2.0.7

# Copy your scripts into the container
COPY ./main.py /workspace/main.py

# Set the default command for the container
CMD ["python", "/workspace/main.py"]
