# Must have `sentry-cli` installed globally
# Following variable must be passed in
#  
SENTRY_AUTH_TOKEN=0b6a5ae8061044b9b3ac2d03e6ed93bee56491edabca4353af28f3c0a449394b
SENTRY_ORG=myorg001
SENTRY_PROJECT=js-frontend
PREFIX=dist/

RELEASE_VERSION=0.0.1

#`sentry-cli releases propose-version`

deploy: build setup_release start

build: 
	npm run build

start: 
	npm run start

setup_release: create_release associate_commits upload_sourcemaps

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(RELEASE_VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(RELEASE_VERSION) \
		upload-sourcemaps --url-prefix "~/dist" --validate dist
