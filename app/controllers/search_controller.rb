class SearchController < ApplicationController
  def search
    @content = params[:search][:content]
    @model = params[:search][:model]
    @how = params[:search][:how]
    @search = search_for(@content, @model, @how).page(params[:page]).reverse_order.per(7)
  end

  private

  def match(content, model)
    if model == 'user'
      User.where(name: content)
    elsif model == 'book'
      Book.where(title: content)
    end
  end

  def forward(content, model)
    if model == 'user'
      User.where("name LIKE ?", "#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{content}%")
    end
  end

  def backward(content, model)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}")
    end
  end

  def partial(content, model)
    if model == 'user'
      User.where("name LIKE ?", "%#{content}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{content}%")
    end
  end

  def search_for(content, model, how)
    case how
    when 'match'
      match(content, model)
    when 'forward'
      forward(content, model)
    when 'backward'
      backward(content, model)
    when 'partial'
      partial(content, model)
    end
  end
end
