require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      erb_file = ERB.new(File.read(make_path(template_name)))
      erb_content = erb_file.result(binding)
      
      render_content(erb_content, 'text/html')
    end

    def make_path(template_name)
      "views/#{self.class.name.underscore}/#{template_name.to_s}.html.erb"
    end
  end
end
