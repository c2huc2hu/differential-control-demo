h = 0.001
L = 0.1
window.headToOrigin = true

class Robot
    constructor: (@L, @canvasObj) ->
        @randomizePosition()
        @render()
    randomizePosition: ->
        @x = Math.random() * 4 - 2
        @y = Math.random() * 4 - 2
        @theta = Math.random() * 2 * Math.PI
    update: (speed, angle) ->
        @x += speed * Math.cos(@theta) * h
        @y += speed * Math.sin(@theta) * h
        @theta += angle
    render: ->
        drawLeft = @x * 100 + 200
        drawTop = @y * 100 + 200
        @canvasObj
            .setAngle(@theta * 180 / Math.PI)
            .set {originX: 'center', originY: 'center', left: drawLeft, top: drawTop}
        canvas.renderAll()

class ControlledRobot extends Robot
    constructor: (@L, @canvasObj, @distControl, @targetControl, @alignControl) ->
        @history = []
        super @L, @canvasObj
    update: (goalX, goalY, goalTheta) ->
        # want to regulate rho, alpha and beta to zero.
        dist = Math.sqrt((@x-goalX)**2+(@y-goalY)**2) # rho
        directionToGoal = Math.atan (goalY-@y) / (goalX-@x)
        targetHeading = directionToGoal - @theta # alpha
        alignHeading = directionToGoal - goalTheta # beta

        @history.push {@x, @y, @theta}
        super @distControl * dist, @targetControl * targetHeading + @alignControl * alignHeading
    followPath: (pathFcn) ->
        anticipation = 0.1 # how much to trail the target point
        desiredX = @x + anticipation
        desiredY = pathFcn(desiredX)
        desiredTheta = Math.atan2 (desiredY - @y), (desiredX - @x)
        @update desiredX, desiredY, desiredTheta

canvas = new fabric.Canvas('cvs')
    .setHeight 400
    .setWidth 400

target =
    x: 0
    y: 0
    angle: -Math.PI / 2

rect = new fabric.Rect({width:30, height: 20})
eye = new fabric.Circle({left: target.x*100+200-10, top: target.y*100+200-10, radius: 10, fill: 'crimson'})
eye2 = new fabric.Circle({left: target.x*100+200-5, top: target.y*100+200-5, radius: 5, fill: 'black'})
canvas.add(rect, eye, eye2)
robot = new ControlledRobot(L, rect, 5, 0.1, 0.1)

setInterval ->
    if headToOrigin
        robot.update(target.x, target.y, target.angle)
    else
        robot.followPath (x) -> 0.5 * Math.sin(x)
    robot.render()
, 16

$('#reset').click -> robot.randomizePosition()
$('#toggle').click -> window.headToOrigin = not window.headToOrigin

window.robot = robot