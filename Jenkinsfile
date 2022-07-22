pipeline {
    agent any

    
        stages {
            stage ('check out') 
            {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-id', url: 'https://github.com/rajuth/maven-jenkin.git']]])
            }
        }
            stage ('build war') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage ('move war to neuxs') {
            steps {
              script {
                def mavenPom = readMavenPom file: "pom.xml"
                nexusArtifactUploader artifacts: 
                [
                    [
                        artifactId: 'wwp', 
                        classifier: '', 
                        file: "target/wwp-${mavenPom.version}.war", 
                        type: 'war'
                    ]
                ], 
                        credentialsId: 'nuxes-admin', 
                        groupId: 'com.web', 
                        nexusUrl: '192.168.56.113:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: 'node-app', 
                        version: "${mavenPom.version}"
              }

                
            }
        }
        stage ('build image') {
            steps {
                  sshagent (credentials: ['jenkins-system']) {
    sh 'ssh -o StrictHostKeyChecking=no root@192.168.56.113 "cd /var/lib/jenkins/workspace/maven-project/&&docker build . -t 192.168.56.112:5000/maven:${BUILD_ID}"'
  }
            }
        }
        
 
    }
    
}
