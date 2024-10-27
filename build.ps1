# build.ps1

# Добавляем отображение текущих действий
Write-Host "Starting build process..." -ForegroundColor Green

# Переходим в папку Documentation
Set-Location Documentation
Write-Host "Changed directory to Documentation" -ForegroundColor Yellow

# Очистка
Write-Host "Cleaning up old files..." -ForegroundColor Yellow
Remove-Item -Path _site -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path obj -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "Cleanup completed" -ForegroundColor Green


# Генерация metadata
Write-Host "Generating metadata..." -ForegroundColor Yellow
docfx metadata
Write-Host "Metadata generation completed" -ForegroundColor Green

# Генерация PDF
Write-Host "Generating PDF..." -ForegroundColor Yellow
docfx pdf
Write-Host "PDF generation completed" -ForegroundColor Green

# Проверяем, что PDF сгенерировались
if (Test-Path "_site/_pdf/Documentation_api.pdf") {
    Write-Host "PDF files generated successfully" -ForegroundColor Green
} else {
    Write-Host "Warning: PDF files not found in expected location" -ForegroundColor Yellow
}

# Запускаем сервер
Write-Host "Starting docfx server..." -ForegroundColor Yellow
docfx build --serve

# Добавляем паузу в конце
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")