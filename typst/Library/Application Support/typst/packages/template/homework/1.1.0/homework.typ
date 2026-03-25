// Homework Template for Typst
// Usage: #import "homework.typ": *

// pseudo code: https://typst.app/universe/package/algo
#import "@preview/algo:0.3.6": algo, i, d, comment, code, no-emph
#let algo = algo.with(block-align: left)
#let call(func, param) = {
  if param == [] {
    return smallcaps(func)
  }
  return smallcaps(func) + $($ + param + $)$
}
/*
#algo(
  title: "Fib",
  parameters: ("n",)
)[
  if $n < 0$:#i\        // use #i to indent the following lines
    return null#d\      // use #d to dedent the following lines
  if $n = 0$ or $n = 1$:#i #comment[you can also]\
    return $n$#d #comment[add comments!]\
  return #smallcaps("Fib")$(n-1) +$ #smallcaps("Fib")$(n-2)$
]
*/

// code block: https://typst.app/universe/package/codly
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#let codly = codly.with(languages: codly-languages)

// theorem environment: https://typst.app/universe/package/ctheorems
#import "@preview/ctheorems:1.1.3": *
#let thmbox = thmbox.with(padding: (top: 0em, bottom: 0em), inset: 0pt)
// theorem, proposition, lemma use same counter
#let theorem = thmbox("theorem", "Theorem")
#let proposition = thmbox("theorem", "Proposition")
#let lemma = thmbox("theorem", "Lemma")
// corollary follows the theorem counter
#let corollary = thmbox("corollary", "Corollary", base: "theorem")
#let definition = thmbox("definition", "Definition")
// example, remark do not use numbering
#let example = thmbox("example", "Example").with(numbering: none)
#let remark = thmbox("remark", "Remark").with(numbering: none)

// default the qed symbol to align right
#let my-proof-bodyfmt(body) = {
  thm-qed-done.update(false)
  body
  context {
    if thm-qed-done.at(here()) == false {
      v(-0.7em)
      align(right)[#thm-qed-show]
    }
  }
  v(-0.5em)
}
#let proof = thmproof("proof", "Proof", inset: 0pt, bodyfmt: my-proof-bodyfmt)

// Document setup function
#let frocol = state("color",rgb(255,255,255))
#let homework(
  class: "#",
  name: "楊晉宇",
  studentId: "B13902139",
  // department is not used
  department: "CSIE",
  type: "Homework",
  num: "#",
  backcolor:rgb(255,255,255),
  frontcolor:rgb(0,0,0),
  needTitle: false,
  anonymous: false,
  body
) = {
  // Page setup
  frocol.update(frontcolor)
  let margin-size = 1in 

  set text( 
        fill: frontcolor, 
        font:(
          "New Computer Modern",
          "Songti TC"
        )
      )
      
  show math.equation: set text(
        font:(
          "New Computer Modern Math",
          "Songti TC"
        )
  )
        
  set page(
    // background: 
    //   rect(
    //     width:100% ,
    //     height: 100%,
    //     fill: backcolor,
    //     stroke: none,
    //     inset: 0pt,
    //   ),
    margin: margin-size,
    header: 
      if not anonymous {
        context {
          if not needTitle or counter(page).get().first() > 1 [
            #set text(size: 10pt)
            #grid(
              columns: (1fr, 1fr, 1fr),
              align: (left, center, right),
              [#class],
              [#studentId #name],
              [#type #num]
            )
            #v(5pt, weak: true)
            #line(length: 100%, stroke: 0.5pt + frocol.get())
          ]
        }
      } else {
        context {
          if not needTitle or counter(page).get().first() > 1 [
            #set text(size: 10pt)
            #grid(
              columns: (1fr, 1fr),
              align: (left, right),
              [#class],
              [#type #num]
            )
            #v(5pt, weak: true)
            #line(length: 100%, stroke: 0.5pt + frocol.get())
          ]
        }
      },
    footer: context {
      if not needTitle or counter(page).get().first() > 1 [
        #align(center)[#counter(page).display()]
      ]
    }
  )
  
  // Text formatting
  set par(
    leading: 0.85em,
    justify: true,
    linebreaks: "optimized"
  )
  
  // Link styling
  show link: set text(fill: rgb("#008080"))

  // Add custom show (for packages) or set here
  // use square for qed symbol
  show: thmrules.with(qed-symbol: $square$)
  show: codly-init.with()
  set math.vec(delim: "[")
  set math.mat(delim: "[")
  show math.equation.where(block: true): eq => {
    block(width: 100%, inset: 0pt, align(center, eq))
  }
  
  // Title page
  if needTitle {
    align(center)[
      #text(size: 16pt, weight: "bold")[#class #type #num]
      #if not anonymous [
        #v(10pt, weak: true)
        #studentId #name
        #v(8pt, weak: true)
        #datetime.today().display("[month repr:long] [day padding:none], [year]")
      ]
    ]
  }
  
  body
}

// bind problem counter with heading
#let problem-counter = counter(heading)
#let problem(title: none, nonum: false, newpage: false) = {
  // Add page break if requested
  if newpage {
    pagebreak()
  }

  problem-counter.step()
  
  if not newpage {
    v(0.2in)
  }
  
  // Question header
  context {
    if nonum {
      if title != none [
        *#title*
      ] else [
        *Type your problem title here*
      ]
    } else {
      if title == none [
        *Problem #(problem-counter.get().first()).*
      ] else [
        *#problem-counter.get().first(). #title*
      ]
    }
  }
  v(5pt, weak: true)
  context {
    line(length: 100%, stroke: 0.5pt + frocol.get())
  }
}

#let part(pattern: "(a)", start: 1, ..body) = {
  enum(numbering: it => strong[#numbering(pattern, it)], start: start, ..body)
}

#let bigbox(content) = {
  v(0.5em)
  context {
    rect(
      width: 100%,
      stroke: 1pt + frocol.get(),
      inset: 8pt,
      content
    )
  }
}
