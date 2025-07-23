# 🕵️ OSINT Tool - Recon Script (`recon_scan_set2.sh`)

## 🔍 About the Project

This project includes a Bash script that automates OSINT (Open Source Intelligence) and recon tasks using several command-line tools. It helps penetration testers and ethical hackers gather initial information about a domain or IP quickly and efficiently.

## 🧠 Tools Used

- `unicornscan`
- `dmitry`
- `amass`
- `ike-scan`
- `massscan`

## 📄 Script Code

```bash
#!/bin/bash

# Recon Tool Launcher: Set 2
# Tools used: unicornscan, dmitry, amass, ike-scan, massscan

# Check for target argument
if [ -z "$1" ]; then
    echo "Usage: $0 <target>"
    echo "Example: $0 192.168.1.1 OR $0 example.com"
    exit 1
fi

TARGET="$1"
OUTDIR="recon_output_set2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTDIR"

echo "[*] Starting scans on: $TARGET"
echo "[*] Output directory: $OUTDIR"

# Run unicornscan
echo "[+] Running unicornscan ..."
unicornscan -Iv "$TARGET":a > "$OUTDIR/unicornscan.txt" 2>&1

# Run dmitry
echo "[+] Running dmitry ..."
dmitry -winsepfb "$TARGET" > "$OUTDIR/dmitry.txt" 2>&1

# Run amass
echo "[+] Running amass (passive subdomain enumeration) ..."
amass enum -passive -d "$TARGET" > "$OUTDIR/amass.txt" 2>&1

# Run ike-scan (for IPs only)
if [[ $TARGET =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "[+] Running ike-scan ..."
    ike-scan "$TARGET" > "$OUTDIR/ike-scan.txt" 2>&1
else
    echo "[!] Skipping ike-scan (domain detected, requires IP address)"
fi

# Run massscan (requires root)
if [[ $EUID -eq 0 ]]; then
    echo "[+] Running massscan (ports 0-1000) ..."
    masscan "$TARGET" -p0-1000 --rate 1000 -oG "$OUTDIR/massscan.txt"
else
    echo "[!] Skipping massscan (requires root privileges)"
fi

echo "[✔] Recon Set 2 Completed. All output saved in: $OUTDIR"

![gophish logo](https://raw.github.com/gophish/gophish/master/static/images/gophish_purple.png)

Gophish
=======

![Build Status](https://github.com/gophish/gophish/workflows/CI/badge.svg) [![GoDoc](https://godoc.org/github.com/gophish/gophish?status.svg)](https://godoc.org/github.com/gophish/gophish)

Gophish: Open-Source Phishing Toolkit

[Gophish](https://getgophish.com) is an open-source phishing toolkit designed for businesses and penetration testers. It provides the ability to quickly and easily setup and execute phishing engagements and security awareness training.

### Install

Installation of Gophish is dead-simple - just download and extract the zip containing the [release for your system](https://github.com/gophish/gophish/releases/), and run the binary. Gophish has binary releases for Windows, Mac, and Linux platforms.

### Building From Source
**If you are building from source, please note that Gophish requires Go v1.10 or above!**

To build Gophish from source, simply run ```go install github.com/gophish/gophish@latest``` and ```cd``` into the project source directory. Then, run ```go build```. After this, you should have a binary called ```gophish``` in the current directory.

### Docker
You can also use Gophish via the official Docker container [here](https://hub.docker.com/r/gophish/gophish/).

### Setup
After running the Gophish binary, open an Internet browser to https://localhost:3333 and login with the default username and password listed in the log output.
e.g.
```
time="2020-07-29T01:24:08Z" level=info msg="Please login with the username admin and the password 4304d5255378177d"
```

Releases of Gophish prior to v0.10.1 have a default username of `admin` and password of `gophish`.

### Documentation

Documentation can be found on our [site](http://getgophish.com/documentation). Find something missing? Let us know by filing an issue!

### Issues

Find a bug? Want more features? Find something missing in the documentation? Let us know! Please don't hesitate to [file an issue](https://github.com/gophish/gophish/issues/new) and we'll get right on it.

### License
```
Gophish - Open-Source Phishing Framework

The MIT License (MIT)

Copyright (c) 2013 - 2020 Jordan Wright

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software ("Gophish Community Edition") and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
