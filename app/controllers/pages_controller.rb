# frozen_string_literal: true

# Controller for simple webpages not tied to a model
class PagesController < ApplicationController
  def home
    render :home
  end
end
