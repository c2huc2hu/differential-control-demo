h = 0.1
L = 10

class Robot
	constructor: (@L, @canvasObj) ->
		@randomizePosition()
		@render()
	randomizePosition: ->
		@x = Math.random() * 600
		@y = Math.random() * 400
		@theta = Math.random() * 2 * Math.PI
	update: (speed, angle) ->
		@x += speed * Math.cos(@theta) * Math.cos(angle) * h
		@y += speed * Math.sin(@theta) * Math.cos(angle) * h
		@theta += Math.atan2((Math.sin speed * angle), @L) * h
	render: ->
		@canvasObj
			.setAngle(@theta * 180 / Math.PI)
			.set {originX: 'center', originY: 'center', left: @x, top: @y}
		canvas.renderAll()

class ControlledRobot extends Robot
	constructor: (@L, @canvasObj, @distControl, @targetControl, @alignControl) ->
		super @L, @canvasObj
	update: (goalX, goalY, goalTheta) ->
		# want to regulate rho, alpha and beta to zero.
		dist = Math.sqrt((@x-goalX)**2+(@y-goalY)**2) # rho
		directionToGoal = Math.atan2 (goalY-@y), (goalX-@x)
		targetHeading = directionToGoal - @theta # alpha
		alignHeading = directionToGoal - goalTheta # beta
		super @distControl * dist, @targetControl * targetHeading + @alignControl * alignHeading

canvas = new fabric.Canvas('cvs')
	.setHeight 400
	.setWidth 600

rect = new fabric.Rect({width:30, height: 20})
target = new fabric.Circle({left: 300-10, top: 200-10, radius: 10, fill: 'crimson'})
target2 = new fabric.Circle({left: 300-5, top: 200-5, radius: 5, fill: 'black'})
canvas.add(rect, target, target2)
robot = new ControlledRobot(1, rect, 0.05, 0.1, 0.1)

setInterval ->
	robot.update(300, 200, -Math.PI / 2)
	robot.render()
, 16

$('#reset').click -> robot.randomizePosition()
