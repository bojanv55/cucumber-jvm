SHELL := /usr/bin/env bash

update-dependencies:
	mvn versions:force-releases
	mvn versions:update-properties -DallowMajorUpdates=false -Dmaven.version.rules="file://`pwd`/.m2/maven-version-rules.xml"
.PHONY: update-dependencies

update-changelog:
ifdef NEW_VERSION
	cat CHANGELOG.md | ./scripts/update-changelog.sh $(NEW_VERSION) > CHANGELOG.md.tmp
	mv CHANGELOG.md.tmp CHANGELOG.md
else
	@echo -e "\033[0;31mNEW_VERSION is not defined. Can't update version :-(\033[0m"
	exit 1
endif
.PHONY: update-changelog