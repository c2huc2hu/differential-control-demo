h = 0.1

class Robot
	constructor: (@L, @canvasObj) ->
		@randomizePosition()
		@render()

	randomizePosition: ->
		@x = Math.random() * 600
		@y = Math.random() * 400
		@theta = Math.random() * 2 * Math.PI

	update: (controlV, controlGamma) ->
		@x += controlV * Math.cos(@theta) * Math.cos(controlGamma) * h
		@y += controlV * Math.sin(@theta) * Math.cos(controlGamma) * h
		@theta += Math.atan2(Math.sin(controlV * controlGamma), @L) * h

	render: ->
		@canvasObj
			.setAngle(@theta * 180 / Math.PI)
			.set {originX: 'center', originY: 'center', left: @x, top: @y}
		canvas.renderAll()

class ControlledRobot extends Robot
	constructor: (@L, @canvasObj, @vPropControl, @gammaPropControl) ->
		super @L, @canvasObj

	update: (goalX, goalY) ->
		controlV = @vPropControl * Math.sqrt((@x-goalX)**2+(@y-goalY)**2)
		desiredDirection = Math.atan2 (goalY-@y), (goalX-@x)
		controlGamma = -@gammaPropControl * ((@theta - desiredDirection) % (2*Math.PI))
		super controlV, controlGamma

canvas = new fabric.Canvas('cvs')
	.setHeight 400
	.setWidth 600

rect = new fabric.Rect({width:30, height: 20})
target = new fabric.Circle({left: 90, top: 90, radius: 10, fill: 'crimson'})
target2 = new fabric.Circle({left: 95, top: 95, radius: 5, fill: 'black'})
robot = new ControlledRobot(1, rect, 0.05, 0.1)
canvas.add(rect, target, target2)

setInterval ->
	robot.update(100, 100)
	robot.render()
	# 	console.log "updating!", robot.x, robot.y, robot.theta
, 16

$('#reset').click -> robot.randomizePosition()
