#import "@preview/frame-it:1.2.0": *

#let line-width = 3pt
#let body-inset = 1em
#let text-color(accent-color) = (
  accent-color.mix((text.fill.lighten(80%), 100%)).saturate(60%)
)

// Credits to https://github.com/s15n/typst-thmbox
#let thmbox-without-supplement(title, tags, body, supplement, number, accent-color) = {
  let has-body = body != []
  let has-title = title not in ([], "", none)
  let has-tags = tags.len() > 0
  let body-only = title == none

  let bar = stroke(paint: accent-color, thickness: line-width)

  show: styling.dividers-as({
    line(
      length: 100% + 1em,
      start: (-1em, 0pt),
      stroke: accent-color + line-width * 0.8,
    )
    v(-0.2em)
  })

  block(
    stroke: (
      left: bar,
    ),
    inset: (
      left: 1em,
      top: 0.6em,
      bottom: 0.6em,
    ),
    spacing: 1.2em,
  )[
    #set align(left)
    // Title bar
    #if not body-only {
      block(
        above: 0em,
        below: 1.2em,
        context {
          set text(text-color(accent-color), weight: "bold")
          if has-title {
            title
          }
          if has-tags {
            let tag-str = {
              [(#tags.join(", "))~]
            }
            [~_#(tag-str)_]
          }
        },
      )
    }
    // Body
    #if has-body {
      block(
        inset: (
          right: 1em,
        ),
        spacing: 0em,
        width: 100%,
        body,
      )
    }
  ]
}