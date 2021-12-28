class User < ApplicationRecord

  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many :test_passages, dependent: :destroy


  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true


  has_secure_password

  def passed_tests(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
