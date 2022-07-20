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
                nexusArtifactUploader artifacts: 
                [
                    [
                        artifactId: 'wwp', 
                        classifier: '', 
                        file: 'target/wwp-1.0.0-SNAPSHOT.war', 
                        type: 'war'
                    ]
                ], 
                        credentialsId: 'nuxes-admin', 
                        groupId: 'web.war', 
                        nexusUrl: '192.168.56.113:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: 'node-app', 
                        version: '1.0.0-SNAPSHOT'

                
            }
        }
        
 
    }
    
}
        }
    }
}
