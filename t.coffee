###
     _             __  __         
    | |_   __ ___ / _|/ _|___ ___ 
    |  _|_/ _/ _ \  _|  _/ -_) -_)
     \__(_)__\___/_| |_| \___\___|

  t.coffee - CoffeeScript port of t.js (Jason Mooberry <jasonmoo@me.com>),
    a micro-templating framework in ~400 bytes gzipped

  @author  David Rekow <david at davidrekow.com>
  @license MIT
  @version 0.1.0
###

class t

  constructor: (template) ->

    @scrub = (val) =>
      return new Option(val).innerHTML.replace(/["']/g, '&quot;')

    @get_value = (vars, key) =>
      parts = key.split('.')
      while parts.length
        return false if parts[0] not of vars
        vars = vars[parts.shift()]

        return (if typeof vars is 'function' then vars() else vars)

    @t = template
    return @

  render: (fragment, vars) =>
    blockregex = /\{\{(([@!]?)(.+?))\}\}(([\s\S]+?)(\{\{:\1\}\}([\s\S]+?))?)\{\{\/\1\}\}/g
    valregex = /\{\{([=%])(.+?)\}\}/g

    if not vars?
      vars = fragment
      fragment = @t

    return fragment.replace(blockregex, (_, __, meta, key, inner, if_true, has_else, if_false) =>
      val = @get_value(vars, key)
      temp = ''

      if not val
        return (if meta is '!' then @render(inner, vars) else (if has_else then @render(if_false, vars) else ''))

      if not meta
        return @render(`has_else ? if_true : inner, vars`)

      if meta is '@'
        for i, v of val
          if {}.hasOwnProperty.call(val, i)
            vars._key = i
            vars._val = v
            temp += @render(inner, vars)

        delete vars._key
        delete vars._val
        return temp
    ).replace(valregex, (_, meta, key) =>
      val = @get_value(vars, key)
      return (if val? then (if meta is '%' then @scrub(val) else val) else '')
    )

window.t = t
