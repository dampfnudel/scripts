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
  setInterval(function() {
    document.querySelectorAll('#x-auto-23 > tbody > tr:nth-child(2) > td.x-btn-mc > em > button')[0].click();
    setTimeout(function(){
      document.title = document.querySelectorAll('#x-auto-75')[0].innerText.substring(21, 26);
    }, 2000);
  }, 60 * 1000);
})();
