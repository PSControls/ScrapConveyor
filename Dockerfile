# Use the official Node.js 22 image based on Debian Bookworm
FROM node:22-bookworm

# Set environment variables for the project
ENV PROJECT_DIR=/home/node-red/project
ENV NODE_RED_VERSION=latest

# Create necessary directories
RUN mkdir -p ${PROJECT_DIR}

# Set the working directory
WORKDIR /usr/app

# Install necessary packages, Node-RED, Python, and pip as root
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    && echo "Installing Node-RED version ${NODE_RED_VERSION}" \
    && npm install -g node-red@${NODE_RED_VERSION} \
    && apt-get clean

WORKDIR ${PROJECT_DIR}

# Clone the GitHub repository as root
RUN git clone https://github.com/PSControls/ScrapConveyor.git ${PROJECT_DIR}

# Change ownership of the project directory to the 'node' user
RUN chown -R node:node ${PROJECT_DIR} \
    && echo "Installing Node-RED dependencies" \
    && npm install node-red-contrib-cip-ethernet-ip \
    && npm install node-red-contrib-controltimer \
    && npm install node-red-node-ui-table \
    && npm install node-red-contrib-ui-led \
    && npm install node-red-dashboard \
    && npm install node-red-contrib-simple-gate

# Switch to the 'node' user for better security
USER node

# Set the working directory to the project directory
WORKDIR ${PROJECT_DIR}

# Install pycomm3 using pip with --break-system-packages flag
RUN python3 -m pip install --no-cache-dir --break-system-packages pycomm3

# Expose the default Node-RED port
EXPOSE 1880

# Start Node-RED with the project directory
CMD ["node-red", "--userDir", "/home/node-red/project"]
