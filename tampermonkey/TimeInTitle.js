// ==UserScript==
// @name         TimeInTitle
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  time in title
// @author       You
// @match        https://poms2.tomcom.de/
// @grant        none
// ==/UserScript==

(function (workload) {
  'use strict';
  function userInteraction () {
    var windows = document.querySelectorAll('.x-window');
    if (windows.length > 0) return true;
    return false;
  }
  function doneAt (currentHours, currentMinutes) {
    var minutes = currentHours * 60 + currentMinutes;
    var left = workload - minutes;
    var d1 = new Date (),
      d2 = new Date (d1);
    d2.setMinutes (d1.getMinutes() + left);
    return d2.toLocaleTimeString();
  }
  function time2title () {
    var timeRegex = /([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]/;
    if (userInteraction()) return;
    document.querySelectorAll('#x-auto-23 > tbody > tr:nth-child(2) > td.x-btn-mc > em > button')[0].click();
    setTimeout(function () {
      var hoursStr = document.querySelectorAll('#x-auto-75')[0].innerText;
      var parsed = hoursStr.match(timeRegex)[0];
      var parts = parsed.split(':');
      var hours = parseInt(parts[0]);
      var minutes = parseInt(parts[1]);

      document.title = parsed + ' --|> ' + doneAt(hours, minutes);
    }, 2000);
  }
  setInterval(time2title, 60 * 1000);
})(450);
