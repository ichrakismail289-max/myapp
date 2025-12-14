#!/bin/bash
cd /app
if [ -f app.py ]; then
 python3 app.py
fi
if [ -f package.json ]; then
 npm install
 npm start
fi
