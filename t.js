// Generated by CoffeeScript 1.3.3

/*
     _             __  __         
    | |_   __ ___ / _|/ _|___ ___ 
    |  _|_/ _/ _ \  _|  _/ -_) -_)
     \__(_)__\___/_| |_| \___\___|

  t.coffee - CoffeeScript port of t.js (Jason Mooberry <jasonmoo@me.com>),
    a micro-templating framework in ~400 bytes gzipped

  @author  David Rekow <david at davidrekow.com>
  @license MIT
  @version 0.1.1
*/


(function() {
  var t,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  t = (function() {
    var blockregex, valregex;

    blockregex = /\{\{\s*?(([@!>]?)(.+?))\s*?\}\}(([\s\S]+?)(\{\{\s*?:\1\s*?\}\}([\s\S]+?))?)\{\{\s*?\/(?:\1|\s*?\3\s*?)\s*?\}\}/g;

    valregex = /\{\{\s*?([=%])\s*?(.+?)\s*?\}\}/g;

    function t(template) {
      this.render = __bind(this.render, this);

      var _this = this;
      this.scrub = function(val) {
        return new Option(val).innerHTML.replace(/["']/g, '&quot;');
      };
      this.get_value = function(vars, key) {
        var parts;
        parts = key.split('.');
        while (parts.length) {
          if (!(parts[0] in vars)) {
            return false;
          }
          vars = vars[parts.shift()];
        }
        return (typeof vars === 'function' ? vars() : vars);
      };
      this.t = template;
      return this;
    }

    t.prototype.render = function(fragment, vars) {
      var _this = this;
      if (!(vars != null)) {
        vars = fragment;
        fragment = this.t;
      }
      return fragment.replace(blockregex, function(_, __, meta, key, inner, if_true, has_else, if_false) {
        var item, k, temp, v, val, _i, _len;
        val = _this.get_value(vars, key);
        temp = '';
        if (!val) {
          return (meta === '!' ? _this.render(inner, vars) : (has_else ? _this.render(if_false, vars) : ''));
        }
        if (!meta) {
          return _this.render(has_else ? if_true : inner, vars);
        }
        if (meta === '@') {
          if (Array.isArray(val)) {
            for (_i = 0, _len = val.length; _i < _len; _i++) {
              item = val[_i];
              temp += _this.render(inner, item);
            }
          } else {
            for (k in val) {
              v = val[k];
              if (val.hasOwnProperty(k)) {
                temp += _this.render(inner, {
                  _key: k,
                  _val: v
                });
              }
            }
          }
        }
        if (meta === '>') {
          temp += _this.render(inner, val);
        }
        return temp;
      }).replace(valregex, function(_, meta, key) {
        var val;
        val = _this.get_value(vars, key);
        return (val != null ? (meta === '%' ? _this.scrub(val) : val) : '');
      });
    };

    return t;

  })();

  window.t = t;

}).call(this);
