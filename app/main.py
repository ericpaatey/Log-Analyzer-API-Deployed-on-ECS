from fastapi import FastAPI, UploadFile
from analyzer import analyze_logs

app = FastAPI(title="DevOps Log Analyzer")

@app.get("/")
def home():
    return {"message": "Log Analyzer API Running"}

@app.post("/analyze")
async def analyze(file: UploadFile):

    contents = await file.read()
    logs = contents.decode().splitlines()

    result = analyze_logs(logs)

    return result