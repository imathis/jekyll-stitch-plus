# Jekyll Stitch Plus

Easily package javascripts into a single file, with support for fingerprinting, uglification and CommonJS wrapping for easy modularization. This plugin is powered by
[Stitch Plus](https://github.com/imathis/stitch-plus) which is a fancy interface on top of [Stitch-rb](https://github.com/maccman/stitch-rb).

### Install the Gem
Add this line to your application's Gemfile:

    gem 'jekyll-stitch-plus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-stitch-plus

### Install the plugin

Add a ruby file (perhaps named `jekyll-stitch-plus.rb`) to your Jekyll plugins directory add add `require 'jekyll-stitch-plus'` to the top.

Next add `{% stitch_js_tag %}` to a template to render `<script src='/javascripts/all.js'></script>`

## Configuration

| Config           | Description                                                                | Default     |
|:-----------------|:---------------------------------------------------------------------------|:------------|
| `dependencies`   | Array of files/directories to be added first as global javascripts         | nil         |
| `paths`          | Array of directories where javascripts will be wrapped as CommonJS modules | nil         |
| `output`         | A path to write the compiled javascript                                    | 'all.js'    |
| `fingerprint`    | Add a fingerprint to the file name for super cache busting power           | false       |
| `cleanup`        | Automatically remove previously compiled files                             | true        |
| `uglify`         | Smash javascript using the Uglifier gem                                    | false       |
| `uglify_options` | Options for the Uglifier gem. See [the docs](https://github.com/lautis/uglifier#usage) for details. | {}       |

To configure this plugin add Jekyll's YAML configuration file. Here's an example.

```yaml
# Set Jekyll's env to enable/disable Uglifier
env: 'production'

stitch:
  dependencies: 
    - 'js/lib/jquery.js'
    - 'js/lib/underscore.js'
    - 'js/lib'        # globs the js/lib dir
  paths: 'js/modules' # globs the js/modules dir
  output: 'js/site.js'
  fingerprint: true
```

To uglify javascript output you must first install [the uglifier gem](https://github.com/lautis/uglifier) then set your Jekyll environment to production. There are two ways to do this;
either set `env: production` in your Jekyll config, or set your shell JEKYLL_ENV to 'production' (case does not matter).

Setting `uglify: true` (or false) in your Jekyll stitch config will always override any ENV setting. 

If you're confused about paths and dependencies [read this](https://github.com/imathis/stitch-plus#regarding-dependencies).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Brandon Mathis

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

