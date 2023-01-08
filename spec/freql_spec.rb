# frozen_string_literal: true

RSpec.describe Freql do

  million = 1000000
  billion = 1000000000

  zipf_max = 9
  zipf_small = 1

  it "has a version number" do
    expect(Freql::VERSION).not_to be nil
  end

  context Freql::FQ do
    subject { Freql::FQ }
    {
      to_fpmw: {
        1 => million,
        0 => 0,
        0.5 => million/2
      },
      to_fpbw: {
        1 => billion,
        0 => 0,
        0.5 => billion/2
      },
      to_zipf: {
        1 => zipf_max,
        0.1 => 8,
        0.01 => 7,
        0.00000001 => 1,
        0.000000001 => 0,
        0.0000000001 => -1,
      },
      to_cb: {
        1 => 0,
        0.001 => -300,
        0.0000001 => -700,
      },
    }.each do |fuc, samples|
      context fuc do
        samples.each do |key, val|
          it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
        end
      end
    end
  end

  context Freql::FPMW do
    subject { Freql::FPMW }
    {
      to_fq: {
        million => 1,
        0 => 0,
        (million/2) => 0.5,
      },
      to_fpbw: {
        million => billion,
        0 => 0,
        million / 2 => billion / 2,
      },
      to_zipf: {
        million => zipf_max,
        100 => 5,
        0.01 => 1,
      },
      to_cb: {
        million => 0,
        100 => -400,
        0.01 => -800,
      }
    }.each do |fuc, samples|
      context fuc do
        samples.each do |key, val|
          it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
        end
      end
    end
  end

  context Freql::FPBW do
    subject { Freql::FPBW }
    {
      to_fq: {
        billion => 1,
        0 => 0,
        (billion/2) => 0.5,

      },
      to_fpmw: {
        billion => million,
        0 => 0,
        billion / 2 => million / 2,
      },
      to_zipf: {
        billion => zipf_max,
        million => 6,
        10 => 1,
      },
      to_cb: {
        billion => 0,
        million => -300,
        10 => -800,
      }
    }.each do |fuc, samples|
      context fuc do
        samples.each do |key, val|
          it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
        end
      end
    end
  end

  context Freql::ZipF do
    subject { Freql::ZipF }
    {
      to_fq: {
        zipf_max => 1,
        zipf_small => 1.0e-08,
      },
      to_fpmw: {
        zipf_max => million,
        zipf_small => 0.01,
      },
      to_fpbw: {
        zipf_max => billion,
        zipf_small => 10,
      },
      to_cb: {
        zipf_max => 0,
        zipf_small => -800,
      }
    }.each do |fuc, samples|
      context fuc do
        samples.each do |key, val|
          it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
        end
      end
    end
  end

  context Freql::CB do
    subject { Freql::CB }
    {
      to_fq: {
        0 => 1,
        -800 => 1.0e-08,
      },
      to_fpmw: {
        0 => million,
        -800 => 0.01,
      },
      to_fpbw: {
        0 => billion,
        -800 => 10,
      },
      to_zipf: {
        0 => zipf_max,
        -800 => zipf_small,
      }
    }.each do |fuc, samples|
      context fuc do
        samples.each do |key, val|
          it("#{key} => #{val}") {expect(subject.send(fuc, key)).to eq(val)}
        end
      end
    end
  end


end
