/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav" || x.className === "top-nav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}