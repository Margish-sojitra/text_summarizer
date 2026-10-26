# 📝 Dialogue & Text Summarizer (T5 Fine-Tuned)

[![Docker Image](https://img.shields.io/badge/Docker%20Hub-margish002%2Ftext--summarizer-blue?logo=docker)](https://hub.docker.com/r/margish002/text-summarizer)
[![Python Version](https://img.shields.io/badge/Python-3.10-blue?logo=python)](https://www.python.org/)
[![Framework](https://img.shields.io/badge/FastAPI-0.100+-009688?logo=fastapi)](https://fastapi.tiangolo.com/)
[![Model](https://img.shields.io/badge/Model-T5--Small%20(Fine--Tuned)-orange?logo=huggingface)](https://huggingface.co/docs/transformers/model_doc/t5)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end Deep Learning NLP application that generates abstractive summaries for dialogues and conversational text. Built by fine-tuning Google's **T5 (Text-to-Text Transfer Transformer)** on the **SAMSum** dataset, wrapped in a **FastAPI** web service with a clean web UI, and fully containerized with **Docker** for one-command deployment.

---

## 📸 Overview & Features

- **Abstractive Dialogue Summarization**: Fine-tuned on conversational multi-turn dialogues to extract key action items and intent.
- **Fast Inference**: Optimized CPU inference running the Hugging Face pipeline with beam search (`num_beams=4`).
- **Interactive Web UI**: Clean, responsive frontend built with HTML5, CSS3, and Jinja2 templates.
- **RESTful API**: Standardized JSON endpoint (`/summarize/`) for headless integrations and batch requests.
- **Production-Ready Dockerization**: Containerized with lightweight `python:3.10-slim` and CPU-optimized PyTorch.

---

## ⚡ Quick Start with Docker (Recommended)

You don't need Python, Git, or dependencies installed. If you have Docker, run:

```bash
# 1. Pull and start the container
docker run -d -p 8000:8000 --name summarizer margish002/text-summarizer:v1.0

# 2. Open the application in your browser
http://localhost:8000
```

To stop the container:
```bash
docker stop summarizer
```

---

## 💻 Local Installation & Setup

If you prefer to run the project locally in Python:

### 1. Clone the Repository
```bash
git clone https://github.com/Margish-sojitra/text_summarizer.git
cd text_summarizer
```

### 2. Create and Activate a Virtual Environment
```bash
# Windows
python -m venv venv
.\venv\Scripts\activate

# Linux / macOS
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run the FastAPI Application
```bash
uvicorn app:app --host 127.0.0.1 --port 8000 --reload
```

Visit `http://localhost:8000` to interact with the summarizer.

---

## 🧠 Model Training & Fine-Tuning

The model was fine-tuned using Hugging Face's `Trainer` API on the **SAMSum** dataset.

- **Base Architecture**: `t5-small`
- **Max Input Length**: 512 tokens (dialogue)
- **Max Output Length**: 150 tokens (summary)
- **Generation Strategy**: Beam Search with `num_beams=4` and early stopping
- **Training Code**: Check the step-by-step training pipeline in [`text_summarizer.ipynb`](text_summarizer.ipynb).

> **Note on Model Weights**: Due to GitHub's 100MB file limit, the binary weights (`model.safetensors`, ~242MB) are omitted from git tracking. The complete model weights are pre-packaged inside the public Docker image [`margish002/text-summarizer:v1.0`](https://hub.docker.com/r/margish002/text-summarizer).

---

## 🔌 API Endpoints

### 1. Web Interface
- **Method**: `GET`
- **Route**: `/`
- **Response**: HTML template for interactive browser usage.

### 2. Summarize Dialogue
- **Method**: `POST`
- **Route**: `/summarize/`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
```json
{
  "dialogue": "Amanda: I baked cookies. Do you want some?\nJerry: Sure!\nAmanda: I'll bring you tomorrow :-)"
}
```
- **Response**:
```json
{
  "summary": "amanda baked cookies and will bring some to jerry tomorrow."
}
```

---

## 📁 Project Structure

```plaintext
text_summarizer/
│
├── app.py                      # FastAPI web server and inference logic
├── index.html                  # Frontend web interface (Jinja2 template)
├── text_summarizer.ipynb       # Jupyter notebook with data preprocessing & fine-tuning
├── requirements.txt            # Python dependencies (CPU-optimized torch)
├── Dockerfile                  # Container build instructions
├── .dockerignore               # Build context exclusions
├── .gitignore                  # Git tracking exclusions (weights, checkpoints)
│
├── saved_summary_model/        # Model configuration & tokenizer files
│   ├── config.json
│   ├── generation_config.json
│   ├── tokenizer.json
│   └── tokenizer_config.json
│
├── samsum-train.csv            # Training split (SAMSum)
├── samsum-validation.csv       # Validation split
├── samsum-test.csv             # Test split
└── README.md                   # Project documentation
```

---

## 🐳 Building the Docker Image Manually

If you make modifications to the code or UI and want to build your own Docker image:

```bash
# Build the image
docker build -t text-summarizer:latest .

# Run the newly built image
docker run -d -p 8000:8000 --name summarizer-app text-summarizer:latest
```

---

## 👤 Author

**Margish Sojitra**
- GitHub: [@Margish-sojitra](https://github.com/Margish-sojitra)
- Docker Hub: [margish002](https://hub.docker.com/u/margish002)

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
