class ProconBypassManCommand < ApplicationRecord
  validates :name, :first_buttons, presence: true
  validates :repeat_count, numericality: { greater_than_or_equal_to: 1 }
  # TODO: スペースは容認しつつ、カンマ区切りかつ、存在しないボタンをブロックするバリデーションを入れる

  # TODO: カラムの中身を, でsplitしたほうがいいかも
  def to_commands_as_remote
    repeat_count.times.reduce([]){ |a, item|
      a.push(first_buttons)
      a.push(second_buttons) if second_buttons.present?
      next a
    }
  end
end
