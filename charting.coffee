# charting.coffee

console.log "charting"

ctx = $('#chart').get(0).getContext('2d')
window.ctx = ctx

setPixelBlack = do ->
    imageData = ctx.createImageData(1, 1)
    d = imageData.data
    d[0] = d[1] = d[2] = 80
    (x, y) ->
        console.log x, y
        ctx.putImageData(imageData, x, y)

updateChart = (data) ->
    console.log w
    for i in data
        ctx.rect i.x * 100 + 200, i.y * 100 + 200, 1, 1
    ctx.fill()

setInterval ->
    console.log window.robot.history.length
    updateChart window.robot.history
    window.robot.history = []
, 1000
