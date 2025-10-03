- Ruta: Dockerfile
- Contenido mínimo listo para compilar:
    
    FROM python:3.11-slim
    
    ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
    
    WORKDIR /app
    
    RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/* \
    
    && useradd -m appuser
    
    COPY . /app
    
    RUN pip install --no-cache-dir -U pip \
    
    && if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
    
    USER appuser
    
    EXPOSE 8000
    
    HEALTHCHECK --interval=30s --timeout=3s --start-period=10s CMD python -c "print('ok')" || exit 1
    
    CMD ["python", "-c", "print('Train TCS listo 🚂')"]
