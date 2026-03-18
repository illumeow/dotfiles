#import "@template/homework:1.1.0": *

#show: homework.with(
    class: "#",
    type: "Assignment",
    num: "#",
    // needTitle: true,
    // anonymous: true
)

#problem()
A `#problem()` command is provided to create a new problem.

#problem(title: "A numbered, titled problem")
You can provide a title, and it will be numbered automatically.
#part()[
  The `#part()` command is provided to create problem parts.
][
  Its default numbering pattern is *(a)*, *(b)*, ...
]

#problem(title: "A titled problem", nonum: true)
You can suppress numbering by setting `nonum` to true.
#part(pattern: "(1)")[
  You can change the numbering pattern by `pattern` argument.
][
  Any string that can be passed to `#numbering` is alllowed.
]
#part(pattern: "(a)", start: 3)[
  You can change the starting number by `start` argument.
][
  `#part` is actually a wrapped `#enum`, so `start` means the same thing as in `#enum`.\
  Note that you can only pass a `int` to `start`.
]

#problem(title: "Some defaults", nonum: true)
#part()[
  We use brackets as default delimeter for `vec` and `mat`
  $ vec(1, 2) mat(1, 2; 3, 4) $
  Moreover, equations are also fixed to be centralized. See #link("https://forum.typst.app/t/how-to-make-centralized-formulae-in-enums/3363", "here") for details.
][
  `codly-languages` is used by default, so you can directly use `#codly()` to create code blocks.
  // notice that you don't need to specify the language
  #codly()
  ```py
  def hello():
      print("Hello, world!")
  ```
]

The next problem is on a new page!

#problem(nonum: true, newpage: true)
if nonum is set, you have to type in a title

#bigbox()[
  This is a big box.
  You can put anything here.
  #part(pattern: "I")[
    And you can even put parts in it!
  ][
    Here's a tip: you can put negative values in `#v()` to reduce vertical space.
  ]
]

#problem(title: "Lets showcase some theorem environments")
#theorem("Name is optional")[
  Note that the problem's counter is bind with the heading's.
]

#problem()
#theorem()[
  And the theorem's counter "follows" the problem's counter!
]
#proposition()[
  Moreover, proposition and lemma share the same counter with theorem.
]
#lemma()[
  You can see the number is continued from theorem and proposition.
]
#corollary()[
  Then, corollary "follows" the theorem's counter.
]
#definition()[
  Definition is independent, though.
  It does not share the same counter with others, and no others follows its counter.
]
#theorem(numbering: none)[
  For all above environments, you can set `numbering` to `none` or `number` to an empty string to remove numbering.
  Just like this one!
]
#lemma(number: "5.6")[
  Or, you can set number to any string you like.
]
#example("Cool name")[
  Example and Remark, their default comes with no numbering.
]
#remark()[
  I don't have a number!
]
#example("Another cool name", number: "(a)")[
  But you can still set number if you want.
]
#proof()[
  Lastly, _proof_ environment is also provided.
  It does not have a counter, and is usually used after theorem-like environments.
  It automatically adds a Q.E.D. symbol (default to `$square$`) at the bottom right of the environment.
]
#proof()[
  If your proof ends in a block equation, or a list/enum, you can place `#qedhere` to correctly position the Q.E.D. symbol (or stay with the default).
  $ n > -1 quad forall n in NN #qedhere $
]
These are all theorem-like environments in this template.
You can add more by yourself if you want! Check out the `ctheorems` package for more details.

#problem()
Don't forget to check out `algo` and `codly` packages for pseudocode and code blocks!