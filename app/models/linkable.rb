class Linkable < ApplicationRecord
  self.abstract_class = true

  @links

  def _links
    @links
  end
  
  def add_link(rel, href, title=nil)
    @links = Hash.new if @links.nil?
    link = { href: href }
    link[:title] = title unless title.nil?
    @links[rel] = link
    @links
  end
end
