# Personal
### (But not private. Do whatever you want with any of this)
<br />
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

## Convert CIDR IP Range to dnscrypt format
```
chmod +x CIDRtoIP.sh
```
```
touch completely.expanded.single.ips.txt && cat Facebook.Instagram.CIDR.Notation.IPs.txt Google.CIDR.Notation.IPs.txt | while IFS= read -r line ; do ./CIDRtoIP.sh "$line" >>completely.expanded.single.ips.txt; done
```
```
touch converted.to.dnscrypt.format.txt && cat completely.expanded.single.ips.txt | perl -0777 -pe 's/^(\d+\.\d+\.\d+.)(0)(?:\1\d+|\n)+(?<=255)/$1*\n/gim' | perl -0777 -pe 's/(?<!\n)\n(?=\d)/\n\n/gim' > converted.to.dnscrypt.format.txt
```
