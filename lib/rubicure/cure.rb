module Cure
  Rubicure::Girl.names.each do |girl_name|
    define_singleton_method girl_name do
      Rubicure::Girl.find(girl_name)
    end
  end

  def self.define_turnover_methods(target, original_human_name, another_human_name)
    target.instance_variable_set(:@__original_human_name, original_human_name)
    target.instance_variable_set(:@__another_human_name,  another_human_name)

    def target.!
      humanize!
      @another_human_name ||= @__another_human_name

      self[:human_name], @another_human_name = @another_human_name, self[:human_name]

      self
    end

    def target.rollback
      self[:human_name]   = @__original_human_name
      @another_human_name = @__another_human_name
      self
    end
  end
end
