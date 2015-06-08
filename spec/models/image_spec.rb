require 'spec_helper'

describe Image do
  it {should belong_to(:user)}
  it {should have_many(:likes)}

  describe "#add_tags" do
    it "adds tags to the database" do
      current_user = Fabricate(:user)
      image = Fabricate(:image, caption: "hello #hi #poo #bum")
      image.add_tags_from_caption
      expect(Tag.all.map(&:name)).to eq(['#hi','#poo','#bum'])
    end

    it "doesnt add duplicates of tags in the database" do
      current_user = Fabricate(:user)
      image = Fabricate(:image, caption: "hello #hi #hi #bum")
      image.add_tags_from_caption
      expect(Tag.all.map(&:name)).to eq(['#hi','#bum'])
    end
  end

  describe "#search_by_hashtags" do
    it "returns an empty array if no images are found" do
      image1 = Fabricate(:image, caption: "hello #hi")
      image2 = Fabricate(:image, caption: "hello #farts")
      image3 = Fabricate(:image, caption: "hello #sweat")
      expect(Image.search_by_hashtag('poop')).to match_array([])
    end
    it "returns an image if the image caption contains the searched hashtag" do
      image1 = Fabricate(:image, caption: "hello #hi")
      image2 = Fabricate(:image, caption: "hello #farts")
      image3 = Fabricate(:image, caption: "hello #sweat")
      expect(Image.search_by_hashtag('farts')).to match_array([image2])
    end
    it "returns an array of images if multiple images with the search hashtag are found" do
      image1 = Fabricate(:image, caption: "hello #hi")
      image2 = Fabricate(:image, caption: "hello #farts")
      image3 = Fabricate(:image, caption: "hello #sweat #farts")
      expect(Image.search_by_hashtag('farts')).to match_array([image2, image3])
    end
    it "returns an empty array if no search term is entered" do
      image1 = Fabricate(:image, caption: "hello #hi")
      image2 = Fabricate(:image, caption: "hello #farts")
      image3 = Fabricate(:image, caption: "hello #sweat")
      expect(Image.search_by_hashtag('')).to match_array([])
    end
  end

  describe "#displays_caption_with_tags_as_links" do
    it "does not show duplicate hashtags from caption" do
      image = Fabricate(:image, caption: "hello #hi #hi #hi")
      image.add_tags_from_caption
      expect(image.displays_caption_with_tags_as_links).to eq("hello <a href='/search?search=hi'>#hi</a> ")
    end
  end

  describe "#shorten_caption" do
    it "capitalizes the caption" do
      image = Fabricate(:image, caption: "hello old friend")
      expect(image.shorten_caption).to eq("Hello old friend")
    end
    it "cuts the caption after the 4th word" do
      image = Fabricate(:image, caption: "hello old friend what is up") 
      expect(image.shorten_caption).to eq("Hello old friend what...")   
    end
  end
end