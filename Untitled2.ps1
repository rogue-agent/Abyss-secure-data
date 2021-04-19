$store = "cert:\CurrentUser\My"

$params = @{
 CertStoreLocation = $store
 Subject = "CN=Test1"
 KeyLength = 4096
 KeyAlgorithm = "RSA" 
 KeyUsage = "DataEncipherment"
 Type = "DocumentEncryptionCert"
}

# generate new certificate and add it to certificate store
$cert = New-SelfSignedCertificate @params

# Exporting/Importing certificate
Write-Host "We will now create a password for your private key and username so we can send you the secure data."

pause

$user = Read-Host -Prompt 'Input a username'
$pwd = (Read-Host -Prompt 'Input a Password' | ConvertTo-SecureString -AsPlainText -Force)
$privateKey = "$home\Documents\Private-Key.pfx"
$publicKey = "$home\Documents\Public-Key.cer"

# Export private key as PFX certificate, to use those Keys on different machine/user
Export-PfxCertificate -FilePath $privateKey -Cert $cert -Password $pwd

# Export Public key, to share with other users
Export-Certificate -FilePath $publicKey -Cert $cert

#Remove certificate from store
$cert | Remove-Item

# Add them back:
# Add private key on your machine
Import-PfxCertificate -FilePath $privateKey -CertStoreLocation $store -Password $pwd

# This is for other users (so they can send you encrypted messages)
Import-Certificate -FilePath $publicKey -CertStoreLocation $store

Write-Host "Now please log in to your email account so you can send us the public key"

pause

$email = Read-Host -Prompt 'Input your email'
$domain = Read-Host -Prompt 'Input your email domain name, example: gmail.com'
$user = Read-Host -Prompt 'Input a username'
$pwem = Read-Host -Prompt 'Input your email password'

Send-MailMessage -Smtpserver $domain -Credential  -From $email -To "admin@abyss.fi" -Subject "Public key" -Body "Public key from user" -Attachments "$home\Documents\Public-Key.cer"
