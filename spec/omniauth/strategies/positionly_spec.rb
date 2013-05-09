require 'spec_helper'
require 'omniauth-positionly'

describe OmniAuth::Strategies::Positionly do
  def app; lambda{|env| [200, {}, ["Hello."]]} end

  before :each do
    OmniAuth.config.test_mode = true
    @request = double('Request')
    @request.stub(:params) { {} }
    @request.stub(:cookies) { {} }
    @request.stub(:env) { {} }
  end

  after do
    OmniAuth.config.test_mode = false
  end

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Positionly.new(app, *args).tap do |strategy|
      strategy.stub(:request) { @request }
    end
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'has correct auth url' do
      subject.client.site.should eq('https://api.positionly.com')
    end

    it 'has correct auth path' do
      subject.client.options[:authorize_url].should eq('/oauth2/authorize')
    end

    it 'has correct token url' do
      subject.client.options[:token_url].should eq('/oauth2/token')
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      subject.callback_path.should eq('/auth/positionly/callback')
    end
  end

  describe '#authorize_params' do
    describe 'scope' do
      it 'should set default scope to "read"' do
        @options = { :authorize_options => [:scope]}
        subject.authorize_params['scope'].should eq('read')
      end

      it 'should dynamically set the scope in the request' do
        @options = {:scope => 'fooscope'}
        subject.stub(:request) { double('Request', {:params => { 'scope' => 'barscope' }, :env => {}}) }
        subject.authorize_params['scope'].should eq('barscope')
      end
    end
  end

  describe 'raw info' do
    it 'should include raw_info in extras hash by default' do
      subject.stub(:raw_info) { { :foo => 'bar' } }
      subject.extra[:raw_info].should eq({ :foo => 'bar' })
    end

    it 'should not include raw_info in extras hash when skip_info is specified' do
      @options = { :skip_info => true }
      subject.extra.should_not have_key(:raw_info)
    end
  end

end
