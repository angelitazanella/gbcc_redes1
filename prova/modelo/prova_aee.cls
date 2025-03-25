% - Identification -------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modelo/provaaee}[2022]
% Initial Code ---------------------------------------
%
\RequirePackage{ifthen}
\RequirePackage{times}
\RequirePackage[dvipsnames]{xcolor}
%
% - Declaration of Options -----------------------------
%
% saving taken from dissertation.sty with modification
%
\newboolean{saving}
%
\DeclareOption{draft}{\setboolean{saving}{true}}
\DeclareOption{final}{\setboolean{saving}{false}}

\PassOptionsToClass{a4paper,oneside,onecolumn}{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{draft}
%
% - Execution of Options -------------------------------
%
\ProcessOptions
%
% - Package Loading ------------------------------------
%
\LoadClass{article}

%
% - Main Code ------------------------------------------
%
%     some redefinitions I need later
%
\let\oldquote\quote
\let\oldendquote\endquote
\let\oldquotation\quotation
\let\oldendquotation\endquotation
\let\oldverse\verse
\let\oldendverse\oldverse
\let\oldbibliography\bibliography
\let\oldendbibliography\endbibliography
\let\oldabstract\abstract
\let\oldendabstract\endabstract
%
%     some definitions and defaults that are convenient

%
\def\colegio#1{\gdef\@colegio{#1}}
\def\curso#1{\gdef\@curso{#1}}
\def\area#1{\gdef\@area{#1}}
\def\disciplina#1{\gdef\@disciplina{#1}}
\def\professor#1{\gdef\@professor{#1}}
\def\orientacoes#1{\gdef\@orientacoes{#1}}
\def\prova#1{\gdef\@prova{#1}}

%

\gdef\@colegio{Instituto Federal Catarinense - C\^{a}mpus Videira}
\gdef\@curso{Curso de Educa\c{c}\~{a}o Profissional T\'{e}cnica de N\'{\i}vel M\'{e}dio}
\gdef\@area{Inform\'{a}tica}
\gdef\@disciplina{Redes de Computadores}
\gdef\@professor{Angelita Rettore de Araujo Zanella}
\gdef\@orientacoes{ }
\gdef\@prova{Prova}

%
% Spacing and margins
%
% These margins are set for letter size paper for North American tastes.
% Other users will have to make the relevant adjustments here or in their 
% LaTeX source file
%
% \spacing - redefine \baselinestretch and recompute \baselineskip
%
\newcommand{\spacing}[1]{\renewcommand{\baselinestretch}{#1}%
			\large\normalsize}
%
\ifthenelse{\boolean{saving}}
{       % settings for draft
		\setlength {\topmargin}{-0.9in}	 % top margin    1.0 inch
        \setlength {\textheight}{10.5in}	 % bottom margin 1.0 inch
        \setlength {\oddsidemargin}{-0.5in}	 % left margin   1.0 inch
		\setlength {\evensidemargin}{-0.5in}	 % right margin  1.0 inch
        \setlength {\textwidth}{7.3in}	 % right margin  1.0 inch
        \spacing{1}						 % single spacing for draft
}
{       % settings for final
		\setlength {\topmargin}{-0.6in}	 % top margin    1.0 inch
        \setlength {\textheight}{9in}	 % bottom margin 1.0 inch
        \setlength {\oddsidemargin}{-0.5in} % left margin    1.5 inch
		\setlength {\evensidemargin}{-0.5in}	 % right margin  1.5 inch
        \setlength {\textwidth}{7.3in}	 % right margin  1.5 inch
        \spacing{2}						 % double spacing for final
        \renewenvironment{quote}			 % redef as single spaced
			{\oldquote\spacing{1}}
			{\oldendquote\spacing{2}}
		\renewenvironment{quotation}		 % redef as single spaced
			{\oldquotation\spacing{1}}
			{\oldendquotation\spacing{2}} 
		\renewenvironment{verse}		     % redef as single spaced
			{\oldquotation\spacing{1}}
			{\oldendquotation\spacing{2}} 
}
\setlength {\footnotesep}{14pt}			  % baseline skip for fn's 1st line
\setlength {\headheight}{0.2in}			  % make room for header
\setlength {\headsep}{0.2in}				  % modest header separation
\setlength {\parskip}{0.2in}				  % set a paragraph skip
\setlength {\parindent}{0.2in}			  % I hate unindented first lines
\renewenvironment{bibliography}[1]		  % automatically enter toc line
	{\addcontentsline{toc}{chapter}{Bibliography}\oldbibliography {#1}}
	{\oldendbibliography}
%
% Make footnotes single spaced
%
%			code shamelessly stolen from setspace.sty 
%				written by Geoffrey Tobin <G.Tobin@latrobe.edu.au>
%
\long\def\@footnotetext#1{%
  \insert\footins{%
    \def\baselinestretch {1}%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}
%
% redefine the titlematter
%
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \thispagestyle{empty}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  %
  \global\let\@area\@empty
  \global\let\@curso\@empty
  \global\let\@professor\@empty
  \global\let\@colegio\@empty
  %
  \global\let\title\relax
  \global\let\date\relax
  \global\let\and\relax
}
%
\def\@maketitle{%

  \begin{flushleft}%
    { \sffamily 
    \begin{tabular}{ p{3.7cm}p{14cm}}
     \multirow{6}{*}{\includegraphics[height=5cm] {modelo/Logo_IFC_vertical_Videira.png}} 
     \\ 
     &  \textbf{Curso:} \@curso \\[2em]
     & \textbf{Disciplina:} \@disciplina \\[1em]
     & \textbf{Professora:} \@professor \\[1em]
     & \textbf{Aluno:} \rule{13cm}{0.4pt}  \\[1em]
     & \textbf{Data: } \underline{\qquad/\qquad/\qquad\qquad} \\
     \vspace{3cm}
     
    \end{tabular}    
    \\}%
    { \sffamily  }%
    \vskip 2em
    {\color{OliveGreen}\hrule}
    \begin{center}
        \Huge\textbf{\@prova}
    \end{center}
    
  {\sffamily 
  \begin{large}
  \textbf{Orienta\c{c}\~{o}es:} \\[.3em]
  \@orientacoes
  \end{footnotesize}
  \vskip .3em}
  {\color{OliveGreen}\hrule}
  \par
  \vskip 1.5em}
%
% make section titles less obnoxious
%
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-1.5ex \@plus -1ex \@minus -.2ex}%
                                   {0.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
%
% Set up headers
%
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage -- \slshape\leftmark\hfil}%
    \def\@oddhead{\hfil{\slshape\rightmark} -- \thepage}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }
%
% Position the abstract depending on presence of titlepage
%
\if@titlepage
  \renewenvironment{abstract}{%
	  \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\fi
%
% change some names
%
\renewcommand\contentsname{Table of Contents}
\renewcommand\refname{Bibliography}
%
%	\epigraph{text}{byline}
%
\newcommand{\epigraph}[2]{\begin{flushright}\begin{minipage}{4in}%
			\spacing{1}#1\begin{flushright}#2\end{flushright}%
			\hrule\end{minipage}\vskip 12pt\end{flushright}}
%
%% End of file `coursepaper.cls'.
