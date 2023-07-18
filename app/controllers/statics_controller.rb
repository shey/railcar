# frozen_string_literal: true


class StaticsController < ApplicationController
  def index
    @name = IncidentName::generate
  end
end
