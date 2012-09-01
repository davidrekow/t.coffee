###
     _             __  __
    | |_   __ ___ / _|/ _|___ ___
    |  _|_/ _/ _ \  _|  _/ -_) -_)
     \__(_)__\___/_| |_| \___\___|

  t.coffee - CoffeeScript port of t.js (Jason Mooberry <jasonmoo@me.com>),
    a micro-templating framework in ~400 bytes gzipped

  @author  David Rekow <david at davidrekow.com>
  @license MIT
  @version 0.1.2
###

class t

  blockregex = /\{\{\s*?(([@!>]?)(.+?))\s*?\}\}(([\s\S]+?)(\{\{\s*?:\1\s*?\}\}([\s\S]+?))?)\{\{\s*?\/(?:\1|\s*?\3\s*?)\s*?\}\}/g
  valregex = /\{\{\s*?([<&=%\+])\s*?(.+?)\s*?\}\}/g

  constructor: (template) ->

    @t = template
    @render = () => return t::render.apply(@, arguments)
    return @

  @:: =
    scrub: (val) ->
        return new Option(val).innerHTML.replace(/["']/g, '&quot;')

    get_value: (vars, key) ->
        parts = key.split('.')
        while parts.length
          return false if parts[0] not of vars
          vars = vars[parts.shift()]

        return (if typeof vars is 'function' then vars() else vars)

    render: (fragment, vars) ->
      if not vars?
        vars = fragment
        fragment = @t

      vars.temp = if not vars.temp then [] else if vars.temp.length > 10 then vars.temp.slice(@temp.length-10) else vars.temp

      return fragment.replace(blockregex, (_, __, meta, key, inner, if_true, has_else, if_false) =>
        val = @get_value(vars, key)
        temp = ''

        if not val
          return (if meta is '!' then @render(inner, vars) else (if has_else then @render(if_false, vars) else ''))

        if not meta
          return @render(`has_else ? if_true : inner, vars`)

        if meta is '@'
          for k, v of val
            if val.hasOwnProperty(k)
              temp += @render(inner, {_key: k, _val: v, temp: vars.temp})

        if meta is '>'
          if Array.isArray(val) or val.constructor.name is 'ListField'
            temp += @render(inner, item) for item in val
          else temp += @render(inner, val)

        return temp
      ).replace(valregex, (_, meta, key) =>
        val = if meta is '&' then vars.temp[parseInt(key)-1] else if meta is '+' then window[key].render(vars) else @get_value(vars, key)
        if meta is '<' then vars.temp.push(val)
        return (if val? then (if meta is '%' then @scrub(val) else val) else '')
      )

window.t = t
