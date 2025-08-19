# The Virtual Atelier: Interactive 3D Fashion Showroom
This is an interactive 3D fashion showroom built with the [Anigraph](https://www.cs.cornell.edu/courses/cs4620/2023fa/assignments/docs/assignments/c1/anigraph/) package. You can walk through the showroom, view clothing items, and express reactions. Anigraph is not publicly available, so this repository includes only the deployment code, not the full source.

## Demo
![example](recordings/example.gif)


## Requirements
- Python 3.9+
- taichi >= 1.7
- pywavefront
- numpy

---
## How to Run

1. Clone this repo and open a terminal in the project folder.

2. Install dependencies:
    ```
    pip install -r requirements.txt
    ```
    or
    ```
    pip install taichi pywavefront numpy
    ```

3.  Run the simulator:
    ```
    python skirt.py
    ```
### Interactive Controls
- ← / → Orbit camera (rotate around the skirt)
- ↑ / ↓ Zoom in/out
- Use the GUI panel to switch fabric and seam type
- Toggle “Highlight Side Seam” to visualize the side seam
- Click “Stop simulation” to quit
