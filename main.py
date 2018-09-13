import os
import time
from flask import Flask

app = Flask(__name__)
start_time = time.time()


def time_has_passed(delta):
    if time.time() > start_time + delta:
        return True
    return False


@app.route('/')
def hello():
    return "Hello World from version %s" % os.getenv("VERSION")


@app.route('/health')
def ready_check():
    # simulate the app to be unresponsive after 60 seconds
    if time_has_passed(60):
        return "App not responding", 500
    return "", 201


if __name__ == '__main__':
    app.run(host='0.0.0.0')
