---
title: Setting Up Or Migrating A Project To CodeShip Pro
menus:
  pro/quickstart:
    title: Migrating To Pro
    weight: 2
tags:
  - docker
  - jet
  - introduction
  - getting started
  - project configuration
  - tutorial
  - migrating
  - account
  - projects
categories:
  - Quickstart
  - Docker
  - Guide
  - Configuration
  - Account
redirect_from:
  - /docker/codeship-configuration/
  - /pro/getting-started/codeship-configuration/
  - /pro/getting-started/migrating-basic-to-pro/
---

* include a table of contents
{:toc}

## Setting Up A New Project

Once you have your [project running locally]({{ site.baseurl }}{% link _pro/quickstart/getting-started.md %}) you can configure the repository on CodeShip and have the builds run on each push.

If you already worked with CodeShip the process will be familiar (and if not, it should be very simple nonetheless).

1. Click on the _Select Project_ dropdown in the top bar and select the _Create a new project_ button.

2. Select the repository provider you want to host your repositories with.

3. Select the repository you want to build on CodeShip. You can filter the list via the search form. (If a repository belonging to an organization on GitHub isn't listed, please take a look at [3rd party restrictions]({{ site.baseurl }}{% link _general/about/permissions.md %}).)

So far these are the standard steps to add a new project on CodeShip.

4. You can now choose between CodeShip Basic (hosted) and CodeShip Pro (Docker). Choose the latter.
	![Select CodeShip Pro]({{ site.baseurl }}/images/docker/setup_select_docker.png)

5. You will be presented with a screen offering basic setup instructions, as well as a link to the documentation for CodeShip Pro.
	![Docker Project Help Screen]({{ site.baseurl }}/images/docker/setup_docker_setup.png)

	As we already added all the required information to the [repository](https://github.com/codeship/jet-tutorial), you can simply push a new commit and this will trigger a new build on CodeShip.

6. Once you trigger a (couple) new builds, you'll see the standard CodeShip build listing page.
	![Build Listing]({{ site.baseurl }}/images/docker/build_listing.png)

7. Clicking on a single build takes you to the build details.
	![Build Details]({{ site.baseurl }}/images/docker/build_details.png)

	The page is split in two panes. On the left hand side you will find basic build details, including the commit message, who triggered the build and which branch (or tag) triggered the build.

	You will also see the [services]({% link _pro/builds-and-configuration/services.md %}) defined in your _codeship-services.yml_ file (if you click on the _Services_ header as this section is hidden by default).

	The main portion of the left pane is dedicated to listing the [steps]({% link _pro/builds-and-configuration/steps.md %}) you have defined. Clicking on a single step will open the step log in the right pane. Each step includes the following information:

	* the command you are running
	* the service the step is running on (on the right hand side)
	* the status indicated by an icon

8. The remaining project configuration (e.g. team management or notifications) is identical to a standard CodeShip project and accessible via the _Project Settings_ dropdown at the top.

## Migrating From Basic To Pro

### Create A New Pro Project

To create a new CodeShip Pro project, just select the Pro infrastructure after connecting your source control.

![Selecting CodeShip Pro]({{ site.baseurl }}/images/gettingstarted/setup_select_docker.png)

[You can learn more about creating a new project here.]({{ site.baseurl }}{% link _general/projects/getting-started.md %}).

### Switch A Basic Project To A Pro Project

To switch a project from CodeShip Basic to CodeShip Pro, just click on "Project Settings" in the top right. Then, under the "General" tab, you will see a "Switch project to CodeShip Pro" button.

![Selecting CodeShip Pro]({{ site.baseurl }}/images/general/enable-pro.png)

### Run Pro Builds On Basic Projects

On any CodeShip Basic project, you can commit to the branch `codeship-docker-migration` to trigger a CodeShip Pro build. You will still need the configuration files in your repository which include [codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and [codeship-steps.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}). You can use our command-line tool, [Jet]({{ site.baseurl }}{% link _pro/jet-cli/usage-overview.md %}), to work on the setup for your project. Note that this is the only branch that will run Pro builds on Basic projects, and these builds will show up in your build queue. After you trigger your first CodeShip Pro build, your project will create an AES key in your general project settings which can be used to [encrypt environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}#encrypted-environment-variables). Before starting this migration, we recommend going through our [getting started guide]({{ site.baseurl }}{% link _pro/quickstart/getting-started.md %}).
