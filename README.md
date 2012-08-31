# t.coffee
## A tiny coffeescript port of a tiny javascript templating framework

[`t.js`](http://www.github.com/jasonmoo/t.js) is a simple solution to interpolating values in an html string for insertion into the DOM via `innerHTML`.

 [`t.coffee`](http://www.github.com/davidrekow/t.coffee) extends that simplicity into CoffeeScript, adding dynamically scoped render context & shorthand variable replaces to enable superslim templates.

### Features
`t.js`

 * Simple interpolation: `{{=value}}`
 * Scrubbed interpolation: `{{%unsafe_value}}`
 * Name-spaced variables: `{{=User.address.city}}`
 * If/else blocks: `{{value}} <<markup>> {{:value}} <<alternate markup>> {{/value}}`
 * If not blocks: `{{!value}} <<markup>> {{/value}}`
 * Simple Object/array iteration: `{{@obj}}{{=_key}}:{{=_val}}{{/object}}`'
 * Multi-line templates (no removal of newlines required to render)
 * Render the same template multiple times with different data
 * Works in all modern browsers

`t.coffee`

 * Iteration scoped to object/array item context: `{{>object}}{{=name}}, {{=age}}, {{=city}} {{/object}}`
 * Space-agnostic parsing: `{{=value}}`, `{{= value }}`, `{{ =value }}`, `{{ = value }}`
 * Simple shorthand vars for repeated properties within a single block, assigned via order saved: `Hi, my name is {{<fullname}}. Well, {{&1}} is what my parents call me, my friends call me {{<nickname}}. I got the nickname {{&2}} long ago.`
 * Template includes, rendered with current block context: `{{+MyTemplateClassName}}`. Template classes should extend `t()` and be attached to the window:

		class CustomTemplate extends t
		  constructor: () ->
		    super(['<span class="item-edit" data-key="{{=key}}">',
		      '<div class="right">',
		        '<span class="ctrl promote">promote</span>',
		        '<span class="ctrl demote">demote</span>',
		        '<span class="ctrl remove">remove</span>',
		      '</div>',
		      '{{=name}}',
		    '</span>'
		    ].join(''))
		    return @
		window.CustomTemplate = CustomTemplate

 Use like this:

		mytemplate = new t('Hi, {{=username}}!, This is my template: {{+CustomTemplate}}.')
		myobj = {
		  username: 'davidrekow'
		  key: 'item key'
		  name: 'item name'
		}
		html_with_include = mytemplate.render(myobj)

### How to use

Compile to JS as you normally would. You can also use the included Cakefile:

    $ cake compile (-s/--source [SOURCEDIR]) (-o/--output [OUTPUTDIR])

Then use just like [`t.js`](http://www.github.com/jasonmoo/t.js):

    var template = new t("<div>Hello {{=name}}</div>");
    document.body.innerHTML = template.render({name: "World!"});

For more advanced usage check the `t_test.html`.

This software is released under the MIT license.