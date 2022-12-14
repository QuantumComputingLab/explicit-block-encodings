# Explicit Quantum Circuits for Block Encodings of Certain Sparse Matrices

This repository contains a collection of MATLAB scripts to generate explicit quantum circuits for block encodings of certain sparse matrices in [QCLAB](https://github.com/QuantumComputingLab/qclab). A quantum circuit is a block encoding for a matrix $A$ if the unitary matrix $U$ that corresponds to the circuit has $A$ as its leading principal sub-block:

```math
U = \begin{bmatrix}A & * \\ * & * \end{bmatrix}.
```

We say that the circuits we propose are *explicit* as they do not contain any blackbox oracles but are completely formulated in terms of elementary quantum gates. Furthermore, all the examples we provide have an *efficient* circuit decomposition that requires $\mathcal{O}$(poly($n$)) elementary quantum gates for an $n$ qubit circuit.

Block encodings have been widely adopted in recent years for solving a broad range of computational problems with quantum computers. They are the central primitive in quantum numerical linear algebra algorithms.

The examples scripts include block encoding circuits for:

* A symmetric $2 \times 2$ matrix:
  
```math
\begin{bmatrix}
\alpha_1 & \alpha_2 \\
\alpha_2 & \alpha_1
\end{bmatrix}
```

**scripts:** `test_realsym2_simple.m`, `test_realsym2.m`

* A banded circulant matrix or - equivalently - a tridiagonal matrix with periodic 
  boundary conditions. We do also include the implementation for a tridiagonal matrix
  with non-periodic boundary conditions.

```math
\begin{bmatrix}
\alpha & \gamma & 0      & \cdots & \beta     \\
\beta  & \alpha & \ddots & \ddots &  0        \\
0      & \beta  & \ddots & \gamma    & \vdots \\
\vdots & \ddots & \ddots & \alpha & \gamma    \\
\gamma &     0  & \cdots & \beta  & \alpha    \\
\end{bmatrix}
```

**scripts:** `test_tridiag_cab.m`, `test_tridiag_cab_ucry.m`, `test_tridiag.m`, `test_tridiag_ucry.m`

* The adjacency matrix for a weighted extended binary tree with $2^n$ nodes.

```math
\begin{bmatrix}
\gamma & \beta  &        &        &        &        &        &       \\  
\beta  & \alpha & \beta  & \beta  &        &        &        &       \\
       & \beta  & \alpha &        & \beta  & \beta  &        &       \\
       & \beta  &        & \alpha &        &        & \beta  & \beta \\
       &        & \beta  &        & \gamma &        &        &       \\
       &        & \beta  &        &        & \gamma &        &       \\
       &        &        & \beta  &        &        & \gamma &       \\
       &        &        & \beta  &        &        &        & \gamma 
\end{bmatrix}
```

**scripts:** `test_extbintree.m`

These example matrices all have a simple structure. The quantum circuits that block encode them have a considerably higher degree of complexity and are not straightforward to derive. It is our goal that these examples will allow researchers to experiment with block encoding circuits and help them develop novel block encodings.

## QCLAB Toolbox
All the example scripts make use of the QCLAB toolbox, which requires MATLAB R2018a or newer. Detailed download installation instructions can be found [here](https://github.com/QuantumComputingLab/qclab).

## Reference
*Explicit Quantum Circuits for Block Encodings of Certain Sparse Matrices*, D. Camps, L. Lin, R. Van Beeumen, C. Yang (2022), [arXiv:2203.10236](https://arxiv.org/abs/2203.10236).
