#!/usr/bin/env bash
set -e

echo "start building artifacts..."

# Use a dedicated folder outside the build folder so reuse becomes possible

MAVEN_HOME=${HOME}/.m2
MAVEN_REPO=${HOME}/.m2/repository
mkdir -p ${MAVEN_REPO}


# Construct the Maven settings.xml

cat > ${M2_HOME}/settings.xml <<EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository>${MAVEN_REPO}</localRepository>
</settings>
EOF


# Maven build
mvn package -f resource-git/articulate/pom.xml

# Copy it to output folder
cp resource-git/articulate/target/articulate-*.jar artifacts/
ls -lat artifacts/