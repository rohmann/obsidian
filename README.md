# Obsidian
Obsidian is a [Bedrock](https://github.com/roots/bedrock) based WordPress
development environment with product (plugins/themes) development in mind.
**Having used Bedrock before will help you understand the concepts and workflow
presented by this project**

The main concept is that you can store your plugin/theme repositories anywhere
you want, and have them symlinked into your WordPress installation. Being based
on Bedrock, you can also leverage composer and packagist to quickly provision
your development plugins.

## Quick Setup

1. Clone/fork obsidian anywhere you like.
2. Have a database ready, and configure your web server to serve the `/web` folder.
3. Copy `.env.example` to `.env` and add your database credentials.
4. Update `projects.yml` with paths to your project repositories.
5. Run the provisioner: `./provision.sh` This installs WordPress and links in your projects.
6. Run `composer install` to install development plugins.

## Concepts

#### Separate your repos from your WordPress installation
When working on multiple projects, it can be difficult to keep your files organized.
Obsidian is designed so you can manage version controlled projects out of their
own directories, and have those plugins and themes symlinked into the appropriate
locations within the WordPress folder structure.

#### Composer support
Modify `composer.json` with the plugins you wish to have on hand, and begin
customizing Obsidian to your specific needs.

#### Use WordPress trunk.
Obsidian will clone WordPress truck into your `web/wp` folder. This is particularly
handy because you can quickly checkout different tags to test your product with
various WordPress releases. By keeping this repo up to date, you also test
with the latest developments before an official WordPress release.

#### Differences from Bedrock
- The `WP_HOME` and `WP_SITEURL` environment variables don't need to be specified and are set dynamically. You'll need to set them in `.env` if you want to enforce a specific URL, or use https.
- Composer doesn't install WordPress. Instead, we're cloning the official GitHub mirror of WordPress trunk.