#lang racket
; INCLUDES >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(require pollen/tag)
(provide (all-defined-out))
; BASIC HELPERS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(define sa string-append)
(define (lsa l) (foldr sa "" l))
;; TYPE DEPTHPROP : (INT -> INT) tldr how depth is propogated to element body
;; TYPE DHTML     : (INT -> HTML)
;; TYPE DCSS      : (INT -> CSS STYLE)
;; tag function generator (creates a curried function which takes in content ( then depth)
;; tfR : HTMLTAG DCSS -> (DHTML -> DHTML)
(define (tfR tag dcss depthprop)
  (lambda (content)
    (lambda (depth)
      ;; Here I inject depth propogation logic
      (format "<~a style = ~a> ~a </~a>" tag (dcss depth) (content (depthprop depth)) tag))))

;; w/ attribute
(define (tfRA tag dcss depthprop)
  (lambda (content attributeText)
    (lambda (depth)
      ;; Here I inject depth propogation logic
      (format "<~a style = ~a ~a> ~a </~a>" tag (dcss depth) attributeText
              (content (depthprop depth)) tag))))

;; tfB : HTMLTAG DCSS -> (HTML -> DHTML)
(define (tfB tag dcss)
  (lambda (content)
    (lambda (depth)
      (format "<~a style = ~a> ~a </~a>" tag (dcss depth) content tag))))

;; tfBV : HTMLTAG StringAtts -> (HTML -> DHTML)
;; for self closing tags
(define (tfBV tag dcss)
  (lambda (atts)
    (lambda (depth)
      (format "<~a style = ~a ~a/>" tag (dcss depth) atts))))
; TAGS STYLES >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(define expBase .8)
(define (Style . styles)
  (sa "\""
      (foldr (lambda (f r) (sa f ";" r)) "" styles)
      "\""))
(define noStyle (lambda (depth) "\"\""))
;; exponentialSize font :: THIS IS FROM PIXELS BUT CONVERTS TO VW

(define (vwSize start depth)
  (let ([baseVW (/ start 25.6)])
    (/ (* (expt expBase depth) start) 25.6)))

(define (standardSize start depth)
  (let ([size (* (expt expBase depth) start)])
    (pxToStandard size)))

(define (pxToStandard px)
  (format "~arem" (/ px 18.)))

(define (fontSize start depth)
  (format "font-size: ~a" (standardSize start depth)))

(define (H1Style depth)
  (Style
   (format "font-size: ~a" (pxToStandard (if (= 2 depth) 150 (* 150. (expt expBase depth)))))
   (format "margin-left: ~a" (standardSize 64 depth))
   (format "margin-top: ~a" (standardSize 32 depth))
   (format "margin-bottom: ~a" (standardSize 32. depth))
   "display : inline-block"
   (format "color: rgba(230, 226, 226, ~a)" (expt expBase (/ depth 2)))
))
(define (H3Style depth)
  (Style
   "color: rgba(199, 192, 191, .5)" 
   (fontSize 50 depth)
   (format "margin-left: ~a" (standardSize 64 depth))
   (format "margin-top: ~a" (standardSize 32 depth))
   (format "margin-bottom: ~a" (standardSize 32 depth))
   (format "margin-right: ~a" (standardSize 32 depth))
   "display : inline"
   "text-align: right"))
(define (AnimationStyle depth)
  (Style
   (format "font-size: ~a" (standardSize 300 depth))
   (format "margin-left: ~a" (standardSize 64 depth))
   (format "margin-top: ~a" (standardSize 32 depth))
   (format "margin-bottom: ~a" (standardSize 32 depth))
   "text-align: right"
   "display : inline"))
(define (PStyle depth)
  (Style
   (format "font-size: ~a" (standardSize 76 depth))
   (format "margin-top: ~a" (standardSize 64 depth))
   (format "margin-bottom: ~a" (standardSize 64 depth))
   (format "color: rgba(167, 161, 151, ~a)" (expt expBase (/ depth 2)))
   "font-weight: 100"
   ;"text-shadow: 0px 0px 1px rgba(0, 0, 0, 0.1)"
   "line-height: 1.5"
   (format "background-color: rgb(238, 202, 227, ~a)" (* .1 (expt expBase (/ depth 2))))
   (format "padding: ~a" (standardSize 64 depth))))
(define (DetailsStyle depth)
  (let ([margin (if (zero? depth) 0 (standardSize 76 depth))])
  (Style
   (if (zero? depth) "" "border-right: 0")
   (if (zero? depth) "" "border-bottom: 0")
   (format "width: ~a" (if (zero? depth) "60%" "100%"))
   "list-style: none"
   "margin-top: 0"
   "margin-bottom: 0"
   "margin-left: 0")))
(define (ContentDivStyle depth)
   (let ([margin (if (zero? depth) 0 (* 128 (expt expBase depth)))])
     (Style
      (format "width: ~a" (if (zero? depth) "80%" (format "calc(100% - ~a)" (pxToStandard (* 2 margin)))))
      (format "margin-left: ~a" (pxToStandard margin))
      (format "margin-top: ~a" (pxToStandard (* .5 margin))))))
(define (SummaryStyle depth)
  (Style
    (format "border-bottom: ~a solid #c7c0bfaa" (standardSize 8 depth)) 
   "margin-top: 0"
   "margin-bottom: 0"
   "list-style: none"
   "border-radius: 0"
    (format "margin-bottom: ~a" (standardSize 128 depth))
   ))
(define (ImgStyle depth)
  (Style
   (format "width : 45%")
   "text-align: right"
   "vertical-align: middle"
   "display: inline"
   (format "border: ~a solid #c7c0bfaa" (standardSize 4 depth))))
(define (HalfWidthContainerStyle depth)
  (Style
   ""))
(define (HalfWidthImageStyle depth)
  (Style
    "width: 50%"))
(define (ImgWideStyle depth)
  (Style
    "width: 100%"))
(define (VideoHolderStyle depth)
   (Style
    "position: relative"
    "width: 100%"
    "padding-bottom: 46.25%"
    "height: 0"
    "overflow: hidden"
    (format "margin-bottom: ~a" (standardSize 64 depth))))
(define (VideoStyle depth)
  (Style
   "position: absolute"
   "width: 100%"
   "height: 100%"
   "overflow: hidden"))
(define (FlexStyle depth)
  (Style
     "display: flex"
     "align-items: center"))
(define (ColumnStyle depth)
  (Style
     "display: flex"
     "flex-direction: column"
     "justify-content: center"
     "margin: 10px" ))
(define (RowStyle depth)
  (Style
     "display: flex"
     "flex-direction: row"
     "justify-content: center"
     "margin: 10px" ))
(define (PageStyle depth)
  (Style
   "width: 90%"
   "min-width: "
   "margin: 0 auto"
   "max-width: 1300px"
   "min-width: 320px"))
(define (LeftFlexStyle depth)
  (Style
   "flex: 0 1 auto"
))
(define (RightFlexStyle depth)
  (Style
   "flex: 1" 
   "min-width: 100px"
   "text-align: right"
))
; TAGS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(define H1 (tfB "h1" H1Style))
(define H3 (tfB "h3" H3Style))
(define P (tfB "p" PStyle))
(define A (lambda (name link) ((tfRA "a" noStyle identity) name (format "href = \" ~a \"" link))))
(define Animation
  (lambda (id)
    ((tfRA "h2" AnimationStyle identity) (Group) (format "id = \"~a\"" id))))
(define VideoAtts "src=\" ~a \" title=\"YouTube video player\"
frameborder=\"0\" allow=\"accelerometer;
autoplay; clipboard-write; encrypted-media;
gyroscope; picture-in-picture; web-share\"
referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen")
(define Video (lambda (src)
                ((DivWStyle VideoHolderStyle )((tfRA "iframe" VideoStyle identity) (Group) (format VideoAtts src)))))
(define (Audio src type)
  (lambda (n)
    (format "<audio controls> <source src = \"~a\" type = \"audio/~a\"> </audio>" src type)))
(define (ImgWStyle style)
  (lambda (src)
    ((tfBV "img" style) (format "src = \"~a\"" src))))
(define Img
  (lambda (src)
    ((tfBV "img" ImgStyle) (format "src = \"~a\"" src))))
(define ImgWide (ImgWStyle ImgWideStyle))
(define Details (tfR "details" DetailsStyle add1))
(define DetailsA (tfRA "details" DetailsStyle add1))
(define Summary (tfR "summary" SummaryStyle sub1))
(define (DivWStyle style)
  (tfR "div" style (lambda (x)x)))
(define ContentDiv (DivWStyle ContentDivStyle))
(define HalfWidthContainer (DivWStyle HalfWidthContainerStyle))
(define Column (DivWStyle ColumnStyle))
(define Row (DivWStyle RowStyle))
(define Flex (DivWStyle FlexStyle))
(define LeftFlex (DivWStyle LeftFlexStyle))
(define RightFlex (DivWStyle RightFlexStyle))
; list of DHTML -> DHTML
(define (Group . contentList)
  (lambda (depth)
    (foldr (lambda (f r) (sa (f depth) r)) "" contentList)))
; STRUCTURE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; Details Summary Macro
(define (DS content summary)
  (Details (Group (Summary summary) (ContentDiv content))))
;; w/ ID
(define (DSWID content summary id)
  (DetailsA (Group (Summary summary) (ContentDiv content)) (format "id = \"~a\"" id)))
;; open details
(define (DSOPEN content summary)
  (DetailsA (Group (Summary summary) (ContentDiv content)) "open"))
(define (Page dhtmlContent)
  (((DivWStyle PageStyle) dhtmlContent) 2))
;; Title Subtitle Macro
(define (TitleSubtitle title subtitle)
  (LeftAndRight (H1 title) (H3 subtitle)))
;; Rows and Column
(define (Rows . rows)
  (lambda (depth)
    (foldr (lambda (f r) (sa ((Row f) depth) r)) "" rows)))
(define (Columns . columns)
  (lambda (depth)
    (foldr (lambda (f r) (sa ((Column f) depth) r)) "" columns)))
;; where left takes up max space, right takes upmin
(define (LeftAndRight left right)
  (Flex
   (Group
    (LeftFlex left)
    (RightFlex right))))