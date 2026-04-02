#!/bin/bash
# SSH Hardening Audit Script
# Checks SSH configuration against security best practices

SSH_CONFIG="/etc/ssh/sshd_config"
ISSUES=0

check_setting() {
    local setting="$1"
    local expected="$2"
    local actual=$(grep -i "^$setting" "$SSH_CONFIG" 2>/dev/null | awk '{print $2}')
    
    if [ "$actual" == "$expected" ]; then
        echo "[✓] $setting is correctly set to: $expected"
    else
        echo "[!] $setting should be '$expected', found: '${actual:-not set}'"
        ISSUES=$((ISSUES + 1))
    fi
}

echo "=== SSH HARDENING AUDIT ==="
echo "Config file: $SSH_CONFIG"
echo ""

check_setting "PermitRootLogin" "no"
check_setting "PasswordAuthentication" "no"
check_setting "X11Forwarding" "no"
check_setting "MaxAuthTries" "3"
check_setting "Protocol" "2"

echo ""
echo "Issues found: $ISSUES"
