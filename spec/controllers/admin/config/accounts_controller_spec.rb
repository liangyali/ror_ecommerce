require  'spec_helper'

describe Admin::Config::AccountsController, type: :controller do
  render_views

  before(:each) do
    activate_authlogic

    @user = create_super_admin_user
    login_as(@user)
  end

  it "index action should render index template" do
    get :index
    expect(response).to render_template(:index)
  end

  #it "show action should render show template" do
  #  @account = create(:account)
  #  get :show, :id => @account.id
  #  expect(response).to render_template(:show)
  #end

  it "new action should render new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Account.any_instance.stubs(:valid?).returns(false)
    post :create, :account => {:name => 'Tests', :account_type => 'Free2You', :monthly_charge => 10, :active => true}
    expect(response).to render_template(:new)
  end

  it "create action should redirect when model is valid" do
    @account = build(:account)
    Account.any_instance.stubs(:valid?).returns(true)
    post :create, :account => {:name => 'Tests', :account_type => 'Free2You', :monthly_charge => 10, :active => true}
    expect(response).to redirect_to(admin_config_accounts_url())
  end

  it "edit action should render edit template" do
    @account = create(:account)
    get :edit, :id => @account.id
    expect(response).to render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    @account = create(:account)
    Account.any_instance.stubs(:valid?).returns(false)
    put :update, :id => @account.id, :account => {:name => 'Tests', :account_type => 'Free2You', :monthly_charge => 10, :active => true}
    expect(response).to render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    @account = create(:account)
    Account.any_instance.stubs(:valid?).returns(true)
    put :update, :id => @account.id, :account => {:name => 'Tests', :account_type => 'Free2You', :monthly_charge => 10, :active => true}
    expect(response).to redirect_to(admin_config_accounts_url())
  end

  it "destroy action should destroy model and redirect to index action" do
    @account = create(:account)
    delete :destroy, :id => @account.id
    expect(response).to redirect_to(admin_config_accounts_url)
    expect(Account.exists?(@account.id)).to be false
  end
end
