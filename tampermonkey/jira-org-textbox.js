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
    var refElement = document.getElementById('stalker');
    var textarea1 = document.createElement('TEXTAREA');
    var buttonCopyTextarea1 = document.createElement('BUTTON');
    var textarea2 = document.createElement('TEXTAREA');
    var buttonCopyTextarea2 = document.createElement('BUTTON');

    var ticketId = document.getElementById('key-val').textContent.trim();
    var url = document.getElementById('key-val').href;
    var title = document.getElementById('summary-val').textContent.trim();
    var description = document.getElementsByClassName('user-content-block')[0].textContent.trim();
    // dupes
    // document.querySelector('.links-container span')

    parent.insertBefore(textarea1, refElement);
    // textarea1.value = '** ' + ticketId + ' ' + title + '\n' + url + '\n' + description;
    textarea1.value = '** [[' + url + '][' + ticketId + ' ' + title + ']]\n' + description;
    // textarea1.classList.add('textarea long-field wiki-textfield mentionable wiki-editor-initialised wiki-edit-wrapped richeditor-cover');
    textarea1.style.width = '850px';
    textarea1.setAttribute('rows', 4);
    // textarea1.select();
    // textarea1.focus();
    parent.insertBefore(buttonCopyTextarea1, refElement);
    buttonCopyTextarea1.innerHTML = 'Copy';
    buttonCopyTextarea1.classList.add('aui-button');
    buttonCopyTextarea1.style.cursor = 'pointer';
    buttonCopyTextarea1.style.margin = '1rem';
    buttonCopyTextarea1.focus();
    buttonCopyTextarea1.onclick = function () {
        textarea1.select();
        textarea1.setSelectionRange(0, 99999); /*For mobile devices*/
        document.execCommand('copy');
    };
    parent.insertBefore(textarea2, refElement);
    textarea2.value = '** ' + ticketId + ' ' + title + '\n' + url + '\n';
    // textarea2.classList.add('textarea long-field wiki-textfield mentionable wiki-editor-initialised wiki-edit-wrapped richeditor-cover');
    textarea2.style.width = '850px';
    textarea2.setAttribute('rows', 4);
    // textarea2.select();
    // textarea2.focus();
    parent.insertBefore(buttonCopyTextarea2, refElement);
    buttonCopyTextarea2.innerHTML = 'Copy';
    buttonCopyTextarea2.classList.add('aui-button');
    buttonCopyTextarea2.style.cursor = 'pointer';
    buttonCopyTextarea2.style.margin = '1rem';
    buttonCopyTextarea2.onclick = function () {
        textarea2.select();
        textarea2.setSelectionRange(0, 99999); /*For mobile devices*/
        document.execCommand('copy');
    };
})();
