class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KATAKANA_REGEX = /\A[ァ-ヶー－]+\z/

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :last_name_kana, presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力してください' }
  validates :birth_date, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }

  
  has_many :products
end


