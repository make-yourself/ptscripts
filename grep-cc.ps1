Get-ChildItem -Directory -Recurse | ForEach-Object {
    $Found = $false;
    $i = 0;

    $Files = $_ | Get-ChildItem -File | Sort-Object -Property Name;

    for ($i = 0; ($Files[$i] -ne $null) -and ($Found -eq $false); $i++) {
        $SearchResult = $Files[$i] | Select-String "[456][0-9]{15}","[456][0-9]{3}[-| ][0-9]{4} [-| ][0-9]{4}[-| ][0-9]{4}";
        if ($SearchResult) {
            $Found = $true;
            Write-Output $SearchResult;
        }
    }
}