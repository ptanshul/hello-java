// Based on:
// https://raw.githubusercontent.com/redhat-cop/container-pipelines/master/basic-helm-spring-boot/Jenkinsfile

library identifier: "pipeline-library@v1.5",
retriever: modernSCM(
  [
    $class: "GitSCMSource",
    remote: "https://github.com/redhat-cop/pipeline-library.git"
  ]
)

// URL and Ref to the Spring Boot application
appSourceUrl = "https://github.com/monodot/hello-java.git"
appSourceRef = "develop"

// Folder containing the app source code
appFolder = "app"

// Folder containing the Helm pipeline
helmFolder = "basic-helm-spring-boot"

// The name you want to give your Spring Boot application
// Each resource related to your app will be given this name
appName = "hello-java"

pipeline {
    // Use the 'maven' Jenkins agent image which is provided with OpenShift 
    agent { label "maven" }
    stages {
        stage("Checkout") {
            steps {
                // This creates a separate folder to clone the Spring Boot app to
                checkout scm
                // sh "mkdir ${appFolder}"

                // dir(appFolder) {
                //     git url: "${appSourceUrl}", branch: "${appSourceRef}"
                // }
            }
        }
        stage("Get Version from POM") {
            steps {
                script {
                    // dir(appFolder) {
                        tag = readMavenPom().getVersion()
                    // }
                }
            }
        }
        stage("Docker Build") {
            steps {
                // This installs or upgrades the spring-boot-build Helm chart.
                // It creates or updates your application's BuildConfig and ImageStream
                // dir(helmFolder) {
                    sh "helm upgrade --install ${appName}-build charts/hello-java-build --set name=${appName} --set tag=${tag}"
                // }

                // This uploads your application's source code and performs a binary build in OpenShift
                // dir(appFolder) {
                    binaryBuild(buildConfigName: appName, buildFromPath: ".")
                // }
            }
        }
        stage("Deploy") {
            steps {
                // This installs or upgrades the spring-boot Helm chart
                // It creates or updates your application's Kubernetes resources
                // It also waits until the readiness probe returns successfully
                // dir(helmFolder) {
                    sh "helm upgrade --install ${appName} charts/hello-java-build --set tag=${tag} --wait"
                // }
            }
        }

        // You can now tag the image, and promote it to a production environment, etc.
    }
}
