class ItemsFacade
  def self.items_index(params)
    # require "pry"; binding.pry
    if params[:per_page].nil? == true && params[:page].nil? == true
      Item.obtain_items(20, 1)
    elsif params[:per_page].nil? == true
      Item.obtain_items(20, params[:page])
    elsif params[:page].nil? == true
      Item.obtain_items(params[:per_page], 1)
    else
      Item.obtain_items(params[:per_page].to_i, params[:page].to_i)
    end
  end
end
