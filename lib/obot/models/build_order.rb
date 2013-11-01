class BuildOrders
  class << self
    def add(build_order, collection_type)
      data.transaction do |build_orders| 
        collection(build_orders, collection_type).push({
          planet_id:  build_order.planet_id,
          type:       build_order.type
        })
      end 
    end

    private

    def collection(build_orders, collection_type = :wait)
      if collection_type    == :wait
        collection_wait(build_orders)
      elsif collection_type == :todo
        collection_todo(build_orders)
      end
    end

    def data
      PStore.new("data/build_orders.pstore")
    end

    def collection_wait(build_orders)
      build_orders[:collection_wait] ||= Array.new
    end

    def collection_todo(build_orders)
      build_orders[:collection_todo] ||= Array.new
    end
  end
end

class BuildOrder
  attr_reader :planet_id, :type

  def initialize(planet_id, type, at)
    @planet_id = planet_id
    @type      = type
    @at        = at
  end

  # Using at command to move the order from wait to todo
  #def set_at
  #end
end