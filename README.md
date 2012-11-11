# t.coffee
## A tiny coffeescript port of a tiny javascript templating framework

[`t.js`](http://www.github.com/jasonmoo/t.js) is a simple solution to interpolating values in an html string for insertion into the DOM via `innerHTML`.

 [`t.coffee`](http://www.github.com/davidrekow/t.coffee) ports that simplicity to coffeescript, adding scoped iteration for concise, readable templates.

### Features
`t.js`

 * Simple interpolation: `{{=value}}`
 * Scrubbed interpolation: `{{%unsafe_value}}`
 * Name-spaced variables: `{{=User.address.city}}`
 * If/else blocks: `{{value}} <<markup>> {{:value}} <<alternate markup>> {{/value}}`
 * If not blocks: `{{!value}} <<markup>> {{/value}}`
 * Simple object/array iteration: `{{@obj}}{{=_key}}:{{=_val}}{{/object}}`'
 * Multi-line templates (no removal of newlines required to render)
 * Render the same template multiple times with different data
 * Works in all modern browsers

`t.coffee`

 * Scoped object/array iteration: `{{>obj}}{{=name}}, {{=age}}, {{=city}} {{/obj}}`
 * Space-agnostic parsing `{{=var}}` or `{{= var }}`

### How to use

Compile to JS as you normally would. You can also use the included Cakefile:

    $ cake compile (-s/--source [SOURCEDIR]) (-o/--output [OUTPUTDIR])

Then use just like [`t.js`](http://www.github.com/jasonmoo/t.js):

    var template = new t("<div>Hello {{=name}}</div>");
    document.body.innerHTML = template.render({name: "World!"});

For more advanced usage check the `t_test.html`.

This software is released under the MIT license.