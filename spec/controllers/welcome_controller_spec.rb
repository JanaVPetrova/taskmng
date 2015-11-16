RSpec.describe WelcomeController do
  describe '#show' do
    subject { get :show }

    it { is_expected.to be_success }
  end
end
