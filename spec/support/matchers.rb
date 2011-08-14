
RSpec::Matchers.define :serve do |asset_name|
  match do |sprockets|    
    !!sprockets[asset_name]
  end

  failure_message_for_should do |sprockets|
    "expected #{asset_name} to be served, but it wasn't"
  end

  failure_message_for_should_not do |sprockets|
    "expected #{asset_name} NOT to be served, but it was"
  end

  description do
    "serve #{asset_name}"
  end
end

RSpec::Matchers.define :contain do |content|
  match do |asset|
    asset.to_s.include? content
  end

  failure_message_for_should do |asset|
    "expected #{asset.logical_path} to contain #{content}"
  end

  failure_message_for_should_not do |asset|
    "expected #{asset.logical_path} to NOT contain #{content}"
  end

  description do
    "contain '#{content}'"
  end
end




RSpec::Matchers.define :depend_on do |dependencies, opts = {}|
  match do |asset|
    raise 'No asset available to assert dependencies on' unless asset
    dependencies = [dependencies] unless dependencies.respond_to?(:to_a)
    prefix = opts[:within] || opts[:prefix]
    dependencies = dependencies.map {|d| "#{prefix}#{d}" } if prefix
    @asset_dependencies = asset.dependencies.map(&:logical_path)
    @diff = dependencies - @asset_dependencies
    @diff.empty?
  end

  failure_message_for_should do |asset|
    "expected #{asset.logical_path} to have dependencies on #{dependencies}.\nMISSING=#{@diff}.\nACTUAL=#{@asset_dependencies}"
  end

  failure_message_for_should_not do |asset|
    "expected #{asset.logical_path} NOT to have dependencies on #{dependencies}.\nDIFF=#{@diff}."
  end

  description do
    "depend on #{dependencies}"
  end
end

