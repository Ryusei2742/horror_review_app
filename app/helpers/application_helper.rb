module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(page_title = "")
    base_title = "ホラー映画レビューサイト"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # 評価を星マークで表示するヘルパーメソッド
  def display_rating(rating)
    if rating.nil? || rating <= 0
      content_tag(:span, "評価なし", class: "rating")
    else
      stars = "*" * rating.round
      content_tag(:span, stars.html_safe, class: "rating")
    end
  end
end
