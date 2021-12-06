// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import httpClient from "lib/http/client"

import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "output" ]
  static targets = ["btn"] //對應名稱 data-favorite-target="btn"

  // 對應 view show 畫面，還沒改
  // 聽事件
  // connect(){
  //   if(this.btnTarget.dataset.liked === "true"){
  //     this.btnTarget.classList.add("favorited")
  //   }
  // }

  like() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    // view 那邊要加 target，這樣才能取得標的物
    const courseID = this.btnTarget.dataset.id
    const likeBtn = this.btnTarget

    httpClient.post(`/api/v1/courses/${courseID}/like`).then(({ data }) => {
      if (data.result === "like") {
        likeBtn.classList.add("favorited")
      } else {
        likeBtn.classList.remove("favorited")
      }
    })
  }
}
