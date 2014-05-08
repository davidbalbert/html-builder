class HTML
  class Tag
    attr_reader :name, :children, :attributes

    def initialize(name, attributes = {}, children = [])
      @name = name
      @attributes = attributes
      @children = children
    end

    def children?
      children.size > 0
    end

    def to_s
      if children?
        "<#{name}>#{children.map(&:to_s).join}</#{name}>"
      else
        "<#{name} />"
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
      child_context = self.class.new
      res = child_context.instance_eval(&block)

      if child_context.has_tags?
        tag = Tag.new(name.to_s, attributes, child_context.tags)
      else
        tag = Tag.new(name.to_s, attributes, [res])
      end
    else
      tag = Tag.new(name.to_s, attributes)
    end

    @tags << tag

    tag
  end
end
