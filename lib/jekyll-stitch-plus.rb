require "stitch-plus"
require "fileutils"

module Jekyll
  class StitchPlus < Generator
    def generate(site)
      config = site.config

      begin
        require 'uglifier'
        @uglifier = Uglifier.new(config['stitch']['uglify_options'])
        if (ENV['JEKYLL_ENV'] || config['env']).downcase == 'production'
          config['stitch']['uglify'] ||= true
        end
      rescue LoadError
      end

      stitch = ::StitchPlus.new(config['stitch'])
      options = stitch.options

      # Prepend source directory to file output config
      path = File.join config['source'], options[:output]
      stitch.set_options({output: path})

      puts '' # Because Jekyll doesn't give a newline for other output
      stitch.write

      dir = File.dirname(options[:output])
      filename = File.basename(stitch.last_write)

      # Ensure the compiled file is written to the destination directory
      site.static_files << StaticFile.new(site, site.source, dir, filename)

      # Store the javascript tag for the liquid tag to retrieve
      url = File.join (config['root'] || '/'), dir, filename
      site.config['stitch']['js_tag'] = "<script src='#{url}'></script>"

      # Don't copy static source files or deleted files to the destination directory
      remove = stitch.all_files.map{ |f| File.join(site.source, f)}
      remove.concat stitch.deleted
      cleanup site, remove

    end

    # Remove files from Jekyll's static_files array
    def cleanup(site, files)
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
