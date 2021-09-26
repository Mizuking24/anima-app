require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:post_comment) { build(:post_comment) }

    context 'commentカラム' do
      it '空欄でないこと' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        post_comment.comment = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        post_comment.comment = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        post_comment.comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        post_comment.comment = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Animeモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:anime).macro).to eq :belongs_to
      end
    end
  end
end