---
title: Migrating Jenkins Pipelines to CodeShip Pro
menus:
  pro/jenkins-support:
    title: Migrating Jenkins pipelines
    weight: 3
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

This section documents common migration steps when moving Jenkins Pipelines from Jenkins instances to CodeShip Pro.

## Setting expectations

While some pipelines can run seamlessly on CodeShip with help of CloudBees-provided base images and integrations,
more complex Pipelines may require 