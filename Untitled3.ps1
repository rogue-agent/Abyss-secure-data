# Encryption / Decryption

$message = "My secret message"

$cipher = $message  | Protect-CmsMessage -To "CN=Test1" 
Write-Host "Cipher:" -ForegroundColor Green
$cipher

Write-Host "Decrypted message:" -ForegroundColor Green
$cipher | Unprotect-CmsMessage