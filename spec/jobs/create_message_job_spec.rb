require 'rails_helper'

RSpec.describe CreateMessageJob, type: :job do
  let(:user) { create(:user) }
  let(:chat_room_id) { create(:chat_room).id }
  let(:message_content) { Faker::Lorem.sentence }

  let(:user_id) { user.id }
  let(:params) { { user_id: user_id, content: message_content, chat_room_id: chat_room_id } }

  describe '#perform_later' do
    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateMessageJob.perform_later(params) }.to have_enqueued_job
    end
  end

  describe 'perform' do
    let(:run_job) { described_class.perform_now(params) }

    context 'succesfully' do
      it 'should create message' do
        expect { run_job }.to change(Message, :count).by(1)
      end

      it 'should broadcast' do
        message = {
          content: message_content,
          creator: user.name,
          room_id: chat_room_id
        }.with_indifferent_access
        expect { run_job }.to have_broadcasted_to('chat_room_channel').with(a_hash_including(message))
      end
    end

    context 'in case of failure' do
      context 'with no user' do
        let(:user_id) { 0 }

        it 'does not create a message' do
          expect { run_job }.to_not change(Message,:count)
        end

        it 'does not broadcast' do
          expect { run_job }.to_not have_broadcasted_to('chat_room_channel')
        end
        it 'should log'
      end

      context 'with no chat_room' do
        let(:chat_room_id) { 0 }
        it 'should log'
      end
    end
  end
end
