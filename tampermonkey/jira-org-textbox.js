// ==UserScript==
// @name         org-ticket-title
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  display a textarea with title, url, description
// @author       You
// @match        https://jira.tomcom.de/browse/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    var parent = document.getElementById('issue-content');
    var newElement = document.createElement('TEXTAREA');
    var refElement = document.getElementById('stalker');
    var button = document.createElement('BUTTON');

    var ticketId = document.getElementById('key-val').textContent.trim();
    var url = document.getElementById('key-val').href;
    var title = document.getElementById('summary-val').textContent.trim();
    var description = document.getElementsByClassName('user-content-block')[0].textContent.trim();
    // dupes
    // document.querySelector('.links-container span')

    parent.insertBefore(newElement, refElement);
    // newElement.value = '** ' + ticketId + ' ' + title + '\n' + url + '\n' + description;
    newElement.value = '** [[' + url + '][' + ticketId + ' ' + title + ']]\n' + description;
    newElement.style['width'] = '850px';
    newElement.setAttribute('rows', 3);
    // newElement.select();
    // newElement.focus();
    parent.insertBefore(button, refElement);
    button.innerHTML = 'Copy';
    button.onclick = function () {
        newElement.select();
        newElement.setSelectionRange(0, 99999); /*For mobile devices*/
        document.execCommand('copy');
    };
})();
