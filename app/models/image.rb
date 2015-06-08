class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :likes
  default_scope { order(created_at: :desc)}

  def add_tags_from_caption
    find_tags.each do |tag|
      Tag.create(name: tag) if !Tag.find_by(name: tag)
    end
  end

  def displays_caption_with_tags_as_links
    @added_anchors = caption.split('#').first
    Tag.all.each do |tag|
      @added_anchors += caption.slice(/#{tag.name}/).gsub("#{tag.name}", "<a href='/search?search=#{tag.name[1..-1]}'>#{tag.name}</a> ") if caption.slice(/#{tag.name}/)
    end
    @added_anchors.html_safe
  end

  def self.search_by_hashtag(hashtag = nil)
    return [] if hashtag.blank?
    Image.where("caption like ?", "%##{hashtag}%")
  end

  def shorten_caption
    shortened = caption.split(" ")[0..3].join(" ").capitalize
    shortened << "..." if caption.split(" ").length > 4
    shortened
  end

  def time_since_posted
    time_posted = created_at.to_i
    current_time = Time.now.to_i
    difference = current_time - time_posted
      if difference < 60
        "#{difference}s Ago"
      elsif difference < 3600
        "#{difference/60}m Ago"
      elsif difference < 86400
        "#{difference/3600}hr Ago"
      else
        "#{difference/86400}d Ago"
      end
  end

  private
  def find_tags
    seperate_caption_into_words_array.select { |word| word.starts_with?("#")}
  end

  def seperate_caption_into_words_array
    caption.split(" ")
  end
end