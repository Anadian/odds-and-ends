#!/bin/bash
echo 'OddsandEnds/cron.sh';
date -u --iso-8601='seconds';
git checkout main;
git add --all .;
if git commit -m 'Cron.sh auto commit.' ; then
	git push origin main;
else
	git pull origin main;
fi
