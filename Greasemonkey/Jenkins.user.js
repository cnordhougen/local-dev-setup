// ==UserScript==
// @name        Jenkins
// @namespace   sps
// @include     https://intapps.jenkins.svc.spsdev.in/*
// @include     https://dev-deploy.jenkins.svc.spsdev.in/*
// @include     https://test-deploy.jenkins.svc.spstest.in/*
// @include     https://stage-deploy.jenkins.svc.spsstage.in/*
// @include     https://prod-deploy.jenkins.svc.spsprod.in/*
// @version     1
// @grant       none
// ==/UserScript==

const container = document.createElement('div')
    , links     = [
        {
            label: 'Intapps',
            url:   'https://intapps.jenkins.svc.spsdev.in/',
        }, {
            label: 'Dev Deploy',
            url:   'https://dev-deploy.jenkins.svc.spsdev.in/'
        }, {
            label: 'Test Deploy',
            url:   'https://test-deploy.jenkins.svc.spstest.in/'
        }, {
            label: 'Stage Deploy',
            url:   'https://stage-deploy.jenkins.svc.spsstage.in/'
        }, {
            label: 'Prod Deploy',
            url:   'https://prod-deploy.jenkins.svc.spsprod.in/'
        }
    ];

document.getElementById('header').appendChild(container);
container.style.position = 'absolute';
container.style.left = '200px';
container.style.padding = '10px 0';

links.forEach((link, i) => {
    const a = document.createElement('a');
    a.setAttribute('href', link.url);
    a.setAttribute('rel', 'noopener noreferrer');
    a.setAttribute('target', '_parent');
    a.innerHTML = link.label;
    container.appendChild(a);
    a.style.padding = '5px';
    a.style.color = 'white';
});
