# Usa una imagen oficial de Python
FROM python:3.10-slim

# Directorio de trabajo
WORKDIR /app

# Primero copia los requirements para cachear las dependencias
COPY requirements.txt .

# Instala dependencias del sistema y Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y gcc python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia el resto de la app
COPY . .

# Puerto expuesto
EXPOSE 8000

# Comando para correr la app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]