// ==UserScript==
// @name        ec2metadata
// @namespace   sps
// @include     http://169.254.169.254/
// @version     2
// @grant       none
// ==/UserScript==

const roles = {
    'AppName': 'foo/foo-bar-baz-role-AJS8KSH21AS',
};

const list = document.getElementById('roles');
list.innerHTML = '';

for (const appName of Object.keys(roles)) {
    const rolePath = roles[appName],
          roleEl   = document.createElement('option');
    roleEl.setAttribute('value', `arn:aws:iam::0123456789:role/app/${rolePath}`);
    roleEl.innerHTML = appName;
    list.appendChild(roleEl);
}
