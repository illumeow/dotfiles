#let mystyles = {
  import "styles/boxy.typ": boxy-without-supplement
  import "styles/hint.typ": hint-without-supplement
  import "styles/thmbox.typ": thmbox-without-supplement
  (boxy: boxy-without-supplement, hint: hint-without-supplement, thmbox: thmbox-without-supplement)
}

// code block: https://typst.app/universe/package/codly
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#let codly = codly.with(languages: codly-languages)

// theorem environment: https://typst.app/universe/package/ctheorems
#import "@preview/ctheorems:1.1.3": *
#let thmbox = thmbox.with(padding: (top: 0em, bottom: 0em), inset: 0pt)
// theorem, proposition, lemma use same counter
#let theorem = thmbox("theorem", "Theorem").with(numbering: none)
#let proposition = thmbox("theorem", "Proposition").with(numbering: none)
#let lemma = thmbox("theorem", "Lemma").with(numbering: none)
// corollary follows the theorem counter
#let corollary = thmbox("corollary", "Corollary", base: "theorem").with(numbering: none)
#let claim = thmbox("claim", "Claim").with(numbering: none)
#let definition = thmbox("definition", "Definition").with(numbering: none)
#let example = thmbox("example", "Example").with(numbering: none)
#let remark = thmbox("remark", "Remark").with(numbering: none)
#let supplement = thmbox("supplement", "Supplement").with(numbering: none)
#let recall = thmbox("recall", "Recall").with(numbering: none)

// for hint environment
#import "@preview/frame-it:1.2.0": *
#let hint = frame("Hint", gray)

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

#let null = math.op("null")
#let ran = math.op("ran")
#let row = math.op("row")
#let col = math.op("col")
#let span = math.op("span")
#let rank = math.op("rank")
#let trace = math.op("trace")
#let diag = math.op("diag")
#let inner(x, y) = $lr(chevron.l #x, #y chevron.r)$

#let frocol = state("color",rgb(255,255,255))
#let note(
  title,
  name: "楊晉宇",
  studentId: "B13902139",
  frontcolor:rgb(0,0,0),
  body
) = {
  frocol.update(frontcolor)

  set text( 
        fill: frontcolor, 
        font:(
          (name: "New Computer Modern", covers: "latin-in-cjk"),
          "Songti TC"
        )
      )

  show math.equation: set text(
        font:(
          "New Computer Modern Math",
          "Songti TC"
        )
  )

  let margin-size = 1in
  set page(
    margin: margin-size,
    header: context{
      if counter(page).get().first() > 1 [
        #set text(size: 10pt)
            #grid(
              columns: (1fr, 1fr),
              align: (left, right),
              [#title],
              [#studentId #name]
            )
            #v(5pt, weak: true)
            #line(length: 100%, stroke: 0.5pt + frocol.get())
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
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
  show: frame-style(mystyles.hint)
  
  // Title page
  align(center)[
    #text(size: 16pt, weight: "bold")[#heading(title)]
    #v(10pt, weak: true)
    #studentId #name
  ]
  
  body
}

// bind section counter with heading
#let section-counter = counter(heading)
#let section(title, newpage: false) = {
  // Add page break if requested
  if newpage {
    pagebreak()
  }

  section-counter.step()
  
  v(0.2in)
  
  // Section header
  text(size: 16pt, weight: "bold")[
    #title
  ]
  v(5pt, weak: true)
  context {
    line(length: 100%, stroke: 0.5pt + frocol.get())
  }
}

#let part(pattern: "(a)", start: 1, ..body) = {
  enum(numbering: it => strong[#numbering(pattern, it)], start: start, ..body)
}