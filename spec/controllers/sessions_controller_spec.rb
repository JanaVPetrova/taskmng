RSpec.describe SessionsController do
  describe '#new' do
    subject { get :new }

    it { is_expected.to be_success }
  end

  describe '#create' do
    before { post :create, sign_in_form: params }

    context 'when params are invalid' do
      let(:params) { { email: generate(:email), password: generate(:string) } }

      it { expect(response).to be_success }
      it { expect(current_user).to be nil }
    end

    context 'when params are valid' do
      let(:password) { generate :string }
      let(:user) { create :user, password: password }
      let(:params) { { email: user.email, password: password } }

      it { expect(response).to be_redirect }
      it { expect(current_user).to eq user }
    end
  end

  describe '#destroy' do
    before do
      sign_in create(:user)
      delete :destroy
    end

    it { expect(response).to be_redirect }
    it { expect(current_user).to be nil }
  end
end
