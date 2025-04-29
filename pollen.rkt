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
(define expBase 5/8)
(define (Style . styles)
  (sa "\""
      (foldr (lambda (f r) (sa f ";" r)) "" styles)
      "\""))
(define noStyle (lambda (depth) "\"\""))
(define (H1Style depth)
  (Style
   (format "font-size: ~apx" (* 150. (expt expBase depth)))
   (format "margin-left: ~apx" (* 64. (expt expBase depth)))
   (format "margin-top: ~apx" (* 32. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))
   "display : inline-block"))
(define (H3Style depth)
  (Style
   "color: rgba(199, 192, 191, .5)" 
   (format "font-size: ~apx" (* 50. (expt expBase depth)))
   (format "margin-left: ~apx" (* 64. (expt expBase depth)))
   (format "margin-top: ~apx" (* 32. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))
   "display : inline"))
(define (AnimationStyle depth)
  (Style
   (format "font-size: ~apx" (* 300. (expt expBase depth)))
   (format "margin-left: ~apx" (* 64. (expt expBase depth)))
   (format "margin-top: ~apx" (* 32. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))
   "text-align: right"
   "display : inline"))
(define (PStyle depth)
  (Style
   (format "font-size: ~apx" (* 100. (expt expBase depth)))
   ; (format "margin-left: ~apx" (* 128. (expt expBase depth)))
   (format "margin-top: ~apx" (* 8. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))))
(define (DetailsStyle depth)
  (let ([margin (if (zero? depth) 0 (* 128. (expt expBase depth)))])
  (Style
   (format "border: ~apx solid #c7c0bf" (* 8. (expt expBase depth)))
   (if (zero? depth) "" "border-right: 0")
   (if (zero? depth) "" "border-bottom: 0")
   (format "width: ~a" (if (zero? depth) "70%" "100%"))
   ; (format "margin-left: ~apx" margin)
   "list-style: none")))
(define (ContentDivStyle depth)
   (let ([margin (if (zero? depth) 0 (* 128. (expt expBase depth)))])
     (Style
      (format "width: ~a" (if (zero? depth) "80%" (format "width: calc(100% - ~apx)" margin)))
      (format "margin-left: ~apx" margin))))
(define (SummaryStyle depth)
  (Style
   (format "list-style: none")))
(define (ImgStyle depth)
  (Style
   (format "width : 65%")
   "text-align: right"
   "vertical-align: middle"
   "display: inline"))
(define (HalfWidthContainerStyle depth)
  (Style
   ""))
(define (HalfWidthImageStyle depth)
  (Style
    "width: 50%"))
(define (ImgWideStyle depth)
  (Style
    "width: 99%"))
(define (VideoHolderStyle depth)
   (Style
    "position: relative"
    "width: 100%"
    "padding-bottom: 23.125%"
    "height: 0"
    "overflow: hidden"))
(define (VideoStyle depth)
  (Style
   "position: absolute"
   "width: 50%"
   "height: 100%"
   "overflow: hidden"))


(define (FlexStyle depth)
  (Style
     "display: flex"))
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
(define Summary (tfR "summary" SummaryStyle sub1))
(define (DivWStyle style)
  (tfR "div" style (lambda (x)x)))
(define ContentDiv (DivWStyle ContentDivStyle))
(define HalfWidthContainer (DivWStyle HalfWidthContainerStyle))
(define Column (DivWStyle ColumnStyle))
(define Row (DivWStyle RowStyle))
(define Flex (DivWStyle FlexStyle))
; list of DHTML -> DHTML
(define (Group . contentList)
  (lambda (depth)
    (foldr (lambda (f r) (sa (f depth) r)) "" contentList)))
; STRUCTURE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; Details Summary Macro
(define (DS content summary)
  (Details (Group (Summary summary) (ContentDiv content))))
(define (Page dhtmlContent)
  (dhtmlContent 0))
;; Title Subtitle Macro
(define (TitleSubtitle title subtitle)
  (Group (H1 title) (H3 subtitle)))
;; Rows and Column
(define (Rows . rows)
  (lambda (depth)
    (foldr (lambda (f r) (sa ((Row f) depth) r)) "" rows)))

(define (Columns . columns)
  (lambda (depth)
    (foldr (lambda (f r) (sa ((Column f) depth) r)) "" columns)))