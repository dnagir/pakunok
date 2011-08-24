require 'spec_helper'
require 'pakunok'

describe Pakunok::Pakunok do

  subject             { Pakunok::Pakunok.new }
  let(:request)       { mock(:request) }
  let(:context)       { Pakunok::HttpContext.new(request)  }

  it 'should have default renderer for javascript' do
    subject.render_types.should == {:javascript => :script, :stylesheet => :link}
  end

  describe 'adding asset to configuration' do
    it 'should include dependent assets' do
      subject.asset('a.js').needs 'b', 'c'
      subject.assets.length.should == 3
    end

    it 'with CDN' do
      subject.asset('a.js').replace_with :cdn => 'google.com/a.js'
      subject.asset('a.js').cdn.should == 'google.com/a.js'
    end

    it 'as async' do
      asset = subject.asset('analytics.js').as_async
      asset.async.should be_true
    end

    context 'dependency' do
      it 'with dependency' do
        subject.asset('b.js').needs('a.js').depends_on.should include 'a.js'
      end

      it 'with more complex dependency' do
        subject.add_dependencies '2'=>'1', '3'=>'2', '5'=>'4', '6' => '2', '6' => '3'

        subject.asset('2').depends_on.should == ['1']
        subject.asset('3').depends_on.should == ['1', '2']
        subject.asset('5').depends_on.should == ['4']
        subject.asset('6').depends_on.should == ['1', '2', '3']
      end

      it 'with circular dependency' do
        subject.asset('a').needs('c')
        subject.asset('b').needs('a')
        subject.asset('c').needs('a')

        subject.asset('a').depends_on.should == ['c']
        subject.asset('b').depends_on.should == ['c', 'a']
        subject.asset('c').depends_on.should == ['a']
      end
    end

  end

  describe 'URL generation' do

    before do
      request.stub(:protocol).and_return 'http://'
      subject.asset('b.js').needs('a.js')
    end

    it 'uses asset path with no CDN' do
      context.should_receive(:asset_path).with('a.js')
      subject.asset('a.js').url(context)
    end

    it 'with CDN and no protocol' do
      request.stub(:protocol).and_return 'https://'
      subject.asset('a.js').replace_with :cdn => 'google.com/a.js'
      subject.asset('a.js').url(context).should == 'https://google.com/a.js'
    end

    it 'with CDN and protocol' do
      subject.asset('a.js').replace_with :cdn => 'https://google.com/a.js'
      subject.asset('a.js').url(context).should == 'https://google.com/a.js'
    end

  end

end
