# frozen_string_literal: true

# controller for pages not associated with a model.
class PagesController < ApplicationController
  def home
    render :home
  end
end
