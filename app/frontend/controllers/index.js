// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
// 會匯入 _controller 底下的 js 檔案
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
