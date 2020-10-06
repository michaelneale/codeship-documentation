---
title: Getting started with Jenkins Pipelines on CodeShip Pro
menus:
  pro/jenkins-support:
    title: Getting Started
    weight: 2
tags:
  - jenkins
  - pro
  - container
  - jenkinsfile-runner

categories:
  - Builds and Configuration
  - Docker
  - Configuration
  - Jenkins

redirect_from:
  - /pro/jenkins-support/quickstart/

---

This page provides a quick start guide for running a Jenkins Pipeline inside CodeShip Pro.
In this guide we will use the [vanilla Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner/tree/master/vanilla-package) image provided by the Jenkins project.
This image will be replaced by the CloudBees-provided image once it is available.

{% jenkinssupportnote info %}
{% endjenkinssupportnote %}

## Prerequisites

* You have an account on CodeShip
* You have a GitHub account

## References

The easiest way to get started is to fork one of the existing demos.
In this example we will use the [oleg-nenashev/codeship-jfr-java-maven-demo](https://github.com/oleg-nenashev/codeship-jfr-java-maven-demo) demo repository.

* Go to the [https://github.com/oleg-nenashev/codeship-jfr-java-maven-demo](demo repository) and fork the project to your GitHub Account.
* Go to the [Projects Dashboard](https://app.codeship.com/projects) on CodeShip and click on the _New project_ button.
* In the _Select Your SCM_ dialog choose GitHub.
* Follow the steps in the _Connect Your GitHub Repository_ dialog to connect your demo repository to CodeShip.
  If it is not available, you may need to configure the CodeShip GitHub App so that it can access the repository.
* In the project type selection dialog select the _CodeShip Pro_ option.
  Then you will see the _What's next?_ screen, but all steps are already completed in the forked demo..
* Go to your repository, and submit a commit to it.
  For example, it can be done by editing the README from the GitHub Web UI.
* Go back to the CodeShip project page.
  You should see the running build for your project.
* Go to the build page. You should see CodeShip scheduling and then executing your Pipeline, with with the `jenkinsfileRunner` step being invoked.
* Wait until the build completion. You will see the specified Jenkins Pipeline being executed by the serverless Jenkins Pipeline executor provided by CodeShip Pro.

## Creating your first project

* Create a new repository on GitHub.
* Add the `codeship-services.yml` file to the repository.
   We will be using an existing Jenkinsfile Runner vanilla image for the demo.

```yaml
jenkinsfileRunner:
  image: jenkins/jenkinsfile-runner:1.0-beta-17
  volumes:
    - .:/workspace
```

* Add the `codeship-steps.yml` file to the repository.
   This step will execute the Jenkinsfile Runner image and pass the workspace checked out by CodeShip.

```yaml
- name: Run Jenkinsfile
  service: jenkinsfileRunner
  command: -f /workspace
```

* Add a `Jenkinsfile` to your repository.
   This file will be executed by Jenkinsfile Runner.
   We will use the Declarative Pipeline syntax.

```groovy
pipeline {
    agent none
    stages {
        stage('Print message') {
          steps {
            echo "Hello, world!"
          }
        }
    }
}
```

* Go to the [Projects Dashboard](https://app.codeship.com/projects) on CodeShip and click on the _New project_ button.
* In the _Select Your SCM_ dialog choose GitHub.
* Follow the steps in the _Connect Your GitHub Repository_ dialog to connect your demo repository to CodeShip.
  If it is not available, you may need to configure the CodeShip GitHub App so that it can access the repository.
* In the project type selection dialog select the _CodeShip Pro_ option.
  Then you will see the _What's next?_ screen, but the steps are already completed.
* Go to your repository, and submit a commit to it.
  For example, it can be done by editing the README from the GitHub Web UI.
* Go back to the CodeShip project page.
  You should see the running build for your project.
* Go to the build page. You should see CodeShip scheduling and then executing your Pipeline, with with the `jenkinsfileRunner` step being invoked.
* Wait until the build completion. You will see the specified Jenkins Pipeline being executed by the serverless Jenkins Pipeline executor provided by CodeShip Pro.

Please refer to other documentation pages to see more advanced demos for Jenkins Pipeline support on CodeShip Pro.
