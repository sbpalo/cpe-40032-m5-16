PlayerAnimationState = Class {_includes = BaseState}

function PlayerAnimationState:init(player, gravity)

    self.player = player
    self.gravity = gravity
    self.animation = {
        frames = {3},
        interval = 1
    }
    self.player.currentAnimation = self.animation
end

function PlayerAnimationState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy+ self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    --look at two tiles below and check for collision

    local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

    --
    if (tileBottomLeft and tileBottomRight) and (tileBottomRight:collidable() or tileBottomLeft:collidable()) then

        if (self.animation.frames ~= {10, 11}) then
            self.animation = Animation {
                frames = {10, 11},
                interval = 1
            }

            self.player.currentAnimation = self.animation
        end

        self.player.dy = 0

        self.player.y = (tileBottomLeft.y -1) * TILE_SIZE - self.player.height
        self.player.x = self.player.x +PLAYER_WALK_SPEED * dt
        self.gravity = 1

        self.player.win = true

        Timer.after (3, function ()
            gStateMachine:change('play')
        end)
    end
end 