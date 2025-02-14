# ccpe2025-richardson
This repository contains the software and data necessary to replicated every number, table and figure printed in the manuscript: "How accurate is Richardson's error estimate" which has been submitted to the journal CCPE. The manuscript is an extended version of a paper that has previously been accepted by PPAM 2024. The authors are Carl Chrisian Kjelgaard Mikkelsen from Umeå University, Sweden and Lorién López-Villellas from University of Zaragoza, Spain.

The reader who wishes to replicate the experiments or examine the output in greater detail should clone the repository.

The structure of the repository is as follows

.</br>
├── exp</br>
├── gromacs</br>
├── LICENSE</br>
├── matlab</br>
└── README.md</br>

If the reader does not wish to work with GROMACS, then this folder can be ignored as the output from GROMACS is included in the form of MATLAB. mat files.

The folder "exp" contain the matlab functions needed to replicate the experiments from scatch using various auxiliary files that are stored in the folder "matlab".

How to execute the MATLAB experiments? We assume that the reader is using Linux.

1) Clone the repositiory
2) Open a terminal window and move to the folder ccpe2025-richardson.
3) Launch MATLAB and set the path to include the folders "exp" and "matlab" as well as their subfolders.

It is important to start MATLAB from the folder ccpe2025-richardson, because our software searches for .mat files and writes .eps figures at specific relative locations.


To reproduce the GROMACS experiments conducted in the paper, start by downloading the GROMACS-v2021 submodule by executing the following commands:

```
git submodule init
git submodule update
```

To compile GROMACS following the approach employed in the paper, utilize the `install_double` script.

Ensure that all Python dependencies necessary for processing the execution results are installed by running:

```
pip install -r requirements.txt
```

Following the installation of dependencies, execute the experiments using the `run.sh` script. Subsequently, extract the relevant results using `process_results.py`.
