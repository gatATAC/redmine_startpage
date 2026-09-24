# Redmine Startpage

Redmine plugin that lets an administrator replace the standard Redmine home page with another internal Redmine page.

## Status

Version **0.2.0** targets **Redmine 7.0.1**. The plugin is intentionally small: it changes only the response of the global welcome page and does not alter projects or user preferences.

The historical implementation remains available in the `archived` branch.

## Features

From **Administration → Plugins → Redmine Startpage → Configure**, an administrator can:

- enable or disable the custom start page;
- choose a Redmine controller and action;
- provide an optional object or page identifier;
- provide one optional parameter name and value.

A typical configuration that opens a project wiki page is:

- Controller: `wiki`
- Action: `show`
- ID: `wiki`
- Extra argument name: `project_id`
- Extra argument value: the project identifier

The destination is global for the complete Redmine instance.

## Requirements

- Redmine 7.0.1 or later in the 7.x line.
- Ruby and Rails versions supplied by that Redmine release.

## Installation

From the Redmine root:

```bash
git clone https://github.com/gatATAC/redmine_startpage.git plugins/redmine_startpage
RAILS_ENV=production bundle exec rake redmine:plugins:migrate NAME=redmine_startpage
```

Restart Redmine and configure the plugin from the administration interface. The directory must be named `redmine_startpage`.

The plugin has no database migrations today; the migration command is included so installation remains consistent with normal Redmine plugin operations.

## Upgrade from the legacy plugin

1. Back up the Redmine database and files.
2. Replace the plugin checkout with version 0.2.0 or a reviewed commit from `main`.
3. Restart Redmine.
4. Review the configured controller, action and arguments before enabling the redirect.
5. Test the home page both as an authenticated and anonymous user.

Legacy settings keep the same keys and are therefore read by the updated version.

## Safety considerations

The configured destination must be an internal Redmine route. An invalid route is logged and leaves the ordinary welcome page visible. Administrators should avoid configuring the welcome action itself as the destination, because that would create a redirect loop.

## Development

The controller extension uses the current Rails preparation callback and `Module#prepend`, so development reloads do not stack duplicate callbacks.

Basic validation against Redmine should cover:

- plugin registration;
- inactive configuration;
- redirect without an extra parameter;
- redirect with an extra parameter;
- invalid route handling;
- repeated reload preparation.

## Repository

The canonical repository is [github.com/gatATAC/redmine_startpage](https://github.com/gatATAC/redmine_startpage).

## Licence

Copyright © Txinto Vaz and contributors.

This program is free software under the **GNU General Public License version 3**. See [LICENSE](LICENSE).
