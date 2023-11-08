from flask import Flask, render_template
import redis
import random

app = Flask(__name__)
redis_db = redis.Redis(host="redis", port=6379, db=0, decode_responses=True)


@app.route("/")
def index():
    emojis = ["😀", "😂", "🤣", "😊", "😍", "🥰", "😎", "🤩", "🥳", "😜"]

    if not redis_db.exists("emojis"):
        redis_db.rpush("emojis", *emojis)

    random_index = random.randint(0, redis_db.llen("emojis") - 1)
    emoji = redis_db.lindex("emojis", random_index)

    return render_template("index.html", emoji=emoji)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
