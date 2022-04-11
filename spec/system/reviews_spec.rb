require 'rails_helper'

describe '投稿のテスト' do
  let!(:review) { create(:review,review:'hoge',rate:'3.5') }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
end