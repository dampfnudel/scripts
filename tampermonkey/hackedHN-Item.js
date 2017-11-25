// ==UserScript==
// @name         HN items
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://news.ycombinator.com/item?id=*
// @grant        none
// ==/UserScript==
/* jshint -W097 */
'use strict';

// Your code here...
function addGlobalStyle(css) {
    var head, style;
    head = document.getElementsByTagName('head')[0];
    if (!head) { return; }
    style = document.createElement('style');
    style.type = 'text/css';
    style.innerHTML = css;
    head.appendChild(style);
}

addGlobalStyle('body { zoom: 2.5 }');
addGlobalStyle('td { max-width: 560px }');
