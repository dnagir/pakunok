require 'spec_helper'

describe 'Assets for jQuery-UI' do
  subject { assets }
  everything = %w{core.js accordion.js autocomplete.js button.js datepicker.js dialog.js
        draggable.js droppable.js effects.js mouse.js position.js progressbar.js
        resizable.js selectable.js slider.js sortable.js tabs.js widget.js}

  it { should serve 'pakunok/jquery-ui' } 
  everything.each do |name|
    it { should serve "pakunok/jquery-ui/#{name}" }
  end
  
  context 'with dependencies for' do
    it 'full suite should include everything' do
      asset_for('pakunok/jquery-ui').should depend_on everything, :within => 'pakunok/jquery-ui/'
    end

    
    asset_dependencies = {
      'effects.js' => %w{blind bounce clip core drop explode
                    fade fold highlight pulsate scale
                    shake slide transfer}
    }

    asset_dependencies.each_pair do |asset, dependencies|
      it "#{asset} should depend on #{dependencies}" do
        dependencies = dependencies.map {|x| "jquery.effects.#{x}.js"}
        asset_for("pakunok/jquery-ui/#{asset}").should depend_on dependencies, :within => "pakunok/jquery-ui/ui/"
      end
    end

    (everything - asset_dependencies.keys).each do |asset|
      it "#{asset} should not have dependencies" do
        asset_for("pakunok/jquery-ui/#{asset}").should depend_on "pakunok/jquery-ui/ui/jquery.ui.#{asset}"
      end
    end
  end


  describe "pre-packaged as" do
    {
      'basic.js'        => %w{core.js widget.js mouse.js position.js},

      'draggable.js'    => %w{core.js mouse.js widget.js draggable.js},
      'droppable.js'    => %w{core.js mouse.js widget.js draggable.js droppable.js},
      'resizable.js'    => %w{core.js mouse.js widget.js resizable.js},
      'selectable.js'   => %w{core.js mouse.js widget.js selectable.js},
      'sortable.js'     => %w{core.js mouse.js widget.js sortable.js},
      'accordion.js'    => %w{core.js widget.js accordion.js},
      'autocomplete.js' => %w{core.js widget.js position.js autocomplete.js},
      # menu is not released yet
      #'menu.js'         => %w{core.js widget.js menu.js},
      'button.js'       => %w{core.js widget.js button.js},
      'dialog.js'       => %w{core.js widget.js button.js draggable.js mouse.js position.js resizable.js dialog.js},
      'slider.js'       => %w{core.js mouse.js widget.js slider.js},
      'tabs.js'         => %w{core.js widget.js tabs.js},
      'datepicker.js'   => %w{core.js datepicker.js},
      'progressbar.js'  => %w{core.js widget.js progressbar.js}
    }.each_pair do |pack_name, dependencies|
      it "#{pack_name} should include #{dependencies}" do
        asset_for("pakunok/jquery-ui/pack/#{pack_name}").should depend_on dependencies, :within => "pakunok/jquery-ui/ui/jquery.ui."
      end
    end

    it 'effects.js should not have dependency on core' do
      asset_for("pakunok/jquery-ui/pack/effects.js").should_not depend_on "pakunok/jquery-ui/ui/jquery.ui.core.js"
    end
  end

end
