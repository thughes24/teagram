require 'spec_helper'

describe Follow do
  it {should belong_to(:followee)}
  it {should belong_to(:follower)}
end