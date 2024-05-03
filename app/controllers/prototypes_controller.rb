class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  #上記の３行で纏めているから以下の[id]が取れる

  def index
    @prototypes = Prototype.includes(:user)
     #@prototypes = Prototype.allも可、でも何千件となったら無駄が多いからincludesを推奨
     #ALLだけだとuserは引っ張れないが、下の個別の[id]を取ってい理由は上の３行で現れるのであってincludeしたから削除して良いのではない！）
     
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    #@prototype = Prototype.find(params[:id]) 
    @comment = Comment.new
    @comments = @prototype.comments
   #@comments = @prototype.comments.includes(:user)ここじゃない?
  end

  def edit
    #@prototype = Prototype.find(params[:id])
  end

  def update
    #@prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
      #これは保存するための記述だから下のおまとめとは別の意味だから削っちゃダメ。編集時ブランクエラーがあってもその他の記述は残す記述
    end
  end

  def destroy
    #@prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
    #@prototype.destroy

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    #これ以上長くなるなら改行した方が良い
  end

      def set_prototype
       @prototype = Prototype.find(params[:id])
       #上記記述をおまとめする記述（だから個別には消して良い！）
      end

      def contributor_confirmation
      redirect_to root_path unless current_user == @prototype.user
      #ログインユーザーと投稿ユーザーが同じ・・でなかったらroot_pathへの記述
      end
end