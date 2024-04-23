# CVE-2024-4040 - exploit scanners

This repository contains files related to [CVE-2024-4040](https://nvd.nist.gov/vuln/detail/CVE-2024-4040) (CrushFTP VFS escape).

## scan_host.py

This script attempts to use the vulnerability to read files outside the sandbox. If it succeeds, the script writes `Vulnerable` to standard output and returns with exit code 1. If exploiting the vulnerability does not succeed, the script writes `Not vulnerable` and exits with status code 0.

The script depends on the [`requests`](https://requests.readthedocs.io/en/latest/) library.

## scan_logs.py

This script looks for indicators of compromise in a CrushFTP server installation directory. It is basically equivalent to running the following command:

```
$ grep -F -r '<INCLUDE>' /path/to/CrushFTP/logs/
```

For each match, it will attempt to extract the IP which tried to exploit the server.
