#!/usr/bin/env bash
set -e

echo "start building artifacts by Maven..."

# Use a dedicated folder outside the build folder so reuse becomes possible

M2_HOME=${HOME}/.m2
mkdir -p ${M2_HOME}

M2_LOCAL_REPO="$( pwd )/.m2"
mkdir -p "${M2_LOCAL_REPO}/repository"

cat > ${M2_HOME}/settings.xml <<EOF

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                          https://maven.apache.org/xsd/settings-1.0.0.xsd">
      <localRepository>${M2_LOCAL_REPO}/repository</localRepository>
</settings>

EOF


# Maven build
mvn --version
mvn package -f resource-git/articulate/pom.xml

# Copy it to output folder
cp resource-git/articulate/target/articulate-*.jar artifacts/
ls -lat artifacts/



