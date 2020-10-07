---
title: Building custom Jenkinsfile Runner images
menus:
  pro/jenkins-support:
    title: Building custom images
    weight: 4
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
  - Continuous Integration
  - Continuous Delivery

redirect_from:
  - /pro/jenkins-support/introduction/

---

{:toc}

{% jenkinssupportnote info %}
{% endjenkinssupportnote %}

This section documents how to extend.

## When to extend Jenkinsfile Runner images?

CloudBees intends to provide images that can be used to run the most common Pipelines.
When it is not possible, users can extend the base images to customize them for their pipelines.
Common use-cases:

* Installing Jenkins plugins not available in the image.
* Adding tools and packages not available in images provided by CloudBees.
* Performance optimizations for complex Pipelines (e.g. caching images).

## How to extend the Jenkinsfile Runner images?

There are multiple general ways to extend the images:

* Define the service extensions in the `codeship-services.yml` or the Docker compose file within the project.
  This approach is recommended for cases when the customization is applied to a single pipeline.
  See [this page](/pro/builds-and-configuration/services/) for more information about defining CodeShip services.
* Setting up a standalone delivery Pipeline for custom Jenkinsfile Runner image.
  This approach can be used when a similar Jenkinsfile Runner image is used for multiple projects.
* Combining the approaches above: maintaining a custom base image which is then extended on the project level is needed.
  
## Extending Jenkinsfile Runner images in CodeShip Service definitions

CodeShip Pro provides support for custom container step,
and users get freedom of what they include inside the images.
The Jenkins Pipeline support feature is built on the top of this capability,
and hence it also provides a decent level of flexibility.

Main ways to customize the images:

* Using tools embedded into the base images provided by CloudBees.
* Rebuilding a Jenkinsfile Runner image from scratch using advanced Jenkinsfile Runner packaging tools.

### Extending existing images

Existing images for Jenkinsfile Runner can be extended, e.g. by passing a list of plugins to install or by passing a custom configuration file.
You can find examples in [this demo](https://github.com/oleg-nenashev/codeship-custom-jfr-demo).

#### Installing Tools

<!-- TODO: may change with UBI -->

Tools can be installed using package manager steps included into the images.
Unless stated otherwise in Documentation, `apk`is used in CloudBees-provided images.
Some tools also can be installed by using system commands like wget/curl.
Tools can be added within the `codeship-services.yml` Dockerfile:
  
```dockerfile
  
FROM jenkins/jenkinsfile-runner:1.0-beta-17-adoptopenjdk-11-jre-alpine

# Install Docker using the system package manager
RUN apk add --update --no-cache docker

# Install kubectl using system commands 
RUN wget -O /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v1.19.2/bin/linux/amd64/kubectl" && \
  chmod +x /usr/bin/kubectl
....
```

#### Installing plugins

Installing plugins can be done via the [Plugin Installation Manager](https://github.com/jenkinsci/plugin-installation-manager-tool) CLI tool embedded into all CloudBees-provided images.
Plugins can be added within the `codeship-services.yml` Dockerfile:

```dockerfile
  
FROM jenkins/jenkinsfile-runner:1.0-beta-17-adoptopenjdk-11-jre-alpine

...

# Install plugins
RUN java -jar /app/bin/jenkins-plugin-manager.jar \ 
  --war /app/jenkins/jenkins.war \
  --plugins docker-workflow:1.24 workflow-durable-task-step:2.36 pipeline-model-definition:1.7.2 configuration-as-code:1.43 docker-plugin:1.2.0
```

#### Configuring Jenkins

Jenkins configuration can be defined using the [Jenkins Configuration as Code (JCasC)](https://plugins.jenkins.io/configuration-as-code/) plugin.
This plugin can be used to setup Jenkins configuration via YAML, including system configuration, agent and cloud settings, Pipeline libraries, etc.

Many Jenkins Configuration as Code examples can be found [here](https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos).
It is also possible to export configurations from your existing Jenkins instances using the [JCasC export feature](https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/docs/features/configExport.md).
Secrets can be passed from CodeShip to JCasC configuration files through environment variables, see [managing Secrets in JCasC](https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/docs/features/secrets.adoc).

Example Dockerfile:

```dockerfile
FROM jenkins/jenkinsfile-runner:1.0-beta-17-adoptopenjdk-11-jre-alpine
....
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/jenkins.yaml
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml
....
```

Example configuration YAML which sets up a global [Jenkins Pipeline library](https://www.jenkins.io/doc/book/pipeline/shared-libraries/) which will be downloaded from GitHub.

```yaml
unclassified:
  globalLibraries:
    libraries:
    - defaultVersion: "1.0"
      name: "Test Git Lib"
      implicit: true
      retriever:
        legacySCM:
          scm:
            git:
              userRemoteConfigs:
              - url: "https://github.com/jenkins-infra/pipeline-library.git"
              branches:
              - name: "master"
```



### Advanced approaches

* Using Maven-based packaging flows, based on [Jenkinsfile Runner packaging parent POM](https://github.com/jenkinsci/jenkinsfile-runner/tree/master/packaging-parent-pom).
* Using [Custom WAR/Docker Packager](https://github.com/jenkinsci/custom-war-packager) for Jenkins.

## References

* [Extending Jenkinsfile Runner Docker images](https://github.com/jenkinsci/jenkinsfile-runner/blob/master/docs/using/EXTENDING_DOCKER.adoc)
