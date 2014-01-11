
-- Classes
local Item = require 'entities/item'
local Layer = require 'core/layer'
local WorldLayer = require 'core/world-layer'
local State = require 'core/state'

-- Un état du jeu
local PlayState = State:subclass('PlayState')

-- Démarrage d'un niveau
function PlayState:initialize()

  -- Niveau actuel
  self.level = false
end

-- Démarrage d'un niveau
function PlayState:start(Level)
  -- Démarrage du niveau
  self.level = Level:new()
end

-- Arrêt
function PlayState:stop()
end

-- Mise à jour
function PlayState:update(dt)
  self.level:update(dt)
  
  if core.debug.freeCamera then
    local focus = Vector(
      self.level.map.width * self.level.map.tileWidth * mouse.getX() / screen.w(),
      self.level.map.height * self.level.map.tileHeight * mouse.getY() / screen.h())
    
    -- Limite à gauche
    if focus.x - screen.w() / 2 < 0 then
      focus.x = screen.w() / 2
    end
    
    -- Limite à droite
    if focus.x + screen.w() / 2 > self.level.map.width * self.level.map.tileWidth then
      focus.x = self.level.map.width * self.level.map.tileWidth - screen.w() / 2
    end
    
    -- Limite à gauche
    if focus.y - screen.h() / 2 < 0 then
      focus.y = screen.h() / 2
    end
    
    -- Limite en bas
    if focus.y + screen.h() / 2 > self.level.map.height * self.level.map.tileHeight then
      focus.y = self.level.map.height * self.level.map.tileHeight - screen.h() / 2
    end
    
    game.camera:lookAt(focus.x, focus.y)
    self.level.map:setDrawRange(focus.x - screen.w() / 2, focus.y - screen.h() / 2, screen.w(), screen.h())
  end
end

-- Affichage
function PlayState:draw()
  self.level:draw()
end

return PlayState