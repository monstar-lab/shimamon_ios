class Post
  PROPERTIES = [:posted_at, :author_url_key, :url_key, :title, :cover_photo]
  attr_accessor *PROPERTIES

  def initialize(hash = {})
    hash.each do |key, value|
      self.send((key.to_s + "=").to_s, value) if PROPERTIES.member?(key.to_sym)
    end
  end

  # 記事一覧を取得
  def self.index(params={}, &block)
    AFMotion::JSON.get("http://shimane.monstar-lab.com/json") do |result|
      result.object['posts'].each do |post_data|
        post = Post.new(post_data)
        block.call(post)
      end
    end
  end

end
