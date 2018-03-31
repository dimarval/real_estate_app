templates_path = File.expand_path('../../seeds/source_templates/*.xslt', __FILE__)

Dir.glob(templates_path).each do |template_path|
  template_name = File.basename(template_path, '.xslt')
  source        = Source.find_or_initialize_by(code: template_name)

  source.update(name: template_name.capitalize)

  source_template = source.template || SourceTemplate.new
  source_template.update(source: source, content: File.read(template_path))
end
