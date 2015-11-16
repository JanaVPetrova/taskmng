RSpec.describe Account::TasksController do
  let(:task) { create :task, :with_user }
  before { sign_in task.user }

  describe '#index' do
    subject { get :index }

    it { is_expected.to be_success }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to be_success }
  end

  describe '#edit' do
    subject { get :edit, id: id }

    context 'when task exists' do
      let(:id) { task.id }

      it { is_expected.to be_success }
    end
  end

  describe '#update' do
    subject { put :update, id: id, task: params }

    context 'when task belongs to current user' do
      let(:id) { task.id }
      let(:params) { { name: generate(:string) } }

      it { is_expected.to be_redirect }
      it 'updates task name' do
        subject
        expect(task.reload.name).to eq params[:name]
      end
    end

    context 'when task doesnt belong to current user' do
      let(:id) { create(:task).id }
      let(:params) { { name: generate(:string) } }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe '#destroy' do
    subject { delete :destroy, id: id }

    context 'when task belongs to current user' do
      let(:id) { task.id }

      it { is_expected.to be_redirect }
      it 'updates task name' do
        subject
        expect(Task.where(id: id)).not_to exist
      end
    end

    context 'when task doesnt belong to current user' do
      let(:id) { create(:task).id }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
