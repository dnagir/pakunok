require 'spec_helper'

describe 'Assets for jQuery' do
  subject { assets }

  it { should serve 'pakunok/jquery' } 
  it { should serve 'pakunok/jquery/jquery-1.6.2' } 
  it { should serve 'pakunok/jquery/jquery-1.5.2' } 
  specify { asset_for('pakunok/jquery').should contain 'jQuery JavaScript Library v1.6.2' }  
end
