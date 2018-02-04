---
title: Carpe Diem
author: Me
mathjax: yes
---

$\newcommand{\sem}[1]{[\mkern-2.75mu[#1]\mkern-2.75mu]}\newcommand{\zz}{\mkern2mu}$

$$\begin{array}{c}
[\ ]
\\\hline
\mathsf{j}
\end{array}
\left(
\begin{array}{c}
[\ ]
\\\hline
\mathsf{saw}
\end{array}
\begin{array}{c}
\lambda x. [\ ]
\\\hline
x
\end{array}
\right)
\Longrightarrow
\begin{array}{c}
\lambda x. [\ ]
\\\hline
\mathsf{saw}\zz x\zz \mathsf{j}
\end{array}
\Longrightarrow
\lambda x. \mathsf{saw}\zz x\zz \mathsf{j}$$

Lorem ipsum

$$\begin{array}{c}
[\ ]
\\\hline
\exists x. [\ ]
\\\hline
x
\end{array}
\left(
\begin{array}{c}
[\ ]
\\\hline
[\ ]
\\\hline
\mathsf{saw}
\end{array}
\begin{array}{c}
\forall y. [\ ]
\\\hline
[\ ]
\\\hline
y
\end{array}
\right)
\Longrightarrow
\begin{array}{c}
\forall y. [\ ]
\\\hline
\exists x. [\ ]
\\\hline
\mathsf{saw}\zz y\zz x
\end{array}
\Longrightarrow
\forall y. \exists x. \mathsf{saw}\zz y\zz x$$

@.  $m \gg\mkern-5mu= f := \lambda g. \bigcup \{f\zz x\zz h \mid (x, h) \in
    m\zz g\}$

@.  $\eta\zz x := \lambda g. \{(x, g)\}$

@.  $m \circledast n := \lambda g. \{(f\zz x, i) \mid (f, h) \in m\zz g, (x,
    i) \in n\zz h\}$

@.  $\mu\zz M := \lambda g. \bigcup \{m\zz h \mid (m, h) \in M\zz g\}$

$$\begin{array}{r@{}c@{}ll}
{\sem{A\ B}}^g &:=& \left\{
\begin{array}{ll}
{\sem A}^g\zz {\sem B}^g & \text{if } A : \sigma \rightarrow \tau, B : \sigma
\\
{\sem B}^g\zz {\sem A}^g & \text{if } A : \sigma, B : \sigma \rightarrow \tau
\\\\
\lambda x. {\sem A}^g x \wedge \sem B^g x & \text{if } A, B : \sigma
\rightarrow \texttt t
\end{array}
\right.
\\\\
{\sem{n\ A}}^g &:=& \lambda x.{\sem A}^{g[n \rightarrow x]}
\\\\
\end{array}$$

```haskell
data X = Y | Z

x :: Monad m => m a
x = do
    y <- mx
    return (f x)

-- comment
```
