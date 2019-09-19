GameOjectAnimable = Class {}

function GameOjectAnimable:init(def)
    self.x = def.x
    self.y = def.y
    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.solid = def.solid
    self.collidable = def.collidable
    self.consumable = def.consumable
    self.onCollide = def.onCollide
    self.onConsume = def.onConsume
    self.hit = def.hit

    self.animationFrames = def.animationFrames
    self.animation = Animation {
        frames = sef.animationFrames, 
        interval = 0.56
    }

    self.currentAnimation  = def.animationFrames
    self.currentFrame = self.animationFrames[0]
end

function GameOjectAnimable:collide (target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width or 
    target.y > self.y + self.height or self.y > target.y + target.height)
end 

function GameOjectAnimable:update(dt)
    self.currentAnimation:update(dt)
end

function GameOjectAnimable:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrames()], self.x, self.y)
end 