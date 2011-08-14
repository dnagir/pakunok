require 'spec_helper'



describe 'Assets for jQuery-UI' do
  subject { assets }
  everything = %w{core accordion autocomplete button datepicker dialog
        draggable droppable effects mouse position progressbar 
        resizable selectable slider sortable tabs widget}

  it { should serve 'pakunok/jquery-ui' } 
  everything.each do |name|
    it { should serve "pakunok/jquery-ui/#{name}" }
  end
  
  context 'with dependencies' do
    it 'should include everything' do
      #raise asset_for('pakunok/jquery-ui').dependencies.map(&:logical_path).to_s
      asset_for('pakunok/jquery-ui').should depend_on everything, :within => 'pakunok/jquery-ui/'
    end

    #{
    #  'accordion' => %w{jquery.ui.core jquery.ui.widget}
    #}.each_pair do |asset, dependencies|
    #  it { asset_for("pakunok/jquery-ui/accordion").should depend_on dependencies, :within => "pakunok/jquery-ui/ui/" }
    #end
  end


end
