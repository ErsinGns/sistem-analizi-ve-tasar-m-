from flask import Flask, Blueprint
from routes.api import apiBilgi

app = Flask(__name__)

app.register_blueprint(apiBilgi)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
