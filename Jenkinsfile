pipeline {
agent {
node {
label ‘master’
}
}
stages {
stage(‘Continuous Integration’) {
steps {
withMaven(jdk: ‘JAVA_HOME’, maven: ‘MAVEN_HOME’) {
bat ‘mvn clean’
bat(script: ‘mvn test cobertura:cobertura install’, label: ‘Unit Testing and Code Coverage’)
cobertura(autoUpdateHealth: true, autoUpdateStability: true, classCoverageTargets: ‘target/site/cobertura/’, coberturaReportFile: ‘target/site/cobertura/*.xml’, failUnstable: true, zoomCoverageChart: true)
}
}
}
}
}
