class ContactsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'contacts_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
