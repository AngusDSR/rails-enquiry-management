class CreateEnquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :enquiries do |t|
      # Basic info & contact details
      t.string :title
      t.string :status, default: 'new'
      t.string :read_status, default: 'unread'
      t.string :first_name
      t.string :surname
      t.string :email
      t.string :phone_number
      t.string :instagram_handle
      t.string :preferred_contact_method

      # Tattoo details
      t.text :description
      t.string :placing
      t.text :notes

      # Appointment details
      t.integer :number_of_sessions, default: 1
      t.datetime :appointment
      t.datetime :follow_up_session_one, default: nil
      t.datetime :follow_up_session_two, default: nil
      t.datetime :follow_up_session_three, default: nil
      t.datetime :follow_up_session_four, default: nil
      t.datetime :follow_up_session_five, default: nil
      t.datetime :follow_up_session_six, default: nil
      t.timestamps
    end
  end
end
