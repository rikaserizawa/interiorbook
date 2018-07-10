class RankingsController < ApplicationController
  def scrap
    @ranking_counts = Scrap.ranking
    @interiors = Interior.find(@ranking_counts.keys)
  end
end
