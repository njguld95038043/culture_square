require 'rails_helper'

describe Review, js: true do
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    it 'root_pathが"/"であるか' do
      expect(current_path).to eq('/')
      expect(page).to have_content('Sign up')
    end
  end
  describe '新規登録画面のテスト' do
    before do
      visit root_path
      @end_user = FactoryBot.build(:end_user)
    end
    it 'Sing upがあるか' do
      expect(page).to have_content('Sign up')
      visit new_end_user_registration_path
      fill_in 'end_user[nick_name]', with: @end_user.nick_name
      fill_in 'end_user[email]', with: @end_user.email
      select '公務員',from: 'end_user[occupation]'
      select '1931',from: 'end_user[birthday(1i)]'
      select '10',from: 'end_user[birthday(2i)]'
      select '10',from: 'end_user[birthday(3i)]'
      select '男性',from: 'end_user[gender]'
      fill_in 'end_user[password]', with: @end_user.password
      fill_in 'end_user[password_confirmation]', with: @end_user.password_confirmation
      click_button '新規登録'
    end
    it 'root_pathが"/"であるか' do
      expect(current_path).to eq('/')
    end
  end
  context '楽天ブックス検索' do
    let(:end_user){ create(:end_user) }
    let(:book) {create(:book)}

    before do
      visit new_end_user_session_path
      fill_in 'end_user[email]', with: end_user.email
      fill_in 'end_user[password]', with: end_user.password
      click_on 'ログイン'
    end

    it '本の検索ができるか' do
      fill_in 'keyword', with: '嫌われる勇気'
      find('#rakuten_seach').click
      expect(current_path).to eq(rakuten_books_path)
      click_on ('レビュー登録')
      expect(current_path).to eq(new_review_path)
    end

    it 'レビュー登録出来るか' do
      fill_in 'keyword', with: '嫌われる勇気'
      find('#rakuten_seach').click
      click_on ('レビュー登録')
      expect(current_path).to eq(new_review_path)
      find("option[value='1']").select_option
      find('#review_star').find("img[alt='3']").click
      fill_in 'review[review]', with: "aaaa"
      click_button '投稿する'
      expect(current_path).to eq('/reviews/1')
    end
  end
end