#!/bin/bash
# Script de migración a software libre (para Ubuntu/Debian)
# Analista: Martín Alejandro García Babastro
# Ejecutar como: bash migrar-linux.sh

set -e

echo "=== MIGRACION A SOFTWARE LIBRE - SUMIFER ==="

# 1. Instalar alternativas libres
echo "[1/5] Instalando LibreOffice, Firefox y Thunderbird..."
sudo apt update
sudo apt install -y libreoffice firefox thunderbird

# 2. Eliminar paquetes propietarios o telemetría
echo "[2/5] Eliminando paquetes no libres (si existen)..."
sudo apt purge -y popularity-contest 2>/dev/null || echo "No se encontro popularity-contest"

# 3. Instalar QCad (alternativa libre a AutoCAD)
echo "[3/5] Instalando QCad..."
sudo apt install -y qcad

# 4. Instalar Wine para Versat Sarasola
echo "[4/5] Instalando Wine..."
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine wine32 wine64

# Configurar Wine con perfil Windows 7
cat > ~/.wine_sarasa_config << EOF
[Version]
Windows=win7
EOF
echo "[OK] Perfil Wine para Versat Sarasola guardado en ~/.wine_sarasa_config"

# 5. Limpiar paquetes obsoletos
echo "[5/5] Limpiando sistema..."
sudo apt autoremove -y
sudo apt autoclean

echo "=== MIGRACION COMPLETADA ==="
echo "Para usar Versat Sarasola con Wine: wine setup.exe"