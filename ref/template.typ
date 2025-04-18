// #import "./booktab.typ": *
// #import "@preview/codly:0.2.0": *
#import "@preview/codelst:2.0.1": sourcecode
#import "./acronyms.typ": acro, usedAcronyms, acronyms
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/tablex:0.0.9": tablex, hlinex, vlinex,
#import "@preview/a2c-nums:0.0.1": int-to-cn-num, int-to-cn-simple-num

#let project(
  kind: "硕士",
  title: "中国农业大学论文模板",
  abstract-en: [],
  abstract-zh: [],
  title-en:[],
  title-zh:[],
  authors: [],
  teacher: [],
  // co-teacher:[],
  degree: [],
  major: [],
  field: [],
  college: [],
  signature: "",
  classification:[],
  security:[],
  acknowledgement: [],
  author-introduction: [],
  appendix:[],
  student-id:[],
  year:int,
  month:int,
  day:int,
  outline-depth: 3,
  draft:true,
  blind-review: false,
  abstract-en-outlined: true,
  logo:"./CAU_Logo.png",
  ref-path: "",
  ref-style:"emboj",
  acro-path: "",
  body
) = {

  if(blind-review){
    authors = hide[#authors]
    teacher = hide[#teacher]
    major = hide[major]
    field = hide[#field]
    student-id = hide[#student-id]
    acknowledgement = hide[#acknowledgement]
    author-introduction = hide[#author-introduction]
    draft = false
  }

  // Set the document's basic properties.
  set document(title: title)
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 25mm),
    background: if draft {rotate(-12deg, text(80pt, font:"Cooper", fill: silver)[DRAFT])} else {},
  )

  set text(font: ("Times New Roman", "SimSun"), size: 12pt, hyphenate: false)
  
  // show strong: set text(font: ("Times New Roman", "SimHei"), weight: "semibold", size: 12pt)

  // show strong: set text(font: ("Times New Roman"), size: 11pt, baseline: -0.5pt)
  show: show-cn-fakebold
  
  set par(leading: 12pt, first-line-indent: 2em)
  set list(indent: 1em)
  set enum(indent: 1em)
  set highlight(fill: yellow)
  set heading(numbering: "1.1")
  set heading(numbering: (..n) => {
    if n.pos().len() > 1 { numbering("1.1", ..n) } 
  })
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #block(width: 100%)[
      #set align(center)
      #v(6pt,weak: false)
      #text(font: ("Times New Roman", "SimHei"), weight: "bold", 16pt)[#it.body]
      #v(6pt,weak: false)
    ]
  ]

  let titlepage = {

    let justify(s) = {
      if type(s) == content and s.has("text") { s = s.text }
      assert(type(s) == type("string"))
      s.clusters().join(h(1fr))
    }

    set text(12pt)
    table(
      columns: (38pt, 1em, 1fr, 50pt, 1em, auto), 
      rows:(15.6pt, 15.6pt), 
      stroke:0pt+white,
      align: left+horizon,
      inset:0pt,
      justify[分类号], [:], [#classification], justify[单位代码], [:], [10019],
      justify[密级],   [:], [#security], justify[学号],     [:], [#student-id]
    )
  
    v(28pt)
    align(center, box(image(logo, fit:"stretch", width: 60%)))
    // align(center, image(logo, width:48%))
    align(center)[#text(18pt, weight: 700, kind+"学位论文")]
    v(15.6pt)
    align(center)[
      #set par(leading: 14pt)
      #text(22pt, font:("Times New Roman", "SimHei"), weight: 700, title-zh)
    ]
    align(center)[
      #set text(16pt, font:"Times New Roman", weight: 700, baseline:-8pt)
      #title-en
    ]
    v(40pt)
  
    let table_underline(s) = [
      #set text(14pt, baseline:5pt)
      #s
      #v(-0.5em)
      #line(length: 100%, stroke: 1pt)
    ]

    align(center)[
      #set text(14pt)
      #table(
        columns: (150pt, 2pt, 40%), 
        rows:27.3pt, 
        align:center+horizon,
        stroke: none,
        justify[研究生], [:], table_underline[#authors],
        justify[指导教师],[:], table_underline[#teacher],
        // justify[合作指导教师],[:],table_underline[#co-teacher],
        justify[申请学位门类级别], [:], table_underline[#degree],
        justify[专业名称], [:], table_underline[#major],
        justify[研究方向], [:], table_underline[#field],
        justify[所在学院], [:], table_underline[#college]
      )
    ]
    
    v(75pt)
    align(center, int-to-cn-simple-num(str(year)).replace("〇", "零")+"年"+int-to-cn-num(month)+"月")
    pagebreak()
  }

  let statementpage = {

    set text(font:"SimSun", 12pt)
    text(font:"SimHei", 22pt)[#align(center)[独创性声明]]
    
    [本人声明所呈交的学位论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中已经注明引用、已经声明生成式人工智能使用情况和致谢的内容外，论文中不包含其他人已经发表或撰写过的研究成果，不包含使用生成式人工智能直接生成的内容，也不包含本人为获得中国农业大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表达了谢意。]
  
    v(4em)
    grid(
      columns: (2em, auto, 1fr, auto),
      [],
      [学位论文作者签名:],
      [],
      text("时间: "+str(year)+"年"+str(month)+"月"+str(day)+"日"),
    )
    v(4em)

    text(font:"SimHei", 22pt)[#align(center)[关于学位论文使用授权的说明]]
    text(font:"SimSun", 12pt)[本人完全了解中国农业大学有关保留、使用学位论文的规定。本人同意中国农业大学有权保存及向国家有关部门和机构送交论文的纸质版和电子版，允许论文被查阅和借阅；本人同意中国农业大学将本学位论文的全部或部分内容授权汇编录入《中国博士学位论文全文数据库》或《中国优秀硕士学位论文全文数据库》进行出版，并享受相关权益。\ #h(2em)*(保密的学位论文在解密后应遵守此协议)*]

    v(4em)
    grid(
      columns: (2em, auto, 1fr, auto),
      [],
      [学位论文作者签名:],
      [],
      text("时间: "+str(year)+"年"+str(month)+"月"+str(day)+"日"),
    )
    v(2em)
    grid(
      columns: (2em, auto, 1fr, auto),
      [],
      [导师签名:],
      [],
      text("时间: "+str(year)+"年"+str(month)+"月"+str(day)+"日"),
    )

    if draft{ }else{
      place(top+left, dx: 47%, dy: 72%, rotate(-24deg, image("./CAU_Stamp.png", width: 100pt)))
      place(top+left, dx: 47%, dy: 25%, rotate(-24deg, image("./CAU_Stamp.png", width: 100pt)))
    }
    if(signature != ""){
      place(top+left, dx: 29%, dy: 25%, image("../"+signature, width: 100pt))
      place(top+left, dx: 29%, dy: 68%, image("../"+signature, width: 100pt))
    }

    pagebreak()
  }

  let abstractpage={
    set page(numbering: "I")
    counter(page).update(1)

    align(center)[
      #heading(outlined: true, level: 1, numbering:none, [摘要])]
      v(16pt,weak: false)
      set par(justify: true)
      [#h(2em) #abstract-zh]
  
    align(center)[
      #heading(outlined: abstract-en-outlined, level: 1, numbering: none, [Abstract])]
      v(16pt,weak: false)
      set par(justify: true)
      [#abstract-en]
  }

  let contentspage={
    set page(numbering: "I")
    show outline: set heading(level: 1, outlined: true)
    heading(level: 1, numbering: none)[目录]
    v(16pt,weak: false)
    outline(depth: outline-depth, indent: n => 2em * n, title: none)
  }

  let illustrationspage={
    // set text(font: sunfont, size: 12pt)
    set page(numbering: "I")
    // set par(leading: 12pt)
    heading(level: 1, numbering: none)[插图和附表清单]
    v(16pt,weak: false)
    outline(title:none, target: figure.where(kind:image))
    set par(first-line-indent: 0em)
    outline(title:none, target: figure.where(kind:table))
  }

  let acronymspage={    
    // set text(font: sunfont, size: 12pt)
    set page(numbering: "I")
    // set par(leading: 12pt)
    heading(level: 1, numbering: none)[缩略词表]
    v(16pt,weak: false)
    set text(font: ("Times New Roman", "SimHei"), size: 10.5pt)
    line(length: 100%); v(-0.5em)
    grid(columns: (20%, 1fr, 30%), align(center)[缩略词], [英文全称], align(center)[中文全称])
    v(-0.5em); line(length: 100%)
    set text(font: ("Times New Roman", "SimSun"), size: 10.5pt)
    context {
        usedAcronyms.final()
            .pairs()
            .filter(x => x.last())
            .map(pair => pair.first())
            .sorted()
            .map(key => grid(
                columns: (20%, 1fr, 30%),
                align(center)[#eval(acronyms.at(key).at(0), mode: "markup")], 
                eval(acronyms.at(key).at(1), mode: "markup"), 
                align(center)[#eval(acronyms.at(key).at(2), mode: "markup")],
                )
            )
            .join()
    }
    line(length: 100%)
  }

  let acknowledgementpage = [
    = 致谢
    #acknowledgement
  ]

  let authorpage = [
    = 个人简介
    #author-introduction
  ]

  let appendixpage=[
    = 附录
    #appendix
    #heading(level: 6, numbering: none, outlined: false)[]
  ]

  let reference = {
    show bibliography: set par(leading: 1em, first-line-indent: 0em)
    show bibliography: set text(size: 10.5pt)
    heading(level: 1)[参考文献]
    if ref-style == "emboj" {
      bibliography(ref-path, title: none, style: "the-embo-journal.csl")
    }else{
      bibliography(ref-path, title: none, style: ref-style)
    }
    heading(level: 6, numbering: none, outlined: false)[]
  }

  let bodyconf() = {
    set par(justify: true)
    set page(
      numbering: "1",
      number-align: center,
      header:[
        #set text(9pt, font:("Times New Roman", "SimSun"))
        #text("中国农业大学"+kind+"学位论文")
        #h(1fr)
        #context {
            let eloc = query(selector(heading).after(here())).at(0).location()
            query(selector(heading.where(level:1)).before(eloc)).last().body.text
        }
        #v(-3.8pt)
        #line(length: 100%, stroke: 3pt)
        #v(-8pt)
        #line(length: 100%, stroke: 0.5pt)
      ],
      header-ascent: 10%,
    )

    show heading: it => {
      let levels = counter(heading).at(it.location())
      if it.level == 1 {
        if levels.at(0) != 1 {
          colbreak(weak:false)
        }
        block(width:100%, breakable: false, spacing: 0em)[
          #set align(center)
          #v(16pt,weak: false)
          #text(font: ("Times New Roman", "SimHei"), weight: "bold", 16pt)[#it.body]
          #v(16pt,weak: false)
        ]
      } else if it.level == 2 {
        block(breakable: false, spacing: 0em)[
          #v(14pt, weak: false)
          #text(font: ("Times New Roman","SimHei"), 14pt, weight: "regular")[#it]
          #v(14pt, weak: false)
        ]
      } else if it.level == 3 {
        block(breakable: false, spacing: 0em)[
          #v(24pt, weak: false)
          #text(font: ("Times New Roman","SimHei"), 12pt, weight: "regular")[#it]
          #v(12pt, weak: false)
        ]
      }
      par()[#text(size:0.0em)[#h(0em)]]
    }

    let frame(stroke) = (x, y) => (
      left: none,
      right: none,
      top: if y < 2 { stroke } else { 0pt },
      bottom: stroke,
    )
    set table(stroke: frame(1pt))
    set table.header(repeat: true)

    show figure: set block(breakable: true)
    set figure.caption(separator: [#h(0.5em)])
    show figure.where(supplement: [表]): set figure.caption(position: top)
    // show ref.where(form: "normal"): it => {
    //   it
    //   h(-0.2em)
    //   if it.target == bibliography {
    //     h(0.2em)
    //   }
    // }
    show figure.caption: set text(font:("Times New Roman","SimHei"), 10.5pt)
    show figure.where(kind: image): set figure(
      numbering: i=> numbering("1-1", ..counter(heading.where(level: 1)).get(), i)
    )
    show figure.where(kind: table): set figure(
      numbering: i=> numbering("1-1", ..counter(heading.where(level: 1)).get(), i)
    )
    show heading.where(level: 1): it =>{
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: image)).update(0)
      it
    }
    show figure.where(kind: image): it => {
      set text(font:("Times New Roman","SimSun"), 10.5pt)
      it
      v(-4pt)
      par()[#text(size:0.0em)[#h(0em)]]
    }
    show figure.where(kind: table): it => {
      set text(font:("Times New Roman","SimSun"), 10.5pt)
      it
      v(-1em)
      par()[#text(size:0.0em)[#h(0em)]]
    }

    show list:it =>{
      it
      v(-1em)
      par()[#text(size:0.0em)[#h(0em)]]
    }

    show enum:it =>{
      it
      v(-1em)
      par()[#text(size:0.0em)[#h(0em)]]
    }

    show math.equation.where(block:true):it =>{
      it
      v(-1em)
      par()[#text(size:0.0em)[#h(0em)]]
    }

    // show: codly-init.with()
    show raw.where(block: true): set par(justify: false)
    show raw.where(block:true):it =>{
      it
      v(-4pt)
      par()[#text(size:0.0em)[#h(0em)]]
    }
    // codly(
    //   zebra-color: rgb("#FAFAFA"),
    //   stroke-width: 2pt,
    //   fill: rgb("#FAFAFA"),
    //   display-icon: false,
    //   padding: 0.5em,
    //   display-name: false,
    // )
    [
      #body
      #reference
      #acknowledgementpage
      #appendixpage
      #authorpage
    ]
    // disable-codly()
  }

  [
    #titlepage
    #statementpage
    #abstractpage
    #contentspage
    #illustrationspage
    #acronymspage
    #show: body => bodyconf()
  ]

}

#let l(it) = align(left)[#it]
#let u(it) = underline(offset: 5pt)[#it]
#let legend(it) = block(breakable: false, above: 8pt, inset:(x:2em))[
  #set text(size: 9pt)
  #set par(first-line-indent: 2em, leading:1em)
  #align(left)[#it]
  #par()[#text(size:0.0em)[#h(0em)]]
]
#let loadcsv(csvFilePath, columns:(), ..args) = table(
    columns: columns,
    ..csv("../template/"+csvFilePath).flatten(),
  )

