#!/bin/bash

# === Recon Tool Launcher: Set 2 ===
# Tools: unicornscan, dmitry, amass, ike-scan, massscan

if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    echo "Example: $0 192.168.1.1 or $0 example.com"
    exit 1
fi

TARGET="$1"
OUTDIR="recon_output_set2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTDIR"

echo "[*] Starting scans on: $TARGET"
echo "[*] Output directory: $OUTDIR"

# Run tools in parallel
echo "[+] Running unicornscan..."
unicornscan -Iv "$TARGET":a > "$OUTDIR/unicornscan.txt" &

echo "[+] Running dmitry..."
dmitry -winsep "$TARGET" > "$OUTDIR/dmitry.txt" &

echo "[+] Running amass..."
amass enum -d "$TARGET" > "$OUTDIR/amass.txt" &

echo "[+] Running ike-scan..."
ike-scan "$TARGET" > "$OUTDIR/ike-scan.txt" &

echo "[+] Running massscan (ports 1-1000)..."
massscan "$TARGET" -p1-1000 --rate=1000 > "$OUTDIR/massscan.txt" &

# Wait for all background jobs
wait

echo "[✔] All scans completed!"
echo "[📁] Check the '$OUTDIR' folder for results."
