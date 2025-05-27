require 'rails_helper'

RSpec.describe CalculatorService do
  describe '#add' do
    context 'when string contains only positive integers' do
      it 'returns the correct sum' do
        result = CalculatorService.new.add("100,50,25")
        expect(result).to eq(175)
      end

      it 'returns the correct sum and skip value >= 1000' do
        result = CalculatorService.new.add("100,50,25, 1000, 1200")
        expect(result).to eq(175)
      end
    end

    context 'when string contains negative numbers' do

      it 'includes the negative number in the error message' do
        begin
          CalculatorService.new.add("100,-45,2")
        rescue Exception => e
          expect(e.message).to include("-45")
        end
      end

      it 'includes the negative number in the error message' do
        begin
          CalculatorService.new.add("100,-45, -100,2")
        rescue Exception => e
          expect(e.message).to include("-45, -100")
        end
      end
    end

    context 'when string contains no numbers' do
      it 'returns 0' do
        result = CalculatorService.new.add("")
        expect(result).to eq(0)
      end
    end
  end
end
