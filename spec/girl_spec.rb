# -*- coding: utf-8 -*-
describe Rubicure::Girl do
  describe "#name" do
    let(:girl){
      Rubicure::Girl.new(
          human_name:        human_name,
          precure_name:      precure_name,
          extra_names:       extra_names,
          transform_message: transform_message
      )
    }

    let(:human_name)     { "黄瀬やよい" }
    let(:precure_name)   { "キュアピース" }
    let(:extra_names)    { %w(プリンセスピース ウルトラピース) }
    let(:transform_message){
      <<EOF
プリキュアスマイルチャージ！
GO! GO! Let's GO ピース！
ピカピカピカリンジャンケンポン！ キュアピース！
EOF
    }

    context "when before transform" do
      it{ expect(girl.name).to eq human_name }
    end

    context "when after 1st transform" do
      before do
        girl.transform!
      end

      it{ expect(girl.name).to eq precure_name }
    end

    context "when after 2nd transform" do
      before do
        girl.transform!
        girl.transform!
      end

      it{ expect(girl.name).to eq extra_names[0] }
    end

    context "when after 3nd transform" do
      before do
        girl.transform!
        girl.transform!
        girl.transform!
      end

      it{ expect(girl.name).to eq extra_names[1] }
    end

    context "when after final transform" do
      before do
        girl.transform!
        girl.transform!
        girl.transform!
        girl.transform!
      end

      # return to human
      it{ expect(girl.name).to eq human_name }
    end
  end

  describe "#==" do
    let(:girl){
      Rubicure::Girl.new(
          human_name:        human_name,
          precure_name:      precure_name,
          extra_names:       extra_names,
          transform_message: transform_message
      )
    }

    let(:human_name)     { "黄瀬やよい" }
    let(:precure_name)   { "キュアピース" }
    let(:extra_names)    { %w(プリンセスピース ウルトラピース) }
    let(:transform_message){
      <<EOF
プリキュアスマイルチャージ！
GO! GO! Let's GO ピース！
ピカピカピカリンジャンケンポン！ キュアピース！
EOF
    }

    context "same object" do
      subject{ girl == girl }
      it{ should be true }
    end

    context "copied object" do
      subject{ girl == copied_girl }
      let(:copied_girl){ girl.dup }
      it{ should be true }
    end

    context "precure and human" do
      subject{ girl == transformed_girl }
      let(:transformed_girl){ girl.dup.transform! }
      it{ expect(girl.name).not_to eq transformed_girl.name }
      it{ should be true }
    end

    context "other precure" do
      subject{ girl == other_girl }
      let(:other_girl){ Rubicure::Girl.find(:passion) }
      it{ should be false }
    end
  end

  describe "#find" do
    subject{ Rubicure::Girl.find(girl_name) }

    let(:girl_name){ :peace }

    it{ should be_an_instance_of Rubicure::Girl }
    it{ expect(subject.precure_name).to eq "キュアピース" }
  end

  describe "#uniq_names" do
    subject{ Rubicure::Girl.uniq_names }

    let(:all_stars_count){ Rubicure.core.all_stars.count }

    it{ expect(subject.count).to eq all_stars_count }
  end
end
