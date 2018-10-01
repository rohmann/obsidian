# Obsidian
Obsidian is a [Bedrock](https://github.com/roots/bedrock) based WordPress
development environment with product (plugins/themes) in mind.

The main concept is that you can store your plugin/theme repositories anywhere
you want, and have them symlinked into your WordPress installation. Being based
on Bedrock, you can also leverage composer and packagist to quickly provision
your development plugins.

The other key difference is that we clone WordPress from GitHub rather than installing with composer. This allows testing with any version by quickly switching tags.

# Installation

1. Copy `.env.example` to `.env` and configure your environment variables (just like bedrock).
2. Copy `projects.example.yml` to `projects.yml` and setup paths to your project repositories.
3. Run the provisioner: `./provision.sh`
