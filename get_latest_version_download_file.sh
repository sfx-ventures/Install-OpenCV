# Dan Walkes
# 2014-01-29
# Find the latest version and download file link from the OpenCV sourceforge page

version="$(wget -q -O - http://sourceforge.net/projects/opencvlibrary/files/ | egrep -o '\"[0-9](\.[0-9]+)+(-[-a-zA-Z0-9]+)?' | cut -c2- |sort -V -r -u |head -1)"
downloadfilelist="OpenCV%20$version.tar.gz OpenCV%20$version.zip"
downloadfile=
for file in $downloadfilelist;
do
        wget --spider http://sourceforge.net/projects/opencvlibrary/files/$version/$file/download
        if [ $? -eq 0 ]; then
                downloadfile=$file
        fi
done
if [ -z "$downloadfile" ]; then
        echo "Could not find download file on sourceforge page.  Please find the download file for version $version at"
        echo "http://sourceforge.net/projects/opencvlibrary/files/$version/ and update this script"
        exit  1
fi
