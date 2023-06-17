from typing import Union

from fastapi import FastAPI
from gpt4free import you
from gpt4free import deepai
from pydantic import BaseModel


class Item(BaseModel):
    content: str
    lang: str


app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/ai/{question}")
def read_item(question: str, q: Union[str, None] = None):
    result = you.Completion.create(prompt=question)
    return {"answer": result.text}


@app.post("/ai/ask")
async def ai_ask(item: Item):
    summary = "please summary:"
    if item.lang == "zh-CN":
        summary = "请使用中文，帮我整理这段文字，要求要点明确，并顺序列出："

    # result = you.Completion.create(prompt=summary + item.content)
    result = deepai.Completion.create(prompt=summary + item.content)
    answer = result.text
    escaped = answer.encode('utf-8').decode('unicode-escape')
    return {"answer": escaped}
