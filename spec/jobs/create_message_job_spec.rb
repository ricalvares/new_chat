require 'rails_helper'

RSpec.describe CreateMessageJob, type: :job do
  let(:params) { { user_id: 1, content: 'content', chat_room_id: 1 } }
  describe '#perform_later' do
    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateMessageJob.perform_later(params) }.to have_enqueued_job
    end
  end

  describe 'perform' do
    let(:run_job) { described_class.new(params) }

    context 'should create message'

    context 'should broadcast'
  end
end
