# build.ps1

# Display current actions in progress
Write-Host "Starting build process..." -ForegroundColor Green

# Navigate to Documentation folder
Set-Location Documentation
Write-Host "Changed directory to Documentation" -ForegroundColor Yellow

# Cleanup old generated files
Write-Host "Cleaning up old files..." -ForegroundColor Yellow
Remove-Item -Path _site -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path obj -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Cleanup completed" -ForegroundColor Green


# Generate API metadata
Write-Host "Generating metadata..." -ForegroundColor Yellow
docfx metadata
Write-Host "Metadata generation completed" -ForegroundColor Green

# Generate PDF documentation
Write-Host "Generating PDF..." -ForegroundColor Yellow
docfx pdf
Write-Host "PDF generation completed" -ForegroundColor Green

# Verify PDF generation
if (Test-Path "_site/_pdf/Documentation_api.pdf") {
    Write-Host "PDF files generated successfully" -ForegroundColor Green
} else {
    Write-Host "Warning: PDF files not found in expected location" -ForegroundColor Yellow
}

# Start local documentation server
Write-Host "Starting docfx server..." -ForegroundColor Yellow
docfx build --serve

# Wait for user input before closing
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")