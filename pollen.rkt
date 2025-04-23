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

;; tfR : HTMLTAG DCSS -> (HTML -> DHTML)
(define (tfB tag dcss)
  (lambda (content)
    (lambda (depth)
      (format "<~a style = ~a> ~a </~a>" tag (dcss depth) content tag))))
; TAGS STYLES >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(define expBase 5/8)
(define (Style . styles)
  (sa "\""
      (foldr (lambda (f r) (sa f ";" r)) "" styles)
      "\""))
(define noStyle (lambda (depth) "\"\""))
(define (H1Style depth)
  (Style
   (format "font-size: ~apx" (* 100. (expt expBase depth)))
   (format "margin-left: ~apx" (* 64. (expt expBase depth)))
   (format "margin-top: ~apx" (* 32. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))
   "display : inline"))
(define (PStyle depth)
  (Style
   (format "font-size: ~apx" (* 100. (expt expBase depth)))
   (format "margin-left: ~apx" (* 128. (expt expBase depth)))
   (format "margin-top: ~apx" (* 8. (expt expBase depth)))
   (format "margin-bottom: ~apx" (* 32. (expt expBase depth)))))
(define (DetailsStyle depth)
  (let ([margin (if (zero? depth) 0 (* 128. (expt expBase depth)))])
  (Style
   (format "border: ~apx solid black" (* 8. (expt expBase depth)))
   (if (zero? depth) "" "border-right: 0")
   (if (zero? depth) "" "border-bottom: 0")
   (format "width: ~a" (if (zero? depth) "80%" (format "width: calc(100% - ~apx)" margin)))
   (format "margin-left: ~apx" margin)
   "list-style: none")))
(define (SummaryStyle depth)
  (Style
   (format "list-style: none")))
; TAGS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
(define H1 (tfB "h1" H1Style))
(define P (tfB "p" PStyle))
(define A (lambda (name link) ((tfRA "a" noStyle identity) name (format "href = \" ~a \"" link))))
(define VideoAtts "<iframe width=\"560\" height=\"315\" src=\" ~a \" title=\"YouTube video player\"
frameborder=\"0\" allow=\"accelerometer;
autoplay; clipboard-write; encrypted-media;
gyroscope; picture-in-picture; web-share\"
referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe>")
(define Video (lambda (src)
                ((tfRA "iframe" noStyle identity) (Group) (format VideoAtts src))))

(define Details (tfR "details" DetailsStyle add1))
(define Summary (tfR "summary" SummaryStyle sub1))
; list of DHTML -> DHTML
(define (Group . contentList)
  (lambda (depth)
    (foldr (lambda (f r) (sa (f depth) r)) "" contentList)))
; STRUCTURE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;; Details Summary Macro
(define (DS content summary)
  (Details (Group (Summary summary) content)))
(define (Page dhtmlContent)
  (dhtmlContent 0))