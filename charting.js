// Generated by CoffeeScript 1.10.0
(function() {
  var ctx, setPixelBlack, updateChart;

  console.log("charting");

  ctx = $('#chart').get(0).getContext('2d');

  window.ctx = ctx;

  setPixelBlack = (function() {
    var d, imageData;
    imageData = ctx.createImageData(1, 1);
    d = imageData.data;
    d[0] = d[1] = d[2] = 80;
    return function(x, y) {
      console.log(x, y);
      return ctx.putImageData(imageData, x, y);
    };
  })();

  updateChart = function(data) {
    var i, j, len;
    console.log(w);
    for (j = 0, len = data.length; j < len; j++) {
      i = data[j];
      ctx.rect(i.x * 100 + 200, i.y * 100 + 200, 1, 1);
    }
    return ctx.fill();
  };

  setInterval(function() {
    console.log(window.robot.history.length);
    updateChart(window.robot.history);
    return window.robot.history = [];
  }, 1000);

}).call(this);
