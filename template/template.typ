// #import "@preview/tablex:0.0.7": tablex, hlinex, rowspanx
#import "../ref/booktab.typ": *
#import "../ref/codelst.typ": sourcecode
#import "../ref/acronyms.typ": acro, usedAcronyms, acronyms

// #let tl-table = tablex.with(
//     columns: columns,
//     auto-lines: false,
//     hlinex(y: 0),
//     hlinex(y: 1)
// )

#let project(
  kind: "硕士",
  title: "中国农业大学论文模板",
  abstract_en: [],
  abstract_zh: [],
  title_en:[],
  title_zh:[],
  authors: [],
  teacher: [],
  co-teacher:[],
  degree: [],
  major: [],
  field: [],
  college: [],
  signature: "",
  classification:[],
  security:[],
  student_ID:[],
  year: [],
  month: [],
  day: [],
  outlineDepth: 3,
  draft:true,
  blindReview: false,
  logo:"./CAU_Logo.png",
  body
) = {

  if(blindReview){
    authors = hide[#authors]
    teacher = hide[#teacher]
    major = hide[major]
    field = hide[#field]
    student_ID = hide[student_ID]
    draft = false
  }

  // Set the document's basic properties.
  set document(title: title)
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 25mm),
    background: if draft {rotate(-12deg, text(80pt, font:"Sigmar One", fill: silver)[DRAFT])} else {},
  )

  set text(font: ("Times New Roman", "SimSun"), size: 12pt, hyphenate: false)
  
  // show strong: set text(font: ("Times New Roman", "SimHei"), weight: "semibold", size: 12pt)

  show strong: set text(font: ("Times New Roman", "FZXiaoBiaoSong-B05S"), size: 11pt, baseline: -0.5pt)
  

  // show regex("[\u4e00-\u9fa5]"): set text(font: "SJheisongti")
  // show regex("\p{sc=Hani}+"): set text(font: "FZXiaoBiaoSong-B05S")

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
      #text(font: ("Times New Roman","Microsoft YaHei"), weight: "bold", 16pt)[#it.body]
      #v(6pt,weak: false)
    ]
  ]

  let titlepage = {

    let justify(s) = {
      if type(s) == "content" and s.has("text") { s = s.text }
      assert(type(s) == "string")
      s.clusters().join(h(1fr))
    }

    set text(12pt)
    table(
      columns: (38pt, 1em, 1fr, 50pt, 1em, auto), 
      rows:(15.6pt, 15.6pt), 
      stroke:0pt+white,
      align: left+horizon,
      inset:0pt,
      justify[分类号], [:], [#classification], justify[单位代码], [:], [100019],
      justify[密级],   [:], [#security], justify[学号],     [:], [#student_ID]
    )
  
    v(28pt)
    align(center, box(image(logo, fit:"stretch", width: 60%)))
    // align(center, image(logo, width:48%))
    align(center)[#text(18pt, weight: 700, kind+"学位论文")]
    v(15.6pt)
    align(center)[
      #set par(leading: 14pt)
      #text(22pt, font:("Times New Roman", "SimHei"), weight: 700, title_zh)
    ]
    align(center)[
      #set text(16pt, font:"Time New Roman", weight: 700, baseline:-8pt)
      #title_en
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
    align(center, year+"年"+month+"月")
    pagebreak()
  }

  let statementpage = {

    set text(font:"SimSun", 12pt)
    text(font:"SimHei", 22pt)[#align(center)[独创性声明]]
    
    [本人声明所呈交的学位论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中已经注明引用和致谢的内容外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含本人为获得中国农业大学或其他教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表达了谢意。]
  
    v(4em)
    grid(
      columns: (2em, auto, 1fr, auto),
      [],
      [学位论文作者签名:],
      [],
      text("时间: "+year+"年"+month+"月"+day+"日"),
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
      text("时间: "+year+"年"+month+"月"+day+"日"),
    )
    v(2em)
    grid(
      columns: (2em, auto, 1fr, auto),
      [],
      [导师签名:],
      [],
      text("时间: "+year+"年"+month+"月"+day+"日"),
    )

    // if draft{ }else{
    //   place(top+left, dx: 47%, dy: 72%, rotate(-24deg, image("./CAU_Stamp.png", width: 100pt)))
    //   place(top+left, dx: 47%, dy: 25%, rotate(-24deg, image("./CAU_Stamp.png", width: 100pt)))
    // }
    // if(signature != ""){
    //   place(top+left, dx: 29%, dy: 25%, image("../"+signature, width: 100pt))
    //   place(top+left, dx: 29%, dy: 68%, image("../"+signature, width: 100pt))
    // }

    pagebreak()
  }

  let abstractpage={
    set page(numbering: "I")
    counter(page).update(1)

    align(center)[
      #heading(outlined: true, level: 1, numbering:none, [摘要])]
      set par(justify: true)
      [#h(2em) #abstract_zh]
  
    align(center)[
      #heading(outlined: false, level: 1, numbering: none, [Abstract])]
      set par(justify: true)
      [#abstract_en]
  }

  let contentspage={
    set page(numbering: "I")
    show outline: set heading(level: 1, outlined: true)
    outline(depth: outlineDepth, indent: n => [#h(2em)] * n, title: [目录])
  }

  let illustrationspage={
    // set text(font: sunfont, size: 12pt)
    set page(numbering: "I")
    // set par(leading: 12pt)
    heading(level: 1, numbering: none)[插图和附表清单]
    outline(title:none, target: figure)
  }

  let acronymspage={
    // set text(font: sunfont, size: 12pt)
    set page(numbering: "I")
    // set par(leading: 12pt)
    heading(level: 1, numbering: none)[缩略词表]

    set text(font: ("Times New Roman", "SimHei"), size: 10.5pt)
    line(length: 100%); v(-0.5em)
    grid(columns: (20%, 1fr, 30%), align(center)[缩略词], [英文全称], align(center)[中文全称])
    v(-0.5em); line(length: 100%)
    set text(font: ("Times New Roman", "SimSun"), size: 10.5pt)
    locate(loc => usedAcronyms.final(loc)
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
    )
    line(length: 100%)

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
        #locate(loc => {
          let eloc = query(selector(heading).after(loc), loc).at(0).location()
          query(selector(heading.where(level:1)).before(eloc), eloc).last().body.text
        })
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
          #text(font: ("Times New Roman","Microsoft YaHei"), weight: "bold", 16pt)[#it.body]
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
          #v(12pt, weak: false)
          #text(font: ("Times New Roman","SimHei"), 12pt, weight: "regular")[#it]
          #v(12pt, weak: false)
        ]
      }
      par()[#text(size:0.0em)[#h(0em)]]
    }

    set figure.caption(separator: [. ])
    show figure.where(supplement: [表]): set figure.caption(position: top)
    show figure.caption: set text(font:("Times New Roman","SimHei"), 9pt)
    show figure: it => {
      set text(font:("Times New Roman","SimSun"), 9pt)
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

    body
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

