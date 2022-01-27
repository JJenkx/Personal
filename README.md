# Personal
### (But not private. Do whatever you want with any of this)
<br />
<br />


## Get random quotes from deadwood
All
```
printf '\n' ; perl -e 'srand; rand($.) < 1 && ( $line = $_ ) while <>; print $line' /home/jjenkx/Scripts/deadwood.txt | perl -p -e 's/    /\n\n/g' | fold -w 80 -s ; printf '\n'
```
Jane
```
printf '\n' ; perl -e 'srand; rand($.) < 1 && ( $line = $_ ) while <>; print $line' jane.deadwood.txt | perl -p -e 's/    /\n\n/g' | fold -w 80 -s ; printf '\n'
```
<br />
<br />
<br />

## Convert CIDR IP Range to dnscrypt format for InviZible Pro

credit https://stackoverflow.com/questions/16986879/bash-script-to-list-all-ips-in-prefix/22499574#22499574 for .sh script
```
chmod +x CIDRtoIP.sh
```
```
touch completely.expanded.single.ips.txt && cat Facebook.Instagram.CIDR.Notation.IPs.txt Google.CIDR.Notation.IPs.txt | while IFS= read -r line ; do ./CIDRtoIP.sh "$line" >>completely.expanded.single.ips.txt; done
```
```
touch converted.to.dnscrypt.format.txt && cat completely.expanded.single.ips.txt | perl -0777 -pe 's/^(\d+\.\d+\.\d+.)(0)(?:\1\d+|\n)+(?<=255)/$1*\n/gim' | perl -0777 -pe 's/(?<!\n)\n(?=\d)/\n\n/gim' > converted.to.dnscrypt.format.txt
```
<br />

The file with the properly formatted schema for "ip-blacklist.txt" will be "converted.to.dnscrypt.format.txt"

<br />

Backup InviZible Pro to a zip file.

<br />

Paste the contents from file "converted.to.dnscrypt.format.txt" into IZBackup.zip/app_data/dnscrypt-proxy/ip-blacklist.txt

<br />

Save zip file

<br />

Restore from zip
