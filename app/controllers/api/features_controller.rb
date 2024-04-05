require 'will_paginate/array'

module Api
  class FeaturesController < ApplicationController
    def index
      features = Feature.all
      features = filter_by_mag_type(features, params[:filters][:mag_type]) if params[:filters].present? && params[:filters][:mag_type].present?
      features = features.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)

      render json: {
        data: features.map { |feature| serialize_feature(feature) },
        pagination: {
          current_page: features.current_page,
          total: features.total_entries,
          per_page: features.per_page
        }
      }
    end

    private

    def serialize_feature(feature)
      {
        id: feature.id,
        type: 'feature',
        attributes: {
          external_id: feature.external_id,
          magnitude: feature.mag,
          place: feature.place,
          time: feature.time.to_s,
          tsunami: feature.tsunami,
          mag_type: feature.mag_type,
          title: feature.title,
          coordinates: {
            longitude: feature.longitude,
            latitude: feature.latitude
          }
        },
        links: {
          external_url: feature.external_url
        }
      }
    end

    def filter_by_mag_type(features, mag_type)
      features.where(mag_type: mag_type)
    end
  end
end
