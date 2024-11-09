class UserController < ApplicationController

  def login
 
    render({ :template => "login_template/login" })

  end 

  def signup
 
    render({ :template => "login_template/signup" })

  end 

end
