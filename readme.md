Pipeline Script Example :

node{
    stage('Scm Commit'){
        git credentialsId: 'git-cred', url: 'https://github.com/madan95/drupal-base'
    }
    stage('Run Container'){
        def dockerRun = 'ls -la && whoami && cd decop && ls -la && pwd && ls -la && docker-compose up -d --build'
        sshagent(['dd']) {
            sh "ssh -T madan@vps444173.ovh.net ./start.sh"
        }
    }
}


./start.sh 

cd project
docker-compose up -d --build
