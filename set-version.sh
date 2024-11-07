#!/bin/bash -e

NEW_VERSION=$1

mvn versions:set -Dversion.keycloak=$NEW_VERSION -DnewVersion=$NEW_VERSION -DgenerateBackupPoms=false -DgroupId=org.keycloak* -DartifactId=*

if [[ $NEW_VERSION == "999.0.0-SNAPSHOT" ]]; then
  # Use the nightly versions of adapters
  NPM_ADMIN_CLIENT="https://github.com/keycloak/keycloak/releases/download/nightly/keycloak-admin-client-999.0.0-SNAPSHOT.tgz"
  NPM_NODE_ADAPTER="https://github.com/keycloak/keycloak-nodejs-connect/releases/download/nightly/keycloak-nodejs-connect.tgz";
else
  # Make only "26.0.5" from something like "26.0.5.redhat-00003"
  arrIN=(${NEW_VERSION//\./ })
  NEW_NPM_VERSION=${arrIN[0]}.${arrIN[1]}.${arrIN[2]}
  echo "New NPM version $NEW_NPM_VERSION";
  NPM_ADMIN_CLIENT=$NEW_NPM_VERSION
  NPM_NODE_ADAPTER=$NEW_NPM_VERSION
fi

# JS quickstart
npm i @keycloak/keycloak-admin-client@$NPM_ADMIN_CLIENT --prefix js/spa
npm i keycloak-js@$NPM_ADMIN_CLIENT --prefix js/spa

# NodeJS quickstart
npm i @keycloak/keycloak-admin-client@$NPM_ADMIN_CLIENT --prefix nodejs/resource-server
npm i keycloak-connect@$NPM_NODE_ADAPTER --prefix nodejs/resource-server

echo "New Mvn Version: $NEW_VERSION" >&2
echo "Used NPM dependency of keycloak-admin-client: $NPM_ADMIN_CLIENT" >&2
echo "Used NPM dependency of node-adapter: $NPM_NODE_ADAPTER" >&2

