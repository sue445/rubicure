module Cure
  module CosmoExt
    def transform!(style = nil)
      return super unless style == :rainbow_perfume

      humanize!

      self[:human_name] = %w[マオ ブルーキャット バケニャーン].sample

      print_by_line "レインボーパフュームいくニャン！"

      self
    end

    def rollback
      self[:human_name] = "ユニ"
      self
    end
  end
end

[Cure.cosmo, Cure.cure_cosmo].each do |cosmo|
  cosmo.singleton_class.prepend(Cure::CosmoExt)
end
