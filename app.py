from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from your Python app!"

if __name__ == '__main__':
    # Listen on all network interfaces so it works well inside a Docker container
    app.run(host='0.0.0.0', port=5000)