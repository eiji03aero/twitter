class BaseQuery
  attr_reader :initial_scope

  def initialize(params)
    @initial_scope = params[:initial_scope]
  end

  # @abstract Subclass should implement #call
  # @!method call(params)
  #   Executes query logic
  #   @param [Hash] params optional hash parameter
end
