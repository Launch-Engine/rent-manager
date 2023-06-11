class RentManagerRelation < RentManager::RecordBase
  attr_reader :id,
              :embeds,
              :fields,
              :filters,
              :join,
              :nocontent,
              :order_by,
              :page_number,
              :page_size,
              :auth

  class << self
    def authenticate(args)
      new.authenticate(args)
    end

    def embeds(args)
      new.embeds(args)
    end

    def fields(args)
      new.fields(args)
    end

    def filter(args)
      new.filter(args)
    end

    def find(id)
      new.find(id)
    end

    def id(id)
      new.id(id)
    end

    def join(model)
      new.join(model)
    end

    def list(args = {})
      new.list(args)
    end
  end

  def initialize
    @auth = {}
    @id = nil
    @embeds = []
    @fields = []
    @filters = []
    @join = nil
    @nocontent = false
    @order_by = nil
    @page = nil
    @page_size = nil
  end

  def authenticate(args)
    @auth = args
    self
  end

  def embeds(*args)
    @embeds += arrayitize(args)
    self
  end

  def fields(*args)
    @fields += arrayitize(args)
    self
  end

  def filter(*args)
    @filters += arrayitize(args)
    self
  end

  def find(id)
    self.class.fetch_id(path, id, @auth)
  end

  def id(id)
    @id = id
    self
  end

  def join(model)
    @join = camelize_string(model)
    self
  end

  def list(page_params = {})
    # Need to authenticate when page params are passed with authenticated request
    @page_number = page_params[:page_number] if page_params.key?(:page_number)
    @page_size = page_params[:page_size] if page_params.key?(:page_size)
    @order_by = page_params[:order_by] if page_params.key?(:order_by)

    self.class.fetch(path, params.merge(@auth))
  end

  def nocontent!
    nocontent = true
  end

  def order_by(order)
    @order_by = order
  end

  def page_number(page)
    @page_number = page
  end

  def page_size(size)
    @page_size = size
  end

  def path
    retval = self.class.base_path
    retval += "/#{@id}" if @id
    retval += "/#{@join}" if @join
    retval
  end

  def params
    retval = {}
    retval[:embeds] = @embeds.map { |str| camelize_string(str) }.join(',') if @embeds.any?
    retval[:fields] = @fields.map { |str| camelize_string(str) }.join(',') if @fields.any?
    retval[:filters] = @filters.join(';') if @filters.any?
    retval[:pagenumber] = @page_number if @page_number
    retval[:pagesize] = @page_size if @page_size
    retval[:orderby] = @order_by if @order_by
    retval[:nocontent] = 'true' if @nocontent
    retval
  end

  private

  def arrayitize(array_or_string)
    array_or_string.is_a?(Array) ? array_or_string : [array_or_string]
  end

  def camelize_string(str)
    str.to_s.split('_').collect(&:capitalize).join
  end
end
