#!/bin/sh

echo "Corn Job Started";

host ="https://domain.com"  #keep your sitemap.xml in root of your server.

today="$(date)"

echo "<?xml version='1.0' encoding='us-ascii'?>" >> logs.xml

echo "<cron start='$today'>" >>  logs.xml
 
urls=$(curl -s $host/sitemap.xml  --insecure  | grep "<loc>" | awk -F"<loc>" '{print $2} ' | awk -F"</loc>" '{print $1}')
for i in $urls 
do
    start="$(date)"
	wget $i --delete-after --no-check-certificate
	end="$(date)"
	echo "<crawl><start>$start</start><url>$i</url><end>$end</end></crawl>" >>  logs.xml
done
echo "</corn>" >> logs.xml
