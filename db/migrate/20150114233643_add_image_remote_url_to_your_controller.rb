class AddImageRemoteUrlToYourController < ActiveRecord::Migration
  def change
    add_column :recipes, :image_remote_url, :string
  end
end
