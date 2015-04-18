require 'gosu'

class WhackARuby < Gosu::Window
	def initialize
		@window_width = 800
		@window_height = 600
		super @window_width, @window_height, false
		self.caption = "Whack the Ruby!"
		@image = Gosu::Image.new(self, 'ruby.png', false)
		@x = 200
		@y = 200
		@width = 50
		@height = 43
		@velocity_x = 5
		@velocity_y = 5
		@visible = 0
		@hammer_image = Gosu::Image.new(self, 'hammer.png', false)
		@hit = 0
	end

	def update
		@x += @velocity_x
		@y += @velocity_y

		if @x + @width/2 > @window_width or @x - @width/2 < 0
			@velocity_x *= -1
		end

		if @y + @height/2 > @window_height or @y - @height/2 < 0
			@velocity_y *= -1
		end

		@visible -= 1
		if @visible < -10 and rand < 0.01
			@visible = 30
		end
	end

	def button_down(id)
		if (id == Gosu::MsLeft)
			if Gosu.distance(mouse_x, mouse_y, @x, @y)<50 and @visible >= 0
				@hit = 1
			else
				@hit = -1
			end
		end
	end

	def draw
		if @visible > 0
			@image.draw(@x - @width/2, @y - @height/2, 1)
		end

		@hammer_image.draw(mouse_x-40, mouse_y-10, 1)

		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end

		draw_quad(0, 0, c, @window_width, 0, c, @window_width, @window_height, c, 0, @window_height, c)
		@hit = 0
	end

end

window = WhackARuby.new
window.show