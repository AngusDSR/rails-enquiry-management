class Enquiry < ApplicationRecord
  before_validation do
    self.title = "#{first_name}-#{description.split.first}-#{placement.split.last}-#{Date.today.strftime('%b').upcase}"
  end

  # validations
  validates :status, inclusion: { in: %w[new awaiting_client_reponse consultation booked ongoing historic ignore/cancel] }, presence: true
  validates :read_status, inclusion: { in: %w[unread read] }, presence: true
  validates :first_name, :title, :email, :phone_number, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'is not a valid email address' }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: 'should be 10 digits' }
  validates :instagram_handle, allow_blank: true, format: { with: /\A@\w+\z/, message: 'should start with @ and contain only letters, numbers, or underscores' }
  validates :preferred_contact_method, inclusion: { in: %w[email text whatsapp instagram] }, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validate :description_min_word_count
  validates :number_of_sessions, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 6 }, presence: true
  validates :consultation_appointment, presence: true, if: :consultation?
  validates :appointment, presence: true, if: :booked?

  # scopes
  scope :new_enquiries, -> { where(status: 'new') }
  scope :waiting_on_client, -> { where(status: 'awaiting_client_reponse') }
  scope :in_consultation, -> { where(status: 'consultation') }
  scope :booked_appointments, -> { where(status: 'booked') }
  scope :multiple_sessions, -> { where(status: 'ongoing') }
  scope :old_enquiries, -> { where(status: 'historic') }
  scope :binned_enquiries, -> { where(status: 'ignore/cancel') }
  scope :unread_enquiries, -> { where(read_status: 'unread') }
  scope :read_enquiries, -> { where(read_status: 'read') }
  scope :appointments_this_week, lambda {
    start_of_week = Time.zone.now.beginning_of_week
    end_of_week = Time.zone.now.end_of_week

    # ? and ? are used to avoid SQL injection, start and end of week for each type of appointment
    where(
      '(:booking >= ? AND :booking <= ?)
        OR (:consultation_appointment >= ? AND :consultation_appointment <= ?)
        OR (:follow_up_session_one >= ? AND :follow_up_session_one <= ?)
        OR (:follow_up_session_two >= ? AND :follow_up_session_two <= ?)
        OR (:follow_up_session_three >= ? AND :follow_up_session_three <= ?)
        OR (:follow_up_session_four >= ? AND :follow_up_session_four <= ?)
        OR (:follow_up_session_five >= ? AND :follow_up_session_five <= ?)
        OR (:follow_up_session_six >= ? AND :follow_up_session_six <= ?)
      ',
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week,
      start_of_week, end_of_week
    )
  }

  scope :appointments_today, lambda {
    start_of_day = Time.zone.now.beginning_of_day
    end_of_day = Time.zone.now.end_of_day

    # ? and ? are used to avoid SQL injection, start and end of day for each type of appointment
    where(
      '(:booking >= ? AND :booking <= ?)
        OR (:consultation_appointment >= ? AND :consultation_appointment <= ?)
        OR (:follow_up_session_one >= ? AND :follow_up_session_one <= ?)
        OR (:follow_up_session_two >= ? AND :follow_up_session_two <= ?)
        OR (:follow_up_session_three >= ? AND :follow_up_session_three <= ?)
        OR (:follow_up_session_four >= ? AND :follow_up_session_four <= ?)
        OR (:follow_up_session_five >= ? AND :follow_up_session_five <= ?)
        OR (:follow_up_session_six >= ? AND :follow_up_session_six <= ?)
      ',
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day,
      start_of_day, end_of_day
    )
  }

  # model methods
  def description_min_word_count
    return unless description.present? && description.split.length < 2

    errors.add(:description, 'should be more than one word')
  end

  def consultation?
    status == 'consultation'
  end

  def booked?
    status == 'booked'
  end
end
