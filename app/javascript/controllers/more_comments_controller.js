import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="more-comments"
export default class extends Controller {

  static values = { commentsListId: String, postId: Number }

  connect() {
    self.limit = 10
    self.offset = self.limit
  }

  click(event) {
    event.preventDefault()

    var url = `/posts/${this.postIdValue}/comments?limit=${self.limit}&offset=${self.offset}`

    fetch(url)
      .then((response) => response.text())
      .then(response_data => {

        response_data = response_data.trim()

        if (response_data.length === 0) {
          event.target.textContent = "No more comments"
          event.target.disabled = true
          return
        }

        document.getElementById(this.commentsListIdValue).innerHTML += response_data

      })

    self.offset += self.limit
  }
}
