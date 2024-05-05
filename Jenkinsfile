pipeline {
    
    agent any

    environment {
        latestCommitId = """${sh(
            returnStdout:true,
            script:'git log -n1 --format="%h"'
        )}"""
    }

    stages {
        stage('checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/veereshh/spring-demo.git'
            }
        }
        stage('build'){
            steps{
                sh 'chmod 744 mvnw'
                sh './mvnw clean package'
            }
        }
        stage('build docker image'){
            steps{
                sh 'docker build -t spring-demo:${latestCommitId} .'
            }
        }
        stage('push docker image'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerregistry')]) {
                    sh 'docker login -u veereshh220 -p ${dockerregistry}'
                    sh 'docker tag spring-demo:${latestCommitId} veereshh220/spring-demo:${latestCommitId}'
                    sh 'docker push veereshh220/spring-demo:${latestCommitId}'
                }   
            }
        }
        stage('deploy app in k8s cluster'){
            steps{
                sh 'sudo helm install spring-demo  ./springdemo/ --set imageTag=${latestCommitId} --values ./springdemo/values.yaml '
            }
            
        }
    }
}