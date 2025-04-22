### 🧠 Resumen del Proyecto: ZenML + FastAPI + IA Generativa

Este proyecto tiene como objetivo enseñar cómo construir **sistemas backend robustos** utilizando **FastAPI** para soportar pipelines **MLOps escalables** y **aplicaciones impulsadas por IA**, específicamente con enfoque en **IA generativa**.

---

### 🎯 Objetivo General
Aprender a construir sistemas backend que:
- Integren modelos de IA entrenados.
- Utilicen pipelines reproducibles para MLOps.
- Se desplieguen en producción con monitorización.
- Aumenten su capacidad con tecnologías como **BigQuery** y nativas de la nube.

---

### 📚 Ruta de Aprendizaje

1. **Fundamentos de FastAPI**
   - Documentación oficial: [FastAPI](https://fastapi.tiangolo.com/)
   - Curso recomendado: [FastAPI Crash Course - YouTube](https://www.youtube.com/watch?v=0sOvCWFmrtA)

2. **Conceptos de MLOps**
   - Entender qué es MLOps y su ciclo de vida.
   - Curso práctico: [MLOps with MLflow and Azure ML - Microsoft](https://learn.microsoft.com/en-us/training/modules/mlops-deployment/)

3. **ZenML**
   - Uso de ZenML para pipelines de ML: `ingest`, `train`, `evaluate`.
   - Documentación: [https://docs.zenml.io](https://docs.zenml.io)

4. **BigQuery y alternativas**
   - BigQuery es un **almacenamiento y procesamiento analítico de datos a gran escala** de Google Cloud.
   - Alternativas:
     - Amazon Redshift (AWS)
     - Snowflake
     - Azure Synapse
     - PostgreSQL + Pandas para proyectos pequeños/medianos

5. **Integración con modelos de IA Generativa**
   - OpenAI, HuggingFace Transformers, LangChain.
   - Cargar modelos de texto o imagen y desplegarlos mediante FastAPI.

6. **Despliegue en producción**
   - Docker + Uvicorn + Nginx
   - Monitorización con Prometheus/Grafana
   - Deploy en GCP, AWS o Render.com

---

### 💻 Ejemplo de Aplicación Backend (Paso a Paso)

#### Estructura del Proyecto
```
project/
├── main.py               # API con FastAPI
├── run_pipeline.py       # Ejecuta el pipeline ZenML
├── pipelines/
│   ├── ingest.py         # Carga datos
│   ├── train.py          # Entrena modelo
│   └── predict.py        # Realiza predicción
├── model/
│   └── model.pkl         # Modelo entrenado
├── requirements.txt
├── Dockerfile
└── .gitignore
```

#### Flujo de trabajo
1. Se ejecuta `run_pipeline.py` que:
   - Carga los datos (diabetes dataset o texto generativo).
   - Entrena un modelo (regresión o modelo generativo simple).
   - Guarda el modelo.

2. Se lanza la API con `main.py` para recibir peticiones:
   ```bash
   uvicorn main:app --reload
   ```

3. Se puede consultar la documentación en `http://localhost:8000/docs` y enviar peticiones POST al endpoint `/predict` con los datos.

---

### 🔮 ¿Qué podrías construir después?
- Clasificador de sentimientos de reseñas de productos.
- Generador de texto con OpenAI/GPT desde FastAPI.
- Análisis de grandes volúmenes de texto con BigQuery + FastAPI + LangChain.

## Clasificador de Sentimientos de Reseñas de Productos con FastAPI + ZenML

### 🎯 Objetivo
Construir una aplicación backend robusta con **FastAPI** y **ZenML** que clasifique reseñas de productos como **positivas** o **negativas**, integrando todo en un pipeline de MLOps simple.

---

### 📦 Estructura del Proyecto
```
sentiment_classifier/
├── main.py                # API FastAPI
├── run_pipeline.py        # Ejecuta el pipeline ZenML
├── pipelines/
│   ├── ingest.py          # Carga y preprocesamiento de datos
│   ├── train.py           # Entrenamiento del modelo
│   └── predict.py         # Paso para predecir
├── model/
│   └── model.pkl          # Modelo entrenado guardado
├── requirements.txt       # Librerías del proyecto
├── Dockerfile             # Contenedor opcional
└── .gitignore             # Archivos ignorados por Git
```

---

### 🔄 Pipeline con ZenML
1. `ingest.py`: carga dataset simple de reseñas (sklearn `load_files` o CSV local).
2. `train.py`: entrena modelo con `TfidfVectorizer` + `LogisticRegression` o `MultinomialNB`.
3. `predict.py`: carga modelo y permite predicción desde FastAPI.

---

### 🧪 Dataset Pequeño
Usaremos un dataset pequeño como `sklearn.datasets.load_files` con reseñas etiquetadas en dos carpetas:
```
data/
├── pos/
│   ├── 0.txt  # buena reseña
├── neg/
│   ├── 1.txt  # mala reseña
```
Puedes tener 10-20 archivos por clase para pruebas locales.

---

### 🖥️ Endpoint FastAPI `/predict`
- Entrada: `{"review": "this product is amazing"}`
- Salida: `{"sentiment": "positive"}`

---

### ✅ `.gitignore`
```
__pycache__/
*.pyc
*.pkl
.env
.venv/
.idea/
*.sqlite3
.DS_Store
*.log
```

---

### 📌 Comandos Iniciales
```bash
git init
git add .
git commit -m "Initial commit: FastAPI + ZenML backend for sentiment classifier"
```

---

### ✅ Código del Proyecto

#### `requirements.txt`
```
fastapi
uvicorn
scikit-learn
pydantic
joblib
zenml[server]
```

#### `main.py`
```python
from fastapi import FastAPI
from pydantic import BaseModel
import joblib

app = FastAPI()
model = joblib.load("model/model.pkl")

class ReviewRequest(BaseModel):
    review: str

@app.post("/predict")
def predict_sentiment(request: ReviewRequest):
    prediction = model.predict([request.review])[0]
    return {"sentiment": prediction}
```

#### `run_pipeline.py`
```python
from zenml.pipelines import pipeline
from pipelines.ingest import ingest_data
from pipelines.train import train_model

@pipeline
def sentiment_pipeline():
    X_train, X_test, y_train, y_test = ingest_data()
    train_model(X_train, X_test, y_train, y_test)

if __name__ == '__main__':
    sentiment_pipeline()()
```

#### `pipelines/ingest.py`
```python
from sklearn.datasets import load_files
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer


def ingest_data():
    data = load_files("data", categories=['pos', 'neg'])
    X_train, X_test, y_train, y_test = train_test_split(
        data.data, data.target, test_size=0.2, random_state=42
    )
    return X_train, X_test, y_train, y_test
```

#### `pipelines/train.py`
```python
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
import joblib


def train_model(X_train, X_test, y_train, y_test):
    pipe = Pipeline([
        ("tfidf", TfidfVectorizer()),
        ("clf", LogisticRegression())
    ])
    pipe.fit(X_train, y_train)
    joblib.dump(pipe, "model/model.pkl")
```

#### `pipelines/predict.py`
```python
import joblib

def predict_review(text):
    model = joblib.load("model/model.pkl")
    return model.predict([text])[0]
```

#### `Dockerfile`
```
FROM python:3.9

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

Ya tienes un proyecto completo y funcional con FastAPI + ZenML listo para clonar, ejecutar y probar 🧠⚙️. ¿Te gustaría que lo suba como repositorio de GitHub o necesitas ayuda para hacerlo tú mismo?


