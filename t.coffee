###
     _             __  __
    | |_   __ ___ / _|/ _|___ ___
    |  _|_/ _/ _ \  _|  _/ -_) -_)
     \__(_)__\___/_| |_| \___\___|

  t.coffee - CoffeeScript port of t.js,
    a micro-templating framework in ~400 bytes gzipped

  @author  Jason Mooberry <jasonmoo@me.com> (ported by David Rekow <david at davidrekow.com>)
  @license MIT
  @version 0.1.3
###

blockregex = /\{\{\s*?(([@!>]?)(.+?))\s*?\}\}(([\s\S]+?)(\{\{\s*?:\1\s*?\}\}([\s\S]+?))?)\{\{\s*?\/(?:\1|\s*?\3\s*?)\s*?\}\}/g
valregex = /\{\{\s*?([=%])\s*?(.+?)\s*?\}\}/g

t = (template) ->
  @t = template
  return

scrub = (val) ->
  return new Option(val).innerHTML.replace(/["']/g, '&quot;')

get_value = (vars, key) ->
  parts = key.split('.')

  while parts.length
    return false if parts[0] not of vars
    vars = vars[parts.shift()]

  return vars

render = (fragment, vars) ->
  if not vars?
    vars = fragment
    fragment = @t

  return fragment.replace(blockregex, (_, __, meta, key, inner, if_true, has_else, if_false) ->
    val = get_value(vars, key)
    temp = ''

    if not val
      return (if meta is '!' then render(inner, vars) else (if has_else then render(if_false, vars) else ''))

    if not meta
      return (if has_else then render(if_true, vars) else render(inner, vars))

    if meta is '@'
      for k, v of val
        if val.hasOwnProperty(k)
          temp += render(inner, {_key: k, _val: v})

    if meta is '>'
      if Array.isArray(val)
        temp += render(inner, item) for item in val
      else temp += render(inner, val)

    return temp
  ).replace(valregex, (_, meta, key) ->
    val = get_value(vars, key)
    return (if val? then (if meta is '%' then scrub(val) else val) else '')
  )

t::render = (vars) ->
  return render(@t, vars)

window.t = t
