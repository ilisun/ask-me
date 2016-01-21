class SearchController < ApplicationController

  respond_to :html
  skip_authorization_check

  def index
    @results = ThinkingSphinx.search params[:search],
        excerpts: { before_match: '<strong>', after_match: '</strong>' }
    @results.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
    respond_with(@results)
  end

end
