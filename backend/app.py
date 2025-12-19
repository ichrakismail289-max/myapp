from flask import Flask, request, jsonify
import subprocess
import threading
import os

app = Flask(__name__)

# --------------------------
# Chemins Terraform
# --------------------------
TERRAFORM_CMD = "/usr/local/bin/terraform"  # Chemin vers terraform sur LXC
TERRAFORM_DIR = "/root/myapp/terraform"    # Dossier contenant main.tf, variables.tf

# --------------------------
# Fonction pour exécuter Terraform en arrière-plan
# --------------------------
def run_terraform_bg():
    try:
        process = subprocess.Popen(
            [TERRAFORM_CMD, "apply", "-auto-approve"],
            cwd=TERRAFORM_DIR,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        stdout, stderr = process.communicate()
        return_code = process.returncode
        return {"stdout": stdout, "stderr": stderr, "returncode": return_code}
    except Exception as e:
        return {"error": str(e)}

# --------------------------
# Fonction pour récupérer l'IP du LXC depuis Terraform
# --------------------------
def get_lxc_ip():
    try:
        result = subprocess.run(
            [TERRAFORM_CMD, "output", "-json"],
            cwd=TERRAFORM_DIR,
            capture_output=True,
            text=True
        )
        data = result.stdout
        import json
        ip = json.loads(data)["lxc_ip"]["value"]
        return ip
    except Exception as e:
        return f"Error: {str(e)}"

# --------------------------
# Routes Flask
# --------------------------
@app.route("/api", methods=["GET"])
def hello():
    return jsonify({"message": "Hello World", "status": "success"})

@app.route("/deploy", methods=["POST"])
def deploy():
    # Lancer Terraform en arrière-plan
    thread = threading.Thread(target=run_terraform_bg)
    thread.start()
    lxc_ip = get_lxc_ip()
    return jsonify({"status": "Terraform started in background", "lxc_ip": lxc_ip})

# --------------------------
# Lancer le serveur Flask
# --------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
