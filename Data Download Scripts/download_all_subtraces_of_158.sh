#!/bin/bash
#
# This script can only be run from the computer on which it was
# originally downloaded.
#
# This auto-generated script was downloaded from http://iotta.snia.org.
# It will download the 16 subtraces of Microsoft Production Server Traces
#
echo "Downloading the 16 subtraces of Microsoft Production Server Traces" 1>&2
cookies=$(mktemp)
cat >> $cookies << 'EOF'
# Netscape HTTP Cookie File
# http://curl.haxx.se/rfc/cookie_spec.html
# This file was generated by iotta.snia.org! Edit at your own risk.

.iotta.snia.org	TRUE	/	FALSE	0	infodigest	1be17021d643167953a68a72a7b2282d8e11b4a5
.iotta.snia.org	TRUE	/	FALSE	0	legal	true
.iotta.snia.org	TRUE	/	FALSE	0	id	628744
EOF

if which wget >/dev/null 2>&1; then
  useWGET=true
elif which curl >/dev/null 2>&1; then
  useCURL=true
else
  echo "Couldn't find either wget or curl. Please install one of them" 1>&2
  exit 1
fi

checkForError() {
  delete=false
  if $useWGET && (( $1 == 2 || $1 == 3 || $1 == 5 || $1 == 7 || $1 == 8 ))
  then
    delete=true
  elif $useWGET && [ ! -s "$2" ]
  then
    delete=true
  elif $useCURL && (( $1 == 22 || $1 == 36 ))
  then
    delete=true
  fi
}

downloadFile() {
  file=$1
  id=$2
  url="http://server4.iotta.snia.org/traces/$id/download?type=file&sType="
  if $useWGET; then
    wget -q --load-cookies=$cookies -O "$file" -c "$url""wget"
  elif $useCURL; then
    curl -s -f -b $cookies -o "$file" -C - -L "$url""curl"
  fi

  if [ $? -eq 0 ]; then
    echo "Finished Downloading $file"
  else 
    checkForError $? "$file"
    if $delete; then
      echo "There was an error downloading the file ($file)"
      rm -f "$file"
    else
      echo "$file was partially downloaded"
    fi
    echo "Stopping..."
    exit 1
  fi
}

downloadFile "BuildServer00.zip" 159
downloadFile "BuildServer01.zip" 160
downloadFile "BuildServer02.zip" 161
downloadFile "BuildServer03.zip" 162
downloadFile "BuildServer04.zip" 163
downloadFile "BuildServer05.zip" 164
downloadFile "BuildServer06.zip" 165
downloadFile "BuildServer07.zip" 166
downloadFile "DevelopmentToolsRelease.zip" 175
downloadFile "DisplayAdsDataServer.zip" 176
downloadFile "DisplayAdsPayload.zip" 177
downloadFile "LiveMapsBackEnd.zip" 178
downloadFile "MSNStorageCFS.zip" 179
downloadFile "MSNStorageFileServer.zip" 180
downloadFile "RadiusAuthentication.zip" 181
downloadFile "RadiusBackEndSQLServer.zip" 182

echo "Finished All Downloads"
rm -f $cookies
