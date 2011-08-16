require 'spec_helper'

describe 'Assets for FileUploader' do
  subject { assets }

  it { should serve 'pakunok/fileuploader.js' } 
  it { should serve 'pakunok/fileuploader.css' } 
  it "should not look like it has hardcoded image links" do
    asset_for('pakunok/fileuploader.css').to_s.should_not include 'url("loading.gif")'
  end


  %w{
    loading.gif
  }.each do |image_name|
    it { should serve "pakunok/fileuploader/#{image_name}" }
  end
end
