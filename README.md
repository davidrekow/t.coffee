# t.coffee
## A tiny coffeescript port of a tiny javascript templating framework

[`t.js`](http://www.github.com/jasonmoo/t.js) is a simple solution to interpolating values in an html string for insertion into the DOM via `innerHTML`.

 [`t.coffee`](http://www.github.com/davidrekow/t.coffee) extends that simplicity into CoffeeScript, adding dynamically scoping render context to enable superslim templates.

### Features
 * Simple interpolation: `{{=value}}`
 * Scrubbed interpolation: `{{%unsafe_value}}`
 * Name-spaced variables: `{{=User.address.city}}`
 * If/else blocks: `{{value}} <<markup>> {{:value}} <<alternate markup>> {{/value}}`
 * If not blocks: `{{!value}} <<markup>> {{/value}}`
 * Simple Object/array iteration: `{{@obj}}{{=_key}}:{{=_val}}{{/object}}`'
 * Scoped to object/array item context: `{{>object}}{{=name}}, {{=age}}, {{=city}} {{/object}}`
 * Space-agnostic parsing: `{{=value}}`, `{{= value }}`, `{{ =value }}`, `{{ = value }}`
 * Multi-line templates (no removal of newlines required to render)
 * Render the same template multiple times with different data
 * Works in all modern browsers
 
### How to use

Compile to JS as you normally would. You can also use the included Cakefile:

    $ cake compile (-s/--source [SOURCEDIR]) (-o/--output [OUTPUTDIR])

Then use just like [`t.js`](http://www.github.com/jasonmoo/t.js):

    var template = new t("<div>Hello {{=name}}</div>");
    document.body.innerHTML = template.render({name: "World!"});
    
For more advanced usage check the `t_test.html`.

This software is released under the MIT license.  