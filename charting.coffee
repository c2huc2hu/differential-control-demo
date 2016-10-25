# charting.coffee

console.log "charting"

ctx = $('#chart').get(0).getContext('2d')
window.ctx = ctx

updateChart = (data) ->
    ctx.beginPath()
    ctx.fillStyle = 'black'
    for i in data
        ctx.rect i.x * 100 + 200, i.y * 100 + 200, 1, 1
    ctx.fill()

plot = (fcn) ->
    ctx.beginPath()
    ctx.fillStyle = 'red'
    for x in [0..400]
        y = fcn(x / 100 - 2) * 100 + 200
        ctx.rect x, y, 1, 1
    ctx.fill()

plot (x) -> 0.5 * Math.sin x

setInterval ->
    console.log window.robot.history.length
    updateChart window.robot.history
    window.robot.history = []
, 1000
