# 1. Base image with lightweight Python 3.10
FROM python:3.10-slim

# 2. Avoid buffering stdout/stderr (helps when reading docker logs)
ENV PYTHONUNBUFFERED=1

# 3. Set the working directory inside the container
WORKDIR /app

# 4. Copy requirements first to leverage Docker layer caching
COPY requirements.txt .

# 5. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy your application code, template, and model folder
COPY app.py .
COPY index.html .
COPY saved_summary_model/ ./saved_summary_model/

# 7. Expose FastAPI's default port
EXPOSE 8000

# 8. Start the FastAPI server with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
