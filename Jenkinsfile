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
                sh 'docker tag spring-demo:${latestCommitId} veereshh220/demo'
                sh 'docker push veereshh220/demo'
            }
        }
        stage('deploy app in k8s cluster'){
            steps{
                ech 'hi'
            }
            
        }
    }
}