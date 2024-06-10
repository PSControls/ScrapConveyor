# Use the official Node.js 22 image based on Alpine 3.19
FROM node:22-alpine3.19

# Set environment variables for the project
ENV PROJECT_DIR=/home/node-red/project
ENV NODE_RED_VERSION=latest

# Create necessary directories
RUN mkdir -p ${PROJECT_DIR}

# Set the working directory
WORKDIR /usr/app

# Install necessary packages, Node-RED, Python, and pip as root
RUN apk update && apk add --no-cache git \
    && py3-pip \
    && echo "Installing Node-RED version ${NODE_RED_VERSION}" \
    && npm install -g node-red@${NODE_RED_VERSION}

RUN pip3 install python3

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

# Install Python libraries using pip (add your required libraries here)
RUN pip3 install requests numpy pandas

# Expose the default Node-RED port
EXPOSE 1880

# Start Node-RED with the project directory
CMD ["node-red", "--userDir", "/home/node-red/project"]
