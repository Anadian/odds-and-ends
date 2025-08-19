#!/usr/bin/env node
//var basetime = Date.now();
var basetime = Number.MAX_SAFE_INTEGER;
//var basetime = 2**64
var seconds = basetime/1000;
var minutes = seconds/60;
var hours = minutes/60;
var days = hours/24;
var years = days/365.25;
console.log(years);
