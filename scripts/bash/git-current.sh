#!/bin/bash
git --no-pager show > current-commit;
head -n 1 current-commit;
rm current-commit;
