require 'rails_helper'

RSpec.describe Postcodes::Postcode, type: :model do

  describe 'validations' do
    subject { described_class.new(postcode: 'AB1 2BC', data: {country: country}) }

    describe 'country' do
      context 'when is England' do
        let(:country) { 'England' }
        it { is_expected.to be_valid }
      end

      context 'when is England' do
        let(:country) { 'Scotland' }
        before { subject.valid? }
        it { is_expected.not_to be_valid }
        it { expect(subject.errors.full_messages).to eq(["Country is not registered as part of England. Please contact partnerships@phe.gov.uk if you require an account and work in England."]) }
      end

    end
  end

  describe 'callbacks' do
    it 'strips out every space' do
      expect(described_class.new(postcode: 'ab12bc').postcode).to eq 'AB12BC'
      expect(described_class.new(postcode: ' ab1  2bc').postcode).to eq 'AB12BC'
    end

    it 'upcases the postcode' do
      expect(described_class.new(postcode: 'AB1 2BC').postcode).to eq 'AB12BC'
    end

  end

end
