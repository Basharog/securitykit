#!/bin/bash
# Network Security Scanner
# Purpose: Scan for open ports and identify potential security issues
# Author: [Your Name]

TARGET=${1:-"localhost"}
echo "Scanning target: $TARGET"
echo "Date: $(date)"
echo ""

echo "=== OPEN PORTS ==="
nmap -sV "$TARGET" 2>/dev/null || ss -tulnp

echo ""
echo "=== NETWORK CONNECTIONS ==="
ss -tulnp | grep ESTABLISHED

echo ""
echo "=== DNS LOOKUP ==="
dig "$TARGET" A +short 2>/dev/null || nslookup "$TARGET"
