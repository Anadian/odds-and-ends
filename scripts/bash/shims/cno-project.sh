#!/bin/sh
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')")

case `uname` in
    *CYGWIN*) basedir=`cygpath -w "$basedir"`;;
esac

if [ -z "$NODE_PATH" ]; then
  export NODE_PATH="$HOME/dev/OddsandEnds/scripts/node:$HOME/dev/OddsandEnds/node_modules:$HOME/.local/share/pnpm/global/5/.pnpm/node_modules"
else
  export NODE_PATH="$HOME/dev/OddsandEnds/scripts/node:$HOME/dev/OddsandEnds/node_modules:$HOME/.local/share/pnpm/global/5/.pnpm/node_modules:$NODE_PATH"
fi
#if [ -x "$basedir/node" ]; then
#  exec "$basedir/node"  "$basedir/global/5/node_modules/oddsandends/scripts/node/init-node-project.js" "$@"
#else
#  exec node  "$basedir/global/5/node_modules/oddsandends/scripts/node/init-node-project.js" "$@"
#fi
exec node "$HOME/dev/OddsandEnds/scripts/node/cno-project.js" "$@"
