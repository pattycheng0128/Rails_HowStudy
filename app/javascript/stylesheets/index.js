import "./courses.scss"
import "./reviews.scss"

import axios from "axios"

document.addEventListener("turbolinks:load",
() => {

  var likeButton = document.querySelector("#like_btn");
  // likeButton 存在，才做監聽
  // 可以寫成 likeButton && ，if 可以拿掉
  if(likeButton){
    likeButton.addEventListener("click", () => {
    axios.get("https://randomuser.me/api/?results=10")
    .then(({data}) => {
      let results = data.results;
      console.log(results);
      results.forEach((u) => {
        console.log(u.email);
      })
    })
  })
  }
})