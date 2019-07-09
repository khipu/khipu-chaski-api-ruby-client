require 'date'

module KhipuChaski
  # base class containing fundamental method such as to_hash, build_from_hash and more
  class BaseObject

    # build the object from hash
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /^Array<(.*)>/i
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map{ |v| _deserialize($1, v) } )
          else
            #TODO show warning in debug mode
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        else
          # data not found in attributes(hash), not an issue as the data can be optional
        end
      end

      self
    end

    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value == true || value =~ /^(true|t|yes|y|1)$/i
          true
        else
          false
        end
      else # model
        _model = KhipuChaski.const_get(type).new
        _model.build_from_hash(value)
      end
    end

    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_body (backward compatibility))
    def to_body
      to_hash
    end

    # return the object in the form of hash
    def to_hash
      hash = {}
      attributes = self.class.attribute_map.sort_by {|key,value| key}
      attributes.each { |attr, param|
        value = self.send(attr)
        next if value.nil?
        if value.is_a?(Array)
          hash[param] = value.compact.map{ |v| _to_hash(v) }
        else
          hash[param] = _to_hash(value)
        end
      }
      hash
    end

    # Method to output non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    def _to_hash(value)
      if value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end
end