document.addEventListener('DOMContentLoaded', function() {
  const reviewContents = document.querySelectorAll('.review-content');
  reviewContents.forEach((reviewContent) => {
    const ellipsisContent = reviewContent.querySelector('.review-content-ellipsis');
    const fullContent = reviewContent.querySelector('.review-content-full');

    ellipsisContent.addEventListener('click', function() {
      reviewContent.classList.add('show-full');
    });
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const spoilerLabels = document.querySelectorAll('.spoiler-label');
  spoilerLabels.forEach(function(label) {
    label.addEventListener('click', function() {
      const reviewId = label.dataset.reviewId;
      const spoilerContent = document.querySelector(`.review-content[data-review-id="${reviewId}"] .review-full-content`);
      spoilerContent.style.display = 'block';
      label.style.display = 'none';
    });
  });
});