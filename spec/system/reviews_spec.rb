require 'rails_helper'

describe '新規登録のテスト' do
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
    end
    it 'Sing upがあるか' do
      expect(page).to have_content('Sign up')
    end
  end
end