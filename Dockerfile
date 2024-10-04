FROM ubuntu:20.04

# Install the default Python and pip versions
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Install Flask using pip without caching
RUN pip3 install --no-cache-dir flask==3.0.3

COPY app.py /opt/
RUN chown -R appuser:appgroup /opt/

USER appuser  # Run as a non-root user

# Use JSON notation for ENTRYPOINT
ENTRYPOINT ["flask", "run", "--host=0.0.0.0", "--port=8080"]
