# Stage 1: Builder (slim for build tools)
FROM python:3.9-slim as builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime (Alpine for minimal size)
FROM python:3.9-alpine

WORKDIR /app

# Copy only installed packages from builder
COPY --from=builder /root/.local /root/.local

# Set environment variables
ENV PATH=/root/.local/bin:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Copy application code
COPY app.py .

# Expose port
EXPOSE 5000

# Run application
CMD ["python", "app.py"]