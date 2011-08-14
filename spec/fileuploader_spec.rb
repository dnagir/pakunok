require 'spec_helper'

describe 'Assets for Colorpicker' do
  subject { assets }

  it { should serve 'pakunok/colorpicker.js' } 
  it { should serve 'pakunok/colorpicker.css' } 
  it "should not look like it has hardcoded image links" do
    asset_for('pakunok/colorpicker.css').to_s.should_not include '/images/'
  end


  %w{
    colorpicker_background.png
    colorpicker_hex.png
    colorpicker_hsb_b.png
    colorpicker_hsb_h.png
    colorpicker_hsb_s.png
    colorpicker_indic.gif
    colorpicker_overlay.png
    colorpicker_rgb_b.png
    colorpicker_rgb_g.png
    colorpicker_rgb_r.png
    colorpicker_select.gif
    colorpicker_submit.png
  }.each do |image_name|
    it { should serve "pakunok/colorpicker/#{image_name}" }
  end
end
