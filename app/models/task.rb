class Task < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates :name, presence: true

  aasm do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end
end
