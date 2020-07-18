class MicroPostsFeedQuery < BaseQuery
  attr_reader :user, :page

  def call(params)
    @user = User.find(params[:user_id])
    @page = params[:page]

    initial_scope
      .where(user_id: user_ids)
  end

  private
    def user_ids
      return @user_ids if @user_ids

      @user_ids = []
        .concat([user.id])
        .concat(user.following.pluck(:id))
      @user_ids
    end
end
