require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:anime) { create(:anime, user: user) }
  let!(:other_anime) { create(:anime, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'Homeを押すと、投稿一覧画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/animes'
      end
      it 'Newpostsを押すと、新規投稿画面に遷移する' do
        newposts_link = find_all('a')[2].native.inner_text
        newposts_link = newposts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link newposts_link
        is_expected.to eq '/animes/new'
      end
      it 'Mypageを押すと、自分のユーザー詳細画面に遷移する' do
        mypage_link = find_all('a')[3].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'Usersを押すと、ユーザ一覧画面に遷移する' do
        users_link = find_all('a')[4].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit animes_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/animes'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: anime_path(anime)
        expect(page).to have_link '', href: anime_path(other_anime)
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link anime.title, href: anime_path(anime)
        expect(page).to have_link other_anime.title, href: anime_path(other_anime)
      end
      it '自分の投稿と他人の投稿の感想が表示される' do
        expect(page).to have_content anime.body
        expect(page).to have_content other_anime.body
      end
    end
  end

  describe '新規投稿のテスト' do
    before do
      visit  new_anime_path
    end

    context '投稿画面のテスト' do
      it '「新規投稿フォーム」と表示される' do
        expect(page).to have_content '新規投稿フォーム'
      end
       it '画像フォームが表示される' do
        expect(page).to have_field 'anime[image]'
      end
      it '画像フォームに値が入っていない' do
        expect(find_field('anime[image]').text).to be_blank
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'anime[title]'
      end
      it 'titleフォームに値が入っていない' do
        expect(find_field('anime[title]').text).to be_blank
      end
      it 'bodyフォームが表示される' do
        expect(page).to have_field 'anime[body]'
      end
      it 'bodyフォームに値が入っていない' do
        expect(find_field('anime[body]').text).to be_blank
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'anime[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'anime[body]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.animes, :count).by(1)
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/animes'
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit anime_path(anime)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/animes/' + anime.id.to_s
      end
      it 'ユーザ画像・名前のリンク先が正しい' do
        expect(page).to have_link anime.user.name, href: user_path(anime.user)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content anime.title
      end
      it '投稿のbodyが表示される' do
        expect(page).to have_content anime.body
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_anime_path(anime)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: anime_path(anime)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/animes/' + anime.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(Anime.where(id: anime.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/animes'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_anime_path(anime)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/animes/' + anime.id.to_s + '/edit'
      end
      it '「投稿編集画面」と表示される' do
        expect(page).to have_content '投稿編集画面'
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'anime[image]'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'anime[title]', with: anime.title
      end
      it 'body編集フォームが表示される' do
        expect(page).to have_field 'anime[body]', with: anime.body
      end
      it '編集ボタンが表示される' do
        expect(page).to have_button '編集'
      end
    end

    context '編集成功のテスト' do
      before do
        @anime_old_title = anime.title
        @anime_old_body = anime.body
        fill_in 'anime[title]', with: Faker::Lorem.characters(number: 4)
        fill_in 'anime[body]', with: Faker::Lorem.characters(number: 19)
        click_button '編集'
      end

      it 'titleが正しく更新される' do
        expect(anime.reload.title).not_to eq @anime_old_title
      end
      it 'bodyが正しく更新される' do
        expect(anime.reload.body).not_to eq @anime_old_body
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/animes/' + anime.id.to_s
      end
    end
  end

  describe 'ユーザ一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分と他人の名前がそれぞれ表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
      it '自分と他人のshowリンクがそれぞれ表示される' do
        expect(page).to have_link 'show', href: user_path(user)
        expect(page).to have_link 'show', href: user_path(other_user)
      end
      it 'ユーザー検索のリンクが表示されている' do
        expect(page).to have_link 'ユーザー検索', href: search_users_path
      end
    end
  end

  describe 'ユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context 'マイページの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
        expect(page).to have_link anime.title, href: anime_path(anime)
      end
      it '投稿一覧に自分の投稿のbodyが表示される' do
        expect(page).to have_content anime.body
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_anime.title
        expect(page).not_to have_content other_anime.body
      end
      it '他人のユーザ編集画面へのリンクは表示されない' do
        expect(page).not_to have_link '', href: edit_user_path(other_user)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[icon]'
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_introduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_introduction
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end
