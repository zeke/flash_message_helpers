Flash Message Helpers
=====================

This Rails plugin provides helpers for generating and displaying flash messages. 

Installation
------------

```bash
script/plugin install https://github.com/zeke/flash_message_helpers.git
```

Usage (Controllers)
-------------------

The controller helper smartly generates flash messages based on the object you give it, its attributes, and the current controller method. Use it in your create, update, and destroy methods.

```ruby
flash_changes(@sandwich)
```

If `@sandwich` was just created, you'll get a message like "Sandwich *The Submarine* was successfully created."
If is was updated, you get "Sandwich *The Submarine* was successfully updated."
If is was deleted, you get: "Sandwich *The Submarine* was successfully deleted."

This method assumes that your object has one of the following attributes: `name`, `title`, `permalink`, or `id`. If it doesn't, no name will be displayed in the flash message. Or you can pass in a custom name attribute like so:

```ruby
flash_changes(@sandwich, :name => 'Grinder')
```

Usage (Views)
-------------

Put this in `application.html.haml`:

```haml
= render_flash_messages
```

TODO
----

- Add an option to linkify the object in the flash message, accounting for the possibility of nest routes.
- Humanize model name in flash_changes method, so things like BigBadModel end up as 'Big Bad Model'
- Include some default flash message CSS styles