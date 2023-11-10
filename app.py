from flask import Flask, render_template
import redis
import random
from flask import jsonify


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


# This is all for Beanstalk deployment
@app.route("/health")
def health():
    return "OK", 200


@app.route("/emojis")
def show_emojis():
    # Check if the Redis list is empty
    if redis_db.llen("emojis") == 0:
        # List of sample emojis to add
        sample_emojis = ["😀", "😂", "🙌", "💖", "🚀", "🌍", "👍", "🐱‍👓"]
        # Add each emoji to the Redis list
        for emoji in sample_emojis:
            redis_db.rpush("emojis", emoji)

    # Get the total number of emojis stored in Redis
    total_emojis = redis_db.llen("emojis")

    # Retrieve all emojis from Redis
    emojis = [redis_db.lindex("emojis", i) for i in range(total_emojis)]

    # Return a JSON response with all emojis
    return jsonify({"emojis": emojis})


# @app.route("/hello")
# def check():
#     random_index = random.randint(0, redis_db.llen("emojis") - 1)
#     emoji = redis_db.lindex("emojis", random_index)

#     return render_template("hello.html", emoji=emoji)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
