class MessagesController < ApplicationController
  def create
    # メッセージの内容や送信者・受信者の情報を受け取る
    content = params[:message][:content]
    sender_id = current_user.id
    recipient_id = params[:message][:recipient_id]

    # メッセージを作成
    @message = Message.new(content: content, sender_id: sender_id, recipient_id: recipient_id)

    if @message.save
      # メッセージの保存に成功した場合の処理
      flash[:success] = "メッセージが送信されました。"
    else
      # メッセージの保存に失敗した場合の処理
      flash[:error] = "メッセージの送信に失敗しました。"
    end
      render :new # エラーメッセージとともにメッセージ作成ページを再表示
  end
end
