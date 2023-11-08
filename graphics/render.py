import os
import math
from time import sleep
import numpy as np
import random


BROWN='\033[0;33m'
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
LPURPLE='\033[1;35m'
NC='\033[0m' # No Color

# edge and background material
edgeChar = '█'
background = ' '

# return matrix filled with c
def makeScreen(w, h, c):
  return [[c] * w for _ in range(h)]

# clear terminal
def clear():
  if (os.name == 'posix'):
    os.system('clear')
  else:
    os.system('cls')

# render screen
def renderScreen(screen):
  clear()
  print('\n'.join([''.join(r) for r in screen]))

eyePos = np.array([0.0, 0.0, 1.0])

class Sphere:
   center = np.array([0.0, 0.0, 0.0])
   diffuse = np.array([0.0, 0.0, 0.0])
   radius = 1.0
   colour = NC

   def __init__(self, center, diffuse, radius, colour = NC):
      self.center = center
      self.diffuse = diffuse
      self.radius = radius
      self.colour = colour
   
   def intersects(self, ray_origin, ray_direction):
      b = 2 * np.dot(ray_direction, ray_origin - self.center)
      c = np.linalg.norm(ray_origin - self.center) ** 2 - self.radius ** 2
      
      delta = b ** 2 - 4 * c
      
      if delta > 0:
         t1 = (-b + np.sqrt(delta)) / 2
         t2 = (-b - np.sqrt(delta)) / 2
         if t1 > 0 and t2 > 0:
            return min(t1, t2)
      return None
   
   def surface_normal(self, intersection):
      return normalize(intersection - self.center)
      
class Tri:
   A = np.array([0.0, 0.0, 0.0])
   B = np.array([0.0, 0.0, 0.0])
   C = np.array([0.0, 0.0, 0.0])
   diffuse = np.array([0.0, 0.0, 0.0])
   normal = np.array([0.0, 0.0, 0.0])

   colour = NC

   def __init__(self, A, B, C, colour = NC):
      self.A = A
      self.B = B
      self.C = C
      self.colour = colour

   # With help from https://diegoinacio.github.io/creative-coding-notebooks-page/pages/ray-intersection_triangle.html
   def intersects(self, ray_origin, ray_direction):
      AB = self.B - self.A
      AC = self.C - self.A

      normal = np.cross(AB, AC)
      normalized_normal = normalize(normal)
      self.normal = normalized_normal

      d = np.dot(normalized_normal, self.A)
      
      t = - (np.dot(normalized_normal, ray_origin) + d)/np.dot(normalized_normal, ray_direction) # eqn of line

      point_in_triangle = ray_origin + t * ray_direction # parametric eqn
      
      Pa = np.dot(np.cross(self.B - self.A, point_in_triangle - self.A), normalized_normal)
      Pb = np.dot(np.cross(self.C - self.B, point_in_triangle - self.B), normalized_normal)
      Pc = np.dot(np.cross(self.A - self.C, point_in_triangle - self.C), normalized_normal)

      if(t < 0):
        # Means that the triangle has the normal in the opposite direction (same
        # direction from the ray) or the triangle is behind the ray origin
        # cull
         return None
      elif(Pa < 0 and Pb < 0 and Pc < 0):
         # point is outside triangle
         return None
      else:
         # intersect at point_in_triangle
         # find the distance and return
         dx = point_in_triangle[0] - ray_origin[0]
         dy = point_in_triangle[1] - ray_origin[1]
         dz = point_in_triangle[2] - ray_origin[2]
         distance = np.sqrt((dx ** 2) + (dy ** 2) + (dz ** 2))
         return distance
      
   
   def surface_normal(self, intersection):
      return self.normal
      
      
objects = [
    Sphere(np.array([-0.2, 0, -1]), np.array([1, 1, 1]),0.3),
    Sphere(np.array([-0.4, 0.05, 0.3]), np.array([1, 1, 1]), 0.15),
    Sphere(np.array([0.15, 0.05, 0.1]), np.array([1, 1, 1]), 0.1 ),
    Sphere(np.array([0.6, -1.5, -3.0]), np.array([1, 1, 1]), 1.5 ),
   #  Tri(np.array([-0.01, 0.01, 0.01]), np.array([0.1, 0.1, 0.1]), np.array([0.01, -0.01, -0.01])),
]

light = { 'position': np.array([-20, 5, 5]), 'ambient': np.array([1, 1, 1]), 'diffuse': np.array([1, 1, 1]), 'specular': np.array([1, 1, 1]) }

def sphere_intersect(center, radius, ray_origin, ray_direction):
  b = 2 * np.dot(ray_direction, ray_origin - center)
  c = np.linalg.norm(ray_origin - center) ** 2 - radius ** 2

  delta = b ** 2 - 4 * c

  if delta > 0:
    t1 = (-b + np.sqrt(delta)) / 2
    t2 = (-b - np.sqrt(delta)) / 2
    if t1 > 0 and t2 > 0:
      return min(t1, t2)
  return None


def nearest_intersected_object(objects, ray_origin, ray_direction):
    distances = [obj.intersects(ray_origin, ray_direction) for obj in objects]
    nearest_object = None
    min_distance = np.inf
    for index, distance in enumerate(distances):
        if distance and distance < min_distance:
            min_distance = distance
            nearest_object = objects[index]
    return nearest_object, min_distance

def normalize(vector):
    return vector / np.linalg.norm(vector)

def trace():
  # get terminal size
  size = os.get_terminal_size()
  width = size.columns
  height = size.lines
        
  ratio = float(width) / height
  screen = (-1, 1/ ratio, 1, -1 / ratio) # left top right bottom

  image = np.full((height, width), background)

  for i, y in enumerate(np.linspace(screen[1], screen[3], height)):
    for j, x in enumerate(np.linspace(screen[0], screen[2], width)):
        pixel = np.array([x, y, 0])
        direction = normalize(pixel - eyePos)
        
        # check intersections
        nearest_object, min_distance = nearest_intersected_object(objects, eyePos, direction)
        if nearest_object is None:
            continue

        # compute intersection point between ray and nearest object
        intersection = eyePos + min_distance * direction
        
        surface_normal = nearest_object.surface_normal(intersection)

        shifted_point = intersection + 1e-5 * surface_normal

        intersection_to_light = normalize(light['position'] - shifted_point)

        _, min_distance = nearest_intersected_object(objects, shifted_point, intersection_to_light)

        intersection_to_light_distance = np.linalg.norm(light['position'] - intersection)
        
        illumination = np.zeros((3))

        illumination += nearest_object.diffuse * light['diffuse'] * np.dot(intersection_to_light, surface_normal)

        #specular
        # intersection_to_camera = normalize(eyePos - intersection)
        # H = normalize(intersection_to_light + intersection_to_camera)
        # illumination += nearest_object['specular'] * light['specular'] * np.dot(surface_normal, H) ** (nearest_object['shininess'] / 4)

        finalColor = edgeChar

        if min_distance < intersection_to_light_distance: # shadowed
           finalColor = '.'
        elif illumination[0] < 0.02:
           finalColor = '-'
        elif(illumination[0] < 0.05):
           finalColor = ':'
        elif(illumination[0] < 0.10):
           finalColor = '='
        elif(illumination[0] < 0.20):
           finalColor = '+'
        elif(illumination[0] < 0.30):
           finalColor = '*'
        elif(illumination[0] < 0.40):
           finalColor = '%'
        elif(illumination[0] < 0.50):
           finalColor = '@'
        elif(illumination[0] < 0.55):
           finalColor = '#'
        elif(illumination[0] < 0.70):
           finalColor = '░'
        elif(illumination[0] < 0.9):
           finalColor = '▒'
        elif(illumination[0] < 0.995):
           finalColor = '▓'

        image[i, j] = finalColor

  return image

def moveObjects():
   for object in objects:
      object.center[0] = object.center[0] + 0.01 
      print(f'object center is {object.center[0]}')

def moveLights():
   offset = 1 #random.randint(-1, 1)

   light['position'][0] = light['position'][0] + offset
   
   if(light['position'][0] > 23):
      light['position'][0] = -20
  #  offsetz = random.randint(-1, 1)
  #  light['position'][2] = light['position'][2] + offset
   print(f'light center is {light["position"][0]}') # todo max

def moveCam():
   offset = 0.01 #random.randint(-1, 1)

   eyePos[0] = eyePos[0] + offset
   
   if(eyePos[0] > 1.0):
      eyePos[0] = 0.0
  #  offsetz = random.randint(-1, 1)
  #  light['position'][2] = light['position'][2] + offset
   print(f'eye is at {eyePos[0]}') # todo max
# update loop
t = 0
while True:

  # update time step
  sleep(0.0001)
  t += 0.1

  image = trace()
  renderScreen(image)
  # moveObjects()
  moveLights()
  moveCam()
