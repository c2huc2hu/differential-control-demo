# charting.coffee

console.log "charting"

ctx = $('#chart').get(0).getContext('2d')
window.ctx = ctx

colors = ['#890000', '#ae3d00', '#ba9600', '#3b5828', '#014c63', '#18121e', '#233237', '#984b43', '#eac67a', '#7a327e']
curColor = colors.pop()
pointCounter = 0

updateChart = (data) ->
    ctx.beginPath()
    ctx.strokeStyle = curColor or 'blue'
    for i in data
        ctx.lineTo i.x * 100 + 200, i.y * 100 + 200
        # ctx.lineTo i.x * 50, -i.y * 50 + 200, 3, 3 # for plotting from 0 to 2pi
    ctx.stroke()

plot = (fcn) ->
    ctx.beginPath()
    ctx.fillStyle = 'grey'
    for x in [0..400]
        y = fcn(x / 100 - 2) * 100 + 200
        # y = -fcn(x / 50) * 50 + 200 # for plotting from 0 to 2pi
        ctx.rect x, y, 3, 3
    ctx.fill()
# plot (x) -> 0.5 * Math.sin x

setInterval ->
    updateChart window.robot.history
    window.robot.history = []
, 200

$('#reset').click ->
    curColor = colors.pop()
    window.robot.history = []
    ctx.moveTo(-100, -100)