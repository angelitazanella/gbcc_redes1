\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modelo/prova2}[2026]

% --- Opções de Draft/Final ---
\RequirePackage{ifthen}
\newboolean{saving}
\DeclareOption{draft}{\setboolean{saving}{true}}
\DeclareOption{final}{\setboolean{saving}{false}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{draft}
\ProcessOptions\relax

\LoadClass[a4paper,oneside]{article}

% --- Pacotes Necessários ---
\RequirePackage{times}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{multirow}
\RequirePackage{graphicx}
\RequirePackage{calc} % Para cálculos de medidas
\RequirePackage{extsizes}      % <-- LINHA NOVA: permite 14pt

% --- Variáveis do Cabeçalho ---
\def\curso#1{\gdef\@curso{#1}}
\def\disciplina#1{\gdef\@disciplina{#1}}
\def\professor#1{\gdef\@professor{#1}}
\def\orientacoes#1{\gdef\@orientacoes{#1}}
\def\prova#1{\gdef\@prova{#1}}

\gdef\@curso{Bacharelado em Ciência da Computação}
\gdef\@disciplina{Redes de Computadores I}
\gdef\@professor{Angelita Rettore de Araujo}
\gdef\@orientacoes{ }
\gdef\@prova{Avaliação}

% --- Espaçamento e Margens ---
\newcommand{\spacing}[1]{\renewcommand{\baselinestretch}{#1}\large\normalsize}

\ifthenelse{\boolean{saving}}
{ % Draft
    \setlength{\topmargin}{-0.9in}
    \setlength{\textheight}{10.5in}
    \setlength{\oddsidemargin}{-0.5in}
    \setlength{\evensidemargin}{-0.5in}
    \setlength{\textwidth}{7.3in}
    \spacing{1}
}
{ % Final
    \setlength{\topmargin}{-0.6in}
    \setlength{\textheight}{9in}
    \setlength{\oddsidemargin}{-0.5in}
    \setlength{\evensidemargin}{-0.5in}
    \setlength{\textwidth}{7.3in}
    \spacing{2}
}

% \setlength{\parskip}{0.2in}
% \setlength{\parindent}{0.2in}

% --- O NOVO SISTEMA DE QUESTÕES (Simulando a classe exam) ---
\newcounter{questnum}
\newcommand{\question}[1][]{%
    \stepcounter{questnum}%
    \par\noindent
    \textbf{\thequestnum.} \ifthenelse{\equal{#1}{}}{}{(#1 pontos)}     
}

% Ambiente para alternativas (a, b, c...)
\newenvironment{choices}{
    % \vspace{-1.5em}
    \begin{enumerate}
    \renewcommand{\theenumi}{\Alph{enumi}}
    \renewcommand{\labelenumi}{\theenumi)}   
    \setlength{\itemsep}{0pt}    % Ajusta o espaço entre os itens
    \setlength{\parskip}{0pt}    % Ajusta o espaço de parágrafo entre itens 
}{\end{enumerate}}

% Ambiente para afirmações (I, II, III...)
\newenvironment{statements}{
    % \vspace{-1.5em}
    \begin{enumerate}
    \renewcommand{\theenumi}{\Roman{enumi}}
    \renewcommand{\labelenumi}{\theenumi.}
    \setlength{\itemsep}{0pt}    % Ajusta o espaço entre os itens
    \setlength{\parskip}{0pt}    % Ajusta o espaço de parágrafo entre itens
}{\end{enumerate}}

% --- Cabeçalho (Baseado no seu original) ---
\renewcommand\maketitle{
  \begingroup
    \spacing{1} % Cabeçalho sempre simples
    \setlength{\parskip}{0pt}
    \noindent
    \sffamily
    \begin{tabular}{@{} p{3.7cm} p{13.5cm} @{}}
     \multirow{5}{*}{\includegraphics[height=4.2cm]{modelo/Logo_IFC_vertical_Videira.png}} 
     & \textbf{Curso:} \@curso \\[0.5em]
     & \textbf{Disciplina:} \@disciplina \\[0.5em]
     & \textbf{Professora:} \@professor \\[2em]
     & \textbf{Aluno:} \rule{11cm}{0.4pt} \\[0.8em]
     & \textbf{Data: } \underline{\qquad/\qquad/\qquad\qquad} \\
    \end{tabular}
    
    \vspace{1em}
    {\color{OliveGreen}\hrule height 0.5pt}
    \begin{center}
        {\bfseries\Large \@prova}
    \end{center}
    
    \noindent\scriptsize
    \textbf{Orienta\c{c}\~{o}es:} \\
    \@orientacoes
    \vspace{0.5em}
    {\color{OliveGreen}\hrule height 0.5pt}
    \vspace{3em}
  \endgroup
}

% --- Opção para exibir Gabarito ---
\newboolean{gabarito}
\setboolean{gabarito}{false} % Padrão: não mostra
\DeclareOption{answers}{\setboolean{gabarito}{true}}
\ProcessOptions\relax

% --- Comando para a Resposta ---
\newcommand{\answer}[1]{
    \ifthenelse{\boolean{gabarito}}
    {\par\vspace{0.5em}\noindent{\color{red}\textbf{Gabarito:} #1}\par}
    {}
}

% --- Ajuste no Choices para destacar a correta ---
\newcommand{\correct}{\ifmanualgabarito\color{red}\fi} % Opcional para uso manual