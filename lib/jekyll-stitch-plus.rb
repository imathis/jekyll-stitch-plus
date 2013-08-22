require "stitch-plus"
require "fileutils"

module Jekyll
  class StitchPlus < Generator
    def generate(site)
      config = site.config
      filename = ''

      stitch = ::StitchPlus.new(config['stitch'])
      options = stitch.options
      dir = File.dirname(options[:output])

      # If Guard Stitch Plus is running, let it handle the writes
      if ENV['GUARD_STITCH_PLUS']
        # Guard may have a different hash and therefore a different output file
        # Reading the written filename from an ENV allows us to avoid unnecessary writes
        #
        filename = File.basename ENV['GUARD_STITCH_PLUS_OUTPUT']
      else

        begin
          require 'uglifier'
          @uglifier = Uglifier.new config['stitch']['uglify_options'] || {}
          if (ENV['JEKYLL_ENV'] || config['env']).downcase == 'production'
            config['stitch']['uglify'] ||= true
          end
        rescue LoadError
        end

        path = File.join site.source, options[:output]
        stitch.set_options({output: path, uglify: config['stitch']['uglify']})

        puts '' # Because Jekyll doesn't give a newline for other output
        stitch.write

        filename = File.basename stitch.last_write

        # Ensure the compiled file is written to the destination directory
        site.static_files << StaticFile.new(site, site.source, dir, filename)

      end

      # Don't copy static source files or deleted files to the destination directory
      cleanup site, stitch

      # Store the javascript tag for the liquid tag to retrieve
      url = File.join (config['root'] || '/'), dir, filename
      site.config['stitch']['js_tag'] = "<script src='#{url}'></script>"
    end

    # Remove files from Jekyll's static_files array
    def cleanup(site, stitch)

      files = stitch.all_files.map{ |f| File.absolute_path(f)}
      files.concat stitch.deleted

      if files.size > 0
        site.static_files.clone.each do |sf|
          if sf.kind_of?(Jekyll::StaticFile) and files.include? sf.path
            site.static_files.delete(sf)
          end
        end
      end
    end


  end
  class StitchPlusTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      context.registers[:site].config['stitch']['js_tag']
    end
  end
end

Liquid::Template.register_tag('stitch_js_tag', Jekyll::StitchPlusTag)
