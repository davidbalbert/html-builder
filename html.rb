class HTML < BasicObject
  class Tag
    attr_reader :name, :children, :attributes

    def initialize(name, attributes = {}, children = [])
      @name = name.to_s
      @attributes = attributes
      @children = children
    end

    def has_children?
      children.size > 0
    end

    def has_attributes?
      attributes.size > 0
    end

    def should_always_have_closing_tag?
      name == "script"
    end

    def to_s
      if has_children?
        "<#{name}#{attribute_string}>#{children.map(&:to_s).join}</#{name}>"
      elsif should_always_have_closing_tag?
        "<#{name}#{attribute_string}></#{name}>"
      else
        "<#{name}#{attribute_string} />"
      end
    end

  private

    def attribute_string
      if has_attributes?
        " #{attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")}"
      else
        ""
      end
    end
  end

  attr_reader :tags

  def self.html(&block)
    new.html(&block).to_s
  end

  def initialize
    @tags = []
  end

  def has_tags?
    !tags.empty?
  end

  def method_missing(name, *args, &block)
    attributes = args.first || {}

    if block
      child_context = ::HTML.new
      res = child_context.instance_eval(&block)

      unless res.is_a? Tag
        tag = Tag.new(name, attributes, [res])
      else
        tag = Tag.new(name, attributes, child_context.tags)
      end
    else
      tag = Tag.new(name, attributes)
    end

    @tags << tag

    tag
  end
end
