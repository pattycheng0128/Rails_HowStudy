// 用 stimulus 框架改寫
// 用 "DOMContentLoaded" 監聽事件只會跑一次，要改成用 turbolinks:load

// import httpClient from "lib/http/client"

// document.addEventListener("turbolinks:load", () => {
//   const likeBtn = document.querySelector("#like-btn")

//   if (likeBtn) {
//     likeBtn.addEventListener("click", () => {
//       const courseID = likeBtn.dataset.id

//       httpClient.post(`/api/v1/courses/${courseID}/like`).then(({ data }) => {
//         if (data.result === "like") {
//           likeBtn.classList.add("favorited")
//         } else {
//           likeBtn.classList.remove("favorited")
//         }
//       })
//     })
//   }
// })