---
title: Jenkins Support (Preview)
menus:
  pro/jenkins-support:
    title: Overview
    weight: 1
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

Starting from October 2020, CodeShip Pro offers **experimental** support for Jenkins Pipelines.
This feature allows running Jenkins CI/CD workloads in CodeShip SaaS,
with a good level of compatibility with Jenkins instances.

## What's inside?

CodeShip Pro does not include a full Jenkins server.
Instead of that, it uses a CloudBees-provided serverless Jenkins Pipeline execution engine,
based on the open-source [Jenkinsfile Runner project](https://github.com/jenkinsci/jenkinsfile-runner).
The implementation by CloudBees provides seamless Jenkins Pipeline support for many use-cases,
and also high performance and low cost overheads compared to running a full Jenkins instance.

The Pipeline execution engine is packaged in a Docker container,
and hence can be invoked as a common CodeShip Pro step.

Minimum example:

```
ci.jenkins.io-runner:
  image: jenkins/ci.jenkins.io-runner:0.4.0
  volumes: 
    - .:/workspace
```

## What does a technical preview mean?

The feature under technical preview...

* Has not undergone full end-to-end testing within CodeShip delivery Pipelines
* Has support provided directly by the engineering team working on the feature.
  The support is provided without service-level agreements (SLA) and therefore does not include CloudBees' commitment on functionality or performance.
* May have limited documentation.
* May not be feature complete during the Preview period.
* May graduate from preview state to fully supported or be removed from the product.
* May introduce incompatible, backward-breaking changes that could revoke the ability to upgrade.

## Supported use-cases

* Support for Declarative and Scripted Pipeline
* 
* [Building Custom Jenkinsfile Runner images](./custom-images)
* [Connecting external outbound agents](./external-agents)

## Unsupported use-cases

Jenkins support on CodeShip Pro currently does not provide support for the following use-cases:

* 

## Providing feedback

We would appreciate your feedback!
Please contact us using the standard CodeShip support and feature request channels.

## More Resources

* [Jenkinsfile Runner project](https://github.com/jenkinsci/jenkinsfile-runner)
