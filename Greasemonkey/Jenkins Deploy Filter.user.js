// ==UserScript==
// @name      Jenkins Deploy Filter
// @namespace sps
// @include   https://dev-deploy.jenkins.svc.spsdev.in/*
// @include   https://test-deploy.jenkins.svc.spstest.in/*
// @include   https://stage-deploy.jenkins.svc.spsstage.in/*
// @include   https://prod-deploy.jenkins.svc.spsprod.in/*
// @version   1
// @grant     none
// ==/UserScript==

const projects = [
      'promote-ecr-image-generic',
        'company-setup',
        'daily-reports',
        'minivan-api',
        'poc-reset',
        'tnc-setup',
        'webforms-api',
        'xref-api',
    ]
    , regex = new RegExp(`(${projects.join('|')})`)
    , table = document.getElementById('projectstatus');

for (const tr of table.querySelectorAll('tr')) {
    if (tr.id && !tr.id.match(regex)) {
        tr.remove();
    }
}
