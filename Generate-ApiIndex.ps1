# Generate-ApiIndex.ps1
param (
    [string]$apiPath = "Documentation/api"
)

# Create content for index.md
$indexContent = @"
# API Documentation

This documentation includes all the public types and members from the project.

## Namespaces

"@

# Get all namespaces (directories)
$namespaces = Get-ChildItem -Path $apiPath -Filter "*.html" | 
    Where-Object { $_.Name -notlike "*index*" -and $_.Name -notlike "*toc*" }

foreach ($namespace in $namespaces) {
    $namespaceName = $namespace.BaseName
    $indexContent += "`n### $namespaceName`n`n"
    
    # Get all types in namespace
    $types = Get-ChildItem -Path $apiPath -Filter "$namespaceName.*.html"
    foreach ($type in $types) {
        $typeName = $type.BaseName.Replace("$namespaceName.", "")
        $indexContent += "* [$typeName]($($type.Name))`n"
    }
}

# Write to index.md
$indexContent | Out-File -FilePath "$apiPath/index.md" -Encoding UTF8