module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

module Enum; end
class String; include Enum; end

class String
  def to_type(type)
    # cannot use 'case type' which checks for instances of a type rather than type equality
    if type == 'Boolean' then self =~ /true/i
    elsif type == 'Date' then Date.parse(self)
    elsif type == 'DateTime' then DateTime.parse(self)
    elsif type == 'Enum' then self.upcase.tr(" ", "_")
    elsif type == 'Float' then self.to_f
    elsif type == 'Integer' then self.to_i
    else self
    end
  end
end

def validate_list(data, of = nil, count = nil, at_least = nil)
  expect(data).to be_a_kind_of(Array)
  expect(data.count).to eq(count) unless count.nil?
  expect(data.count).to be >= at_least unless at_least.nil?

  unless of.nil?
    data.each { |item| validate_type(item, of) }
  end
end

def validate_type(data, type)
  validate_item = "validate_#{type}".to_sym
  send(validate_item, data)
end