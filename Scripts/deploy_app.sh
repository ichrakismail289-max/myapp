#!/bin/bash
set -e

echo "=============================="
echo " DÉPLOIEMENT BACKEND "
echo "=============================="

# Aller dans le backend
cd /root/myapp/backend || {
  echo "❌ Backend introuvable"
  exit 1
}

# Installer les dépendances Python
pip3 install --upgrade pip
pip3 install -r requirements.txt

# Lancer l'application (Flask / FastAPI / Django simple)
nohup python3 app.py > app.log 2>&1 &

echo "=============================="
echo " APPLICATION DÉMARRÉE ✅ "
echo "=============================="
