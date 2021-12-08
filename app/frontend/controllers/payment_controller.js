import { Controller } from "stimulus"
import dropin from "braintree-web-drop-in"

export default class extends Controller {
  static values = {
    token: String, //token是一組字串
  }
  static targets = ["dropin", "nonce"] //對應 view 的data-payment-target

  connect(){
    //console.log(this.element.parentNode) 取得目前元素的上一層節點
    const form = this.element.parentNode
    dropin.create({
      container: this.dropinTarget,
      authorization: this.tokenValue,
      // ...plus remaining configuration
    }).then((dropinInstance) => {
      form.addEventListener('submit', (e) => {
        e.preventDefault();
        dropinInstance.requestPaymentMethod().then(({nonce}) => {
          this.nonceTarget.value = nonce
          form.submit()
        }).catch((error) => {throw error;})
      })
      
    }).catch((error) => {
      console.log("error:", error)
    });
  }

}
