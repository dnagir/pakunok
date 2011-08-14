def assets
  Rails.application.assets
end

def asset_for(name)
  assets[name]
end

def extract_image_urls_from str
  # Could be better of course, but does the job for now
  str.scan(/url\((.+)\)/).map {|g| g[0]}
end 
