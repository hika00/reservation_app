class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :checkin_at_after_or_equal_today
  validate :checkout_at_after_checkin_at
  validate :guest_count_greater_than_or_equal_to_one

  private

  def checkin_at_after_or_equal_today
    return if checkin_at.blank?

    if checkin_at < Date.today
      errors.add(:checkin_at, "は本日以降の日付で選択してください。")
    end
  end

  def checkout_at_after_checkin_at
    return if checkin_at.blank? || checkout_at.blank?

    if checkout_at <= checkin_at
      errors.add(:checkout_at, "はチェックイン日より後の日付で選択してください。")
    end
  end

  def guest_count_greater_than_or_equal_to_one
    return if guest_count.blank?

    if guest_count < 1
      errors.add(:guest_count, "は1人以上で入力してください。")
    end
  end
