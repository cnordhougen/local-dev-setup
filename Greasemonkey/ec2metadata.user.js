// ==UserScript==
// @name        ec2metadata
// @namespace   sps
// @include     http://169.254.169.254/
// @version     1
// @grant       none
// ==/UserScript==

const roles = [
    'arn:aws:iam::0123456789:role/foo/foo-bar-baz-role-AJS8KSH21AS',
];

const list = document.getElementById('roles');
list.innerHTML = '';

for (const role of roles) {
    const roleEl = document.createElement('option');
    roleEl.setAttribute('value', role);
    roleEl.innerHTML = role.match(/role\/(.+)/)[1];
    list.appendChild(roleEl);
}
