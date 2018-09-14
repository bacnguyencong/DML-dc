# DML-dc
[An approach to supervised distance metric learning based on difference of convex functions programming](https://doi.org/10.1016/j.patcog.2018.04.024)

DML-dc contains the implementation of Distance Metric Learning using DC programming. For any question, please contact [Bac Nguyen](mailto:Bac.NguyenCong@ugent.be).

## Abstract
Distance metric learning has motivated a great deal of research over the last years due to its robustness for many pattern recognition problems. In this paper, we develop a supervised distance metric learning method that aims to improve the performance of nearest-neighbor classification. Our method is inspired by the large-margin principle, resulting in an objective function based on a sum of margin violations to be minimized. Due to the use of the ramp loss function, the corresponding objective function is nonconvex, making it more challenging. To overcome this limitation, we formulate our distance metric learning problem as an instance of difference of convex functions (DC) programming. This allows us to design a more robust method than when using standard optimization techniques. The effectiveness of this method is empirically demonstrated through extensive experiments on several standard benchmark data sets.

### Prerequisites
This has been tested using MATLAB 2010A and later on Windows and Linux (Mac should be fine).

## Installation
Download the repository into the directory of your choice. Then within MATLAB go to file >> Set path... and add the directory containing "DML-dc" to the list (if it isn't already). That's it.

## Usage
Please run (inside the matlab console)
```matlab
demo  % demo of DML-dc
```
## Authors
* [Bac Nguyen Cong](https://github.com/bacnguyencong)

## Acknowledgments
If you find this code useful in your research, please consider citing:
``` bibtex
@Article{Nguyendc2018,
  Title       = {An approach to supervised distance metric learning based on difference of convex functions programming},
  Author      = {Bac Nguyen and De Baets, Bernard},
  Journal     = {Pattern Recognition},
  Year        = {2018},
  volume      = {81},
  pages       = {562-574},
  issn        = {0031-3203},
  doi         = {https://doi.org/10.1016/j.patcog.2018.04.024},
}
```
