import "./courses.scss"
import "./reviews.scss"

// import axios from "axios"

// document.addEventListener("turbolinks:load",
// () => {

//   var likeButton = document.querySelector("#like_btn");
//   // likeButton 存在，才做監聽
//   // 可以寫成 likeButton && ，if 可以拿掉
//   if(likeButton){
//     likeButton.addEventListener("click", () => {
//       const token = document.querySelector("meta[name=csrf-token]").content;
//       // console.log(token);
//       axios.defaults.headers.common["X-CSRF-Token"] = token;

//       axios.post("/api/v1/courses/20/like").then(({resp}) => {
//         console.log(resp);
//     })
//   })
//   }
// })