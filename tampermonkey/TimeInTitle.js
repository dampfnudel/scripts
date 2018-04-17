// ==UserScript==
// @name         TimeInTitle
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  time in title
// @author       You
// @match        https://poms2.tomcom.de/
// @grant        none
// ==/UserScript==

(function() {
  'use strict';
  var timeRegex = /([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]/;
  setInterval(function() {
    document.querySelectorAll('#x-auto-23 > tbody > tr:nth-child(2) > td.x-btn-mc > em > button')[0].click();
    setTimeout(function(){
      var hoursStr = document.querySelectorAll('#x-auto-75')[0].innerText;
      document.title = hoursStr.match(timeRegex)[0];
    }, 2000);
  }, 60 * 1000);
})();
