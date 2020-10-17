
# Start from the latest golang base image
FROM golang:latest

# Set the Current Working Directory inside the container
WORKDIR /app


# Build Args
ARG LOG_DIR=/app/logs

# Create Log Directory
RUN mkdir -p ${LOG_DIR}

# Environment Variables
ENV LOG_FILE_LOCATION=${LOG_DIR}/app.log 

# Copy go mod and sum files
COPY main.go ./

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o main .

RUN go build ./main.go

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Declare volumes to mount
VOLUME [${LOG_DIR}]

# Run the binary program produced by `go install`
CMD ["./go-static-site"]
