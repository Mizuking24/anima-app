require 'rails_helper'

RSpec.describe 'Animeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { anime.valid? }

    let(:user) { create(:user) }
    let!(:anime) { build(:anime, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        anime.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        anime.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        anime.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        anime.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Anime.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'PostComentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Anime.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Anime.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
  end
end