#!/bin/sh

TARGET_DIR="node_modules"

if [ ! -d "$TARGET_DIR" ]; then
	echo "$TARGET_DIR does not exist"
	exit 1
fi

PATTERNS="
	__tests__
	_config.yml
	.*ignore
	.babel*
	.circle*
	.documentup*
	.ds_store
	.editorconfig
	.env*
	.git*
	.idea
	.lint*
	.npm*
	.nyc*
	.prettier*
	.tern-project
	.yarn-integrity
	.yarn-metadata.json
	.yarnclean
	.yo-*
	*.coffee
	*.flow*
	*.jst
	*.markdown
	*.md
	*.mkd
	*.swp
	*.tgz
	*appveyor*
	*coveralls*
	*eslint*
	*htmllint*
	*jshint*
	*.lcov
	*readme*
	*stylelint*
	*travis*
	*tslint*
	*vscode*
	*wallaby*
	authors*
	AUTHORS*
	changelog*
	CHANGELOG*
	changes
	circle.yml
	component.json
	contributors*
	CONTRIBUTORS*
	coverage
	doc
	docs
	example
	examples
	grunt*
	gulp*
	jenkins*
	jest.config.*
	jsconfig.json
	karma.conf*
	licence*
	license*
	LICENSE*
	LICENCE*
	makefile
	Justfile
	.yarn-integrity
	powered-test
	logs
	*.logs
	npm-debug.log*
	yarn-debug.log*
	yarn-error.log*
	lerna-debug.log*
	.pnpm-debug.log*
	.yarn-integrity
	prettier.*
	test
	tests
	tsconfig.json
	.flowconfig
	.yo-rc.json
	images
	assets
	.circleci
	website
	powered-test
	demo
	demos
"

PROD_PATTERNS="
	*.map
	*.mts
	*.ts
"

patterns="$PATTERNS"
if [ "$NODE_ENV" = "production" ]; then
	patterns="$patterns $PROD_PATTERNS"
fi

if [ "$NODE_ENV" != "production" ]; then
	echo "$TARGET_DIR size before: $(du -sh "$TARGET_DIR" | awk '{print $1}')"
fi

find_cmd="find $TARGET_DIR \( "
first_pattern=true

for pattern in $patterns; do
	find_cmd="$find_cmd $([ "$first_pattern" = true ] && echo "" || echo "-o") -iname '$pattern'"
	first_pattern=false
done

find_cmd="$find_cmd \) -delete"

eval "$find_cmd"

if [ "$NODE_ENV" != "production" ]; then
	echo "$TARGET_DIR size after:  $(du -sh "$TARGET_DIR" | awk '{print $1}')"
fi
