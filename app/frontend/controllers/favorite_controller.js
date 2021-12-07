import { Controller } from "stimulus"
import httpClient from "lib/http/client"

export default class extends Controller {
  static targets = ["btn"]

  connect(){
    if(this.btnTarget.dataset.liked === "true"){
      this.btnTarget.classList.add("favorited")
    }
  }

  like() {
    const courseID = this.btnTarget.dataset.id
    const likeBtn = this.btnTarget
    console.log(courseID)

    httpClient.post(`/api/v1/courses/${courseID}/like`).then(({ data }) => {
      if (data.result === "like") {
        likeBtn.classList.add("favorited")
      } else {
        likeBtn.classList.remove("favorited")
      }
    })
  }
}
