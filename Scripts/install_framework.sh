#!/bin/bash
set -e

echo "=============================="
echo " INSTALLATION ENVIRONNEMENT "
echo "=============================="

# Mise à jour du système
apt update -y
apt upgrade -y

# Installation des dépendances système
apt install -y \
  python3 \
  python3-pip \
  git \
  curl \
  nginx

# Vérifications
python3 --version
pip3 --version
git --version
nginx -v

echo "=============================="
echo " ENVIRONNEMENT PRÊT ✅ "
echo "=============================="
