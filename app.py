from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "arun first terraform pipeline 😄😄😄"

app.run(host="0.0.0.0", port=80)