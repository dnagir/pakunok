require 'spec_helper'
require 'pakunok'

describe Pakunok::Pakunok do
  subject             { Pakunok::Pakunok.new }
  let(:request)       { mock(:request) }
  let(:context)       { Pakunok::HttpContext.new(request)  }
  before do
    context.stub(:asset_path) { |path| path }
  end

  it 'should raise if renderer doesnt exist' do
    lambda { subject.renderer_for(:non_existing) }.should raise_error
  end

  it 'should return existing renderer' do
    subject.renderer_for(:script).should_not be_nil
  end

  describe 'renderers' do
    before do
      subject.asset('a').as_async
      subject.asset('b').needs 'a'
      subject.asset('c').needs 'b'
    end

    context 'script' do
      before do
        emu = double(:fake_sprockets_asset)
        emu.stub(:to_s).and_return "I am inline!"
        context.stub_chain(:asset_paths, :asset_environment, :[]) { |path| emu }
      end

      let(:renderer)  { ::Pakunok::AssetRenderers::ScriptRenderer.new(subject) }

      def result(path='c')
        renderer.render(context, path)
      end

      it 'should apply async' do
        result.should include "async='async'"
      end

      it 'should render script tags' do
        result.should include "<script type='text/javascript' src='a'"
        result.should include "<script type='text/javascript' src='b'>"
        result.should include "<script type='text/javascript' src='c'>"
        result.should include "</script>"
      end

      it 'should embed small script' do

        subject.asset('emu').needs('a').embed()
        result('emu').should include "I am inline!"
        result('emu').should include "<script"
      end
    end

    describe 'labjs' do
      it 'should apply async'
      it 'should render script tag'
      it 'should embed small script'
    end

  end

end

