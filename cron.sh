#!/bin/bash
echo 'OddsandEnds/cron.sh';
date -u --iso-8601='seconds';
git checkout master;
git add --all .;
if git commit -m 'Cron.sh auto commit.' ; then
	git push origin master;
else
	git pull origin master;
fi
