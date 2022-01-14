class Admin::TestsController < Admin::BaseController

  def show
    @test = Test.find(params[:id])
  end

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.build(test_params)
    if @test.save
      redirect_to admin_test_path(@test)
    else
      render plain: 'Тест не сохранён'
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Тест не найден'
  end
end
