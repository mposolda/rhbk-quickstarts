Product testing notes
---------------------

Here are some notes for how to test this quickstart with the Red Hat build of Keycloak from the product repository, which is not yet published online.
This repository can be on the URL, which is private and does not refer to the SSL certificate signed by any well-known root certificate authority and hence some more tweaks might be 
needed due to this.

In order to test this, you may need properly set file like `/home/<yourhome>/.m2/settings-prod-rhbk.xml` with the RH private 
product repositories (indy etc) and you will need what is the URL of the private repository. This is referenced below as 
`<maven-repository-url>`. Please contact some RH engineers aware of the product for this.

Here some commands, which you may need to update according to your environment.

```
export VERSION=<replace with the proper version>

./set-version.sh $VERSION

export PRODUCT=true

# Seems to be needed on maven repository on the "https" URL, which is not signed by well-known root CA
export SKIP_SSL_VALIDATIONS=true

# Needed on my laptop to be able to run the tests with latest chrome version. It must point to the directory with the file "chromedriver" inside it
export CHROMEWEBDRIVER=/<somedir>/chromedriver-linux64-119.0.6045.105

# Replace with the URL from which the product would be downloaded
export PRODUCT_BUNDLE_URL=<maven-repository-url>/org/keycloak/keycloak-quarkus-dist/$VERSION/keycloak-quarkus-dist-$VERSION.tar.gz

# Replace with the settings file containing references to prod repositories
export PRODUCT_MVN_SETTINGS=/home/<yourhome>/.m2/settings-prod-rhbk.xml

# Set to your local maven repository or different repository (if you prefer product bits to not be available in your local maven repo)
export PRODUCT_MVN_REPO=/home/<yourhome>/.m2/repository

.github/scripts/prepare-local-server.sh
.github/scripts/start-local-server.sh extension

.github/scripts/run-tests.sh extension
.github/scripts/run-tests.sh spring
.github/scripts/run-tests.sh js
.github/scripts/run-tests.sh nodejs
.github/scripts/run-tests.sh jakarta
```