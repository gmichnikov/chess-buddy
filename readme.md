## Chess Buddy

Chess Buddy is a ruby implementation of Chess. It allows the user(s) to play Human vs. Human or Human vs. Computer. Users can also watch a Computer vs. Computer game play out.

### How to Run the Code

You must have Ruby installed in order to play this game. 

 code snippets, instructions, and a public API
 You'll want to include an overview of the project as well as code examples illustrating its use.

 Include:

 Link to live site
 A couple sentences to describe the project
 Instructions/how to play (for games)
 How to run the code (for Ruby projects)
 List of techs/languages/plugins/APIs used
 Technical implementation details for anything worth mentioning
 Anything you had to stop and think about before building
 Snippets or links to see code for these (make sure it looks good, no 30 line methods)
 Screenshots of anything related that looks cool (make sure these link to the live site if applicable)
 To-dos/future features
 Also,

 How to get started
 Download the ruby file here
 Unzip the file
 Navigate to the folder in terminal
 Run the command $ bundle install  in the terminal
 Run the command $ ruby chess.rb  to start the game


### MVP

GM-84 Plus will be a browser-based graphing calculator. In addition to giving users the ability to type in an equation and see the graph of that equation, GM-84 Plus will be able to:

- [ ] Identify whether the input is or is not a valid mathematical expression
- [ ] Graph multiple equations at the same time, in different colors
- [ ] Allow users to toggle a given graph on or off
- [ ] Zoom in or Zoom out, using either button or mouse scroll (TBD)
- [ ] Pan in any of the four directions, using either dragging or arrow keys
- [ ] For a list of pre-selected graphs, provide sliders on various coefficients so that users can see how changes to those coefficients affect the graphs (e.g. lines, quadratics, trig)
- [ ] Allow toggle between drawing with animation, or all at once
- [ ] Find the point(s) of intersection of two selected graphs
- [ ] Find the point(s) where a graph cross the x-axis
- [ ] A "trace" feature that allows a user to move the mouse across the canvas

In addition, this project will include:

- [ ] A modal describing how to use the graphing calculator
- [ ] A production README

### Wireframes

This app will consist of a single screen, with the coordinate plane taking up most of the space. There will be an area for entering equations and zooming/panning to the left. Links to the Github, my LinkedIn, and the directions modal will appear at the bottom. Each graph will have a color selector next to it, as well as checkbox for showing/hiding the graph.

![wireframes](https://github.com/gmichnikov/gm-84-plus/blob/master/wireframes/wireframes.001.jpeg)

### Architecture and Technologies

This project will be implemented with the following technologies:

- Vanilla JavaScript and `jQuery` for overall structure and logic,
- `HTML5 Canvas` for rendering of the graphs,
- `Mathquill` for typing/displaying math equation,
- `Math.js` for more advanced math calculations,
- `jQuery` for a slider,
- Webpack to bundle and serve up the various scripts.

In addition to the webpack entry file, there will be three scripts involved in this project:

`graph.js`: will handle rendering the graphs.

`equations.js`: will handle the input and parsing of expressions/equations.

`calculations.js`: will handle elements such as trace, intersections, etc.


### Implementation Timeline

**Day 1**: Download, install, and learn the basics of `Mathquill` and `Math.js`. Create `webpack.config.js` and get webpack up and running. Goals for the day:

- Get a green bundle with `webpack`
- Learn enough `Mathquill` to be able to type in a math expression, identify whether or not it is valid, and graph it in a `Canvas` element if it is valid
- Be able to change the color of the graph and toggle it on and off


**Day 2**: Work on zooming and panning, as well as displaying multiple graphs. Toggle between animated drawing and all-at-once. Implement trace. Goals for the day:

- Be able to seamlessly zoom and pan with any graph
- Be able to pan in any direction on any graph
- Be able to toggle animated drawing on and off
- Be able to click on Trace mode, which then shows x/y values while moving mouse around

- [ ] For a list of pre-selected graphs, provide sliders on various coefficients so that users can see how changes to those coefficients affect the graphs (e.g. lines, quadratics, trig)
- [ ] Find the point(s) of intersection of two selected graphs
- [ ] Find the point(s) where a graph cross the x-axis


**Day 3**: Add pre-selected graphs and make it easy to load them in, along with the associated sliders. Add logic to calculate solutions and intersections of two graphs. Goals for the day:

- Include y = mx + b with sliders for m, b
- Include y = ax^2 + bx + c with sliders for a, b, and c
- Include y = Asin(b(x + c)) with sliders for a, b, and c

**Day 4**: Finish anything that is not complete, and implement bonus features.

### Bonus features

Possible bonus features include:

- [ ] Toggling gridlines on/off
- [ ] Allow the user to enter the window measurements and adjusting accordingly
- [ ] Supporting polar graphs
- [ ] Printing tick marks
- [ ] Local or Absolute min/max
- [ ] Greater than / less than in addition to the standard Y=
- [ ] Radians / Degrees option
- [ ] "Value" feature that shows the y-value for any desired x-value
