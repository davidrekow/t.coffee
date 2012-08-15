# t.coffee
## A tiny coffeescript port of a tiny javascript templating framework

`t.js` is a simple solution to interpolating values in an html string for insertion into the DOM via `innerHTML`.


### Features
 * Simple interpolation: `{{=value}}`
 * Scrubbed interpolation: `{{%unsafe_value}}`
 * Name-spaced variables: `{{=User.address.city}}`
 * If/else blocks: `{{value}} <<markup>> {{:value}} <<alternate markup>> {{/value}}`
 * If not blocks: `{{!value}} <<markup>> {{/value}}`
 * Object/Array iteration: `{{@object_value}} {{=_key}}:{{=_val}} {{/object_value}}`
 * Space-agnostic parsing: `{{=value}} == {{= value }} == {{ =value }} == {{ = value }}`
 * Multi-line templates (no removal of newlines required to render)
 * Render the same template multiple times with different data
 * Works in all modern browsers
 
### How to use

Compile using included Cakefile:

    $ cake compile (-s/--source [SOURCEDIR]) (-o/--output [OUTPUTDIR])

Then use just like t.js:

	var template = new t("<div>Hello {{=name}}</div>");
	document.body.innerHtml = template.render({name: "World!"});
	
For more advanced usage check the `t_test.html`.

This software is released under the MIT license.  