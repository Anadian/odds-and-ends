#!/usr/bin/env node

import PathNS from 'node:path';
import Sh from 'shelljs';

if( process.argv.length === 4 ){
	var absolute_path = PathNS.resolve( process.argv[2] );
	console.log(absolute_path);
	var relative_to_home = PathNS.relative( Sh.env['HOME'], absolute_path );
	var script_path = '$HOME/'+relative_to_home;

	var shim_script = `#!/bin/sh
basedir=$(dirname "$(echo "$0" | sed -e 's,\\\\,/,g')")

case \`uname\` in
    *CYGWIN*) basedir=\`cygpath -w "$basedir"\`;;
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
exec node "${script_path}" "$@"`;
	var shim_path = PathNS.resolve( process.argv[3] );
	console.log(shim_path);
	Sh.echo( shim_script ).to( shim_path );
	Sh.chmod( '777', shim_path );
}
