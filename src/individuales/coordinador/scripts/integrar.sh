#!/bin/bash
# Script integrador del coordinador - Aplica todas las optimizaciones en una VM Linux
# Ejecutar como: sudo bash integrar.sh

set -e

echo "=== INTEGRACIÓN SUMIFER-SO - APLICANDO MEJORAS ==="

# 1. Optimizaciones de rendimiento y energía (Analista: Frank)
echo "[1/4] Aplicando optimizaciones de rendimiento y energía..."
sudo apt update && sudo apt install -y linux-tools-common powertop cpufrequtils

# Cambiar governor a powersave
echo 'GOVERNOR="powersave"' | sudo tee /etc/default/cpufrequtils
sudo systemctl disable ondemand 2>/dev/null || true
sudo cpufreq-set -g powersave

# Ajustar swappiness
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Ejecutar powertop --auto-tune (sin interacción)
sudo powertop --auto-tune 2>/dev/null || true

echo "[1/4] Completo."

# 2. Hardening de seguridad (Analista: Alex)
echo "[2/4] Aplicando hardening de seguridad..."
sudo apt install -y ufw lynis fail2ban

# Configurar firewall
sudo ufw --force enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp

# Deshabilitar servicios innecesarios
sudo systemctl disable bluetooth 2>/dev/null || true
sudo systemctl disable cups 2>/dev/null || true

# Configurar fail2ban para SSH
sudo systemctl enable fail2ban --now

# Verificar SUID bins (solo reporte)
echo "SUID bins encontrados:"
sudo find / -perm /4000 -type f 2>/dev/null | head -5

echo "[2/4] Completo."

# 3. Migración a software libre / soberanía (Analista: Martín)
echo "[3/4] Instalando alternativas libres..."
sudo apt install -y libreoffice thunderbird firefox qcad wine wine64

# Configurar Wine para Versat Sarasola (perfil Windows 7)
cat > ~/.wine/config_sarasa << EOF
[Version]
Windows=win7
EOF
echo "Perfil Wine creado. Para Versat Sarasola: wine setup.exe"

# Eliminar paquetes telemetría (si existen en Ubuntu)
sudo apt purge -y popularity-contest 2>/dev/null || true

echo "[3/4] Completo."

# 4. Verificación final (Coordinador)
echo "[4/4] Verificando estado final..."
echo "=== UFW STATUS ==="
sudo ufw status

echo "=== CPU GOVERNOR ==="
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "N/A"

echo "=== SERVICIOS ACTIVOS ==="
systemctl list-units --type=service --state=running | wc -l

echo "=== LYNI SUGERENCIAS (primeras 5) ==="
sudo lynis audit system --quick 2>/dev/null | grep -i "suggestion" | head -5 || echo "Ejecutar 'sudo lynis audit system' manualmente"

echo ""
echo "=== INTEGRACIÓN COMPLETA ==="