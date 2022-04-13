require 'rails_helper'

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