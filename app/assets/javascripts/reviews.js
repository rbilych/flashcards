startTimer = function(){
  var time = 0;

  if (typeof timer !== "undefined") clearInterval(timer);

  timer = setInterval(function() {
    time++;
    $("#time").val(time);
  }, 1000);
}

$(function() {
  startTimer();
});
