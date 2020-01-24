-- define icon folder directory
local dir = os.getenv('HOME') .. '/.config/awesome/icons/'

-- return icons
return {
  leftarrow = dir .. 'left-arrow.svg',
  rightarrow = dir .. 'right-arrow.svg'
}