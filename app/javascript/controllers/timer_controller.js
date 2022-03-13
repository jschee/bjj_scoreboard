import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  initialize() {
    this.state= 0
  }

  connect() {
    this.clock= document.querySelector("#timer")
  }

  updateTimer(event) {
    event.preventDefault();
    if (this.state === 0) {
      let params = event.params
      post(`${params.url}`, {
        body: { result: params.result,
                time: params.time
              },
        contentType: "application/json"
      })
      document.querySelector('#play').disabled = false
    } else {
      return
    }
  }

  play() {
    this.state= 1 //= make it stoppable
    document.querySelectorAll('.timer-actions').forEach( function(el) {
      el.disabled = true
    }) //= timer actions are disabled
    let time = document.querySelector("#timer").textContent.replace(/\s/g, '')
    let min = time.split(':')[0];
    let sec = time.split(':')[1];
    console.log(min + ':' + sec)
    console.log(min)

    var totalMs = this.convertToMs(min, sec)
    var startTime = new Date();
    startTime.toISOString();
    let timer = document.getElementById('timer')
    this.countDown(startTime,
                   totalMs,
                   () => { timer.textContent = 'done'; },
                   (x) =>{ timer.textContent = this.convertToClock(x) },
                   200)
  }


  countDown(startTime, remainingTime, onComplete, onUpdate, delay = 1000) {
    let timer;
    startTime = new Date(startTime);
    function next() {
      const runningTime = new Date().getTime() - startTime;
      let remaining = Math.max(remainingTime - runningTime, 0);
      onUpdate && onUpdate(remaining);
      !remaining && onComplete && onComplete();
      var ms = Math.min(delay, remaining);
      timer = remaining && window.setTimeout(next, ms);
    }

    next()

    return function () {
      timer && window.clearTimeout(timer);
    }

  }




  stop(event) {
    this.state= 0

    let time = document.querySelector("#timer").textContent.replace(/\s/g, '')
    let min = time.split(':')[0];
    let sec = time.split(':')[1];
    let newStartTime = this.convertToMs(min, sec)
    let params = event.params

    post(`${params.url}`, {
      body: { time: newStartTime },
      contentType: "application/json"
    })
  }

  restart(event) {
    this.state= 0

    let params = event.params
    let newStartTime = "0"
    post(`${params.url}`, {
      body: { time: newStartTime },
      contentType: "application/json"
    })
  }

  checkForTime(){
    if (this.clock.textContent.includes('00:00')) {
      document.querySelectorAll('.play-actions').forEach( function(el) {
        el.disabled = true
      })
    }
  }

  convertToMs(min, sec) {
    let newMin = min * 60000
    let newSec = sec * 1000
    let startTime = newMin + newSec
    return startTime
  }

  convertToClock(ms) {
    let date = new Date(ms);
    let m = date.getMinutes();
    let s = date.getSeconds();
    if (s < 10) { s = `0${s}` }
    return `${m}:${s}`
  }


  startTimer() {

  }

}
