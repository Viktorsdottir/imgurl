from fastapi import FastAPI, UploadFile, File, responses
from pydantic import BaseModel
from PIL import Image
import hashlib
import os

app = FastAPI()


class Url(BaseModel):
    new: bool
    url: str


@app.get("/")
def read_root():
    return {"imgurl"}


@app.post("/images", response_model=Url)
async def predict_api(img_file: UploadFile = File(...)):
    await img_file.read()
    image = Image.open(img_file.file)
    key = hashlib.md5(image.tobytes()).hexdigest()
    if os.path.exists("images/" + key + ".jpg"):
        return {"new": False, "url": "images/" + key}
    else:
        image.save("images/" + key + ".jpg", 'JPEG')
        return {"new": True, "url": "images/" + key}


@app.get('/images/{key}')
async def retrieve_image(key: str):
    return responses.FileResponse("images/" + key + ".jpg")
