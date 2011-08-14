require 'spec_helper'

describe 'Assets for Misc' do
  subject { assets }

  it { should serve 'application' } # just to double check we don't mess with the app itself

  it { should serve 'pakunok/innershiv.js' } 
  it { should serve 'pakunok/jquery.form.js' } 

  describe 'jquery.scrollpane' do
    it { should serve 'pakunok/jquery.jscrollpane.js' } 
    it { should serve 'pakunok/jquery.jscrollpane.css' }
    # optional improvements
    it { should serve 'pakunok/jquery.mousewheel.js' } 
    it { should serve 'pakunok/mwheelIntent.js' } 
  end

  it { should serve 'pakunok/jquery.validate.js' } 
  it { should serve 'pakunok/jquery.validate/additional-methods.js' } 

  it { should serve 'pakunok/jquery.viewport.js' } 
end
