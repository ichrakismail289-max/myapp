from flask import Flask, render_template, request
from terraform_runner import run_terraform

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/deploy", methods=["POST"])
def deploy():
    framework = request.form["framework"]
    git_url = request.form["git_url"]  # <-- CORRECT ici
    try:
        ip = run_terraform(framework, git_url)
        return f"Deployment finished. LXC IP: {ip}"
    except Exception as e:
        return f"Error during deployment: {str(e)}"

app.run(host="0.0.0.0", port=5000)
