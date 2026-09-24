# Redmine Startpage

> **TODO — compatibility work pending:** the `main` branch is intended to host a future version compatible with current Redmine releases. That work has not been done yet. The present code is legacy software and should not be installed on a current Redmine instance without an explicit compatibility and security review.

Redmine plugin that lets an administrator replace the normal Redmine home page with a configurable internal destination.

## Repository status

- `archived` preserves the documented legacy implementation.
- `main` is the starting point for a future adaptation to current Redmine releases.
- The plugin declares version `0.1.0`.
- No current Redmine version has been validated yet.

## Features

The plugin adds a settings panel where an administrator can enable a custom start page and describe the target with Redmine routing parameters:

- controller;
- action;
- object or page identifier;
- one optional parameter name;
- one optional parameter value.

When enabled, a callback on `WelcomeController#index` redirects requests for the Redmine home page to that target. This can be used, for example, to open a particular project wiki page instead of the standard welcome page.

The setting is global to the Redmine instance. It is not selected independently by project or by user.

## Installation in the legacy environment

The plugin directory must be named exactly `redmine_startpage`, because Redmine uses that path when locating the plugin settings partial.

After placing the directory under `plugins/`, restart Redmine and configure the plugin from the administration interface.

## Legacy configuration example

To use the main wiki page of a project as the start page in the Redmine routing model for which this plugin was written:

- Controller: `wiki`
- Action: `show`
- ID: `wiki`
- Extra argument name: `project_id`
- Extra argument value: the project identifier

The exact controller and route contract must be reviewed before this example is reused on a current Redmine release.

## Limitations of the legacy code

- It patches `WelcomeController` directly with the inclusion pattern used by older Redmine versions.
- It accepts raw controller, action and parameter names from global settings.
- It does not validate that the configured route exists or is safe before redirecting.
- A bad configuration can make the instance home page unusable or create a redirect loop.
- It supports only one additional route parameter.
- It has no meaningful automated test suite in this repository.
- Compatibility with current Rails and Redmine autoloading and patching conventions has not been established.

## Future adaptation

A future implementation should retain the simple administrative purpose while validating destinations, preventing redirect loops, respecting current Redmine routing and plugin-loading conventions, and adding regression tests. The legacy code has deliberately not been ported yet.

## License

This plugin is distributed under the GNU General Public License version 2. See the existing project history and license notices for details.
