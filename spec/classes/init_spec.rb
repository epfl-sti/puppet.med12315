require 'spec_helper'
describe 'med12315' do

  context 'with defaults for all parameters' do
    it { should contain_class('med12315') }
  end
end
