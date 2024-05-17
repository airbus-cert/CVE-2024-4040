param (
    [string]$dir
)

function Main {
    param (
        [string]$dir
    )

    if (-not (Test-Path -Path (Join-Path -Path $dir -ChildPath "CrushFTP.jar"))) {
        Write-Output "[!] The following directory does not look like a CrushFTP installation folder: $dir"
        exit 1
    }

    $logFiles = @(
        (Join-Path -Path $dir -ChildPath "CrushFTP.log")
    ) + (Get-ChildItem -Path (Join-Path -Path $dir -ChildPath "logs/session_logs/*/session_HTTP_*.log") -File).FullName + (Get-ChildItem -Path (Join-Path -Path $dir -ChildPath "logs/CrushFTP.log*") -File).FullName

    foreach ($fname in $logFiles) {
        if ([string]::IsNullOrEmpty($fname)) {
            continue
        }
        
        if (Test-Path -Path $fname) {
            $txt = Get-Content -Path $fname -Raw

            if ($txt -match "<INCLUDE>") {
                $lines = $txt -split "`n" | Where-Object { $_ -match "<INCLUDE>" }

                foreach ($line in $lines) {
                    try {
                        $ip = ($line -split "\|")[2] -split ":" | Select-Object -Last 1 -split "\]" | Select-Object -First 1
                        Write-Output "$fname`: traces of exploitation by $ip"
                    } catch {
                        Write-Output "$fname`: traces of exploitation"
                    }
                }
            }
        }
    }
}

Main -dir $dir