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

### Using existing images



### Advanced approaches

* Using Maven-based packaging flows, based on [Jenkinsfile Runner packaging parent POM](https://github.com/jenkinsci/jenkinsfile-runner/tree/master/packaging-parent-pom).
* Using [Custom WAR/Docker Packager](https://github.com/jenkinsci/custom-war-packager) for Jenkins.

## References

* [Extending Jenkinsfile Runner Docker images](https://github.com/jenkinsci/jenkinsfile-runner/blob/master/docs/using/EXTENDING_DOCKER.adoc)
