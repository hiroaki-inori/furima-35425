import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },  

  received(data) {
    var path = location.pathname ;
    // console.log(path)
    if (path == `/items/${data.content.item_id}`){
    // console.log(data.content.item_id)
    const html = `<p class="comment">${data.content.text} <span class="name-date">${data.user.nickname} (${data.created_at})</span></p>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
    if (document.getElementById('comment-nil')){
      const nil = document.getElementById('comment-nil');
      nil.remove();
    }
  }}
});
