class String
  def sanitize
    html_tags_regex = /<("[^"]*"|'[^']*'|[^'">])*>/
    self.to_s.gsub(html_tags_regex, '') rescue nil
  end
end