# Docker Jenkins Template

Simple template for docker Jenkins.

## Getting Started

Once you have the clone of the repo. Set the .env variables if you need to but it should work fine in your local development with current variables.

### Prerequisites
- [Docker Traffic](https://github.com/madan95/docker-traffic)
- Docker
- Docker-compose
- Make

### Installing

- Make sure Docker Traffic is running.
- Create a Directory jenkins_home to store persistent Jenkins data.
- Make 1000 the owner of jenkins_home.

`` mkdir jenkins_home && sudo chown 1000 jenkins_home ``

Build Jenkins (One Time Thing)

```
make docker-build
```

Fires up startJenkins script that creates Jenkins container, add ssh keys inside the container and copy it to authorized_key for HOST machine so we can use ssh from Jenkins container during pipeline to our host machine.

At the end of build process, It will printout one time initialAdminPassword at the end which you use can copy and use when it is asked when you use Jenkins for the first time.


## Running the tests

Now you should be able to access Jenkins using https://jenkins.localhost.

Source-code Management -> Git -> Repo URL (https)
Build Triggers - > Github hook trigger for GITScm polling
In git repo -> Add webhooks (https://jenkins-hostname-url/github-webhook/) 

Once you have all initial set up ready, we can create a new pipe line and have a script. Example :

```

node{
    stage('Scm Commit'){
      git credentialsId: 'git-cred', url: 'https://github.com/madan95/drupal-base'
    }
    stage('Run Container'){
      sh "ssh -T -o StrictHostKeyChecking=no username@hostname ./start.sh"
    }
}

```
or Just use Execute shell 

```
ssh -T -o StrictHostKeyChecking=no username@hostname ./custom-build-script-to-run.sh
```

## Built with

- Docker

## Versioning

We use [SemVer](https://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/madan95/dockerTemple/tags).


## Author
- Madan Limbu
