#lang pollen

<head>
  <meta charset="UTF-8">
  <title></title>
  <link rel="stylesheet" type="text/css" href="style.css" />
  <script src="emojicon.js" defer></script>
</head>

◊; Grainferno >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define GFDEMO (DS (Video "https://www.youtube.com/embed/_madxtR7E30?si=GmM1NFfWLiS0FQs6")
                    (H1 "Demo Video: Crazy Sounds")))
◊(define GFDSP (DS
(Group (ImgWide "LLCode.png")
(P
"A realtime .vst synthesizer must process input MIDI and return an audio buffer in < 1ms.
This meant that, when designing grainferno, I had to be extremely careful about even the tiniest of details. Stack frame creation,
 conditionals, memory allocation, and complex operations needed to be avoided or optimized. I used
profiling tools to eliminate bottlenecks, and used precomputed LUT buffers,
lazy modulator computation, and other techniques to ensure glitch-free audio and low CPU usage.")

(P
"Much of the DSP is based on sinc-interpolation: this is what allows grains to be dynamically repitched, and also what allows them to \"start\" in-between
 sample positions. However, there were many other more minor DSP consideration, such as Biquad Filtering, Resampling (for audio files which didn't match
 the host sample rate), and RMS calculation for visualization"))
                    (H1 "DSP & Realtime Capabilities")))
◊(define GFMOD (DS
(Group
(ImgWide "gfMod4.gif")(P "Modern synths often offer flexible, drag and drop modulations, and grainferno is no exception. Various modulators have been built-in to grainferno:
Enevelopes, Drawable LFOs, Randomness & More, have been implemented from scratch, & can dynamically be linked to any audio parameter.
Such flexibility means that DSP computations cannot work with static (per buffer) parameter values:
modulations must first be applied, from various sources. Additionally, the state of these modulators may
differ per synth voice. JUCE Parameters are held in a Modulation Matrix class which can load up voice-specific state,
 and then return the modulated parameter values at a specific point in time."))
                   (H1 "Modular System")))
◊(define GFDIST (DS (Group (P
"From the very beginning, grainferno was designed with the end-user in mind. This meant that it needed to be usable
even for users with no programming experience, and limited systems and synthesizer knowlege. For every beta, I've made sure
the .vst3 or .au file would automatically pass validations and not trigger any serious anti-malware. The most recent
 betas have also featured MacOS and Windows installers. I've also
made various release and demo videos, explaining how to install and use the software. All of this has been
organized via discord, where users (over 400) can also provide feedback regarding bugs or feature suggestions.
I plan to release the plugin as a paid product when development has finished. The page for that is already
 in the works!")
                           (A (P "inferno audio site") "https://infernoaud.io/")
(A (P "inferno audio discord") "https://discord.gg/fQj7CRDqTG"))
                    (H1 "Distribution")))
◊(define GFGUI (DS (Group
(ImgWide "wfGif.gif")
 (P "I designed the GUI from scratch to be unique and interactive, while still being intuitive. Grain generation feedback is
shown over the sample window (grain position, amplitude, and compression) shown above, and per grain RMS content is shown behind the envelopes.
 Modulation amounts (live and range) are also displayed, and LFOs are dynamically drawable."))
                   (H1 "GUI")))
◊(define GFNOVELTY (DS (Group (ImgWide "comp.gif")
(P "I wanted grainferno to provide high quality sound and an intuivitve interface, but also some brand new
features for users to play with. Initially this was \"tonal granulation\": the ability to generate grains at
audio rate, keytracked to the note being played. This required grain positions to be able to exist between sample positions
(solved with sinc interpolation/fractional delays). However, months into development, Serum 2 brought this exact
feature to users with an even more powerful modulation system, and additional FX. To remain competitive, I developed
\"Granular Compression\", a novel granular feature, which compresses individual grain upwards in volume."))
                       (H1 "Innovation")))
◊(define GrainfernoVid (Video "https://www.youtube.com/embed/NONVJkHRQGQ?si=I1Oa3icLhFJ5lz0M"))
◊(define GFVID (DS GrainfernoVid
                       (H1 "Overview Video")))

◊(define GFAUDIOS (DS (Group (Audio "grain.wav" "wav")
                             (Audio "Welcome 2 my Wor1d 140bpm.wav" "wav")
                             (Audio "an assortment of textures and cool sounds.wav" "wav")
                             (Audio "final teaser.wav" "wav")
                             (Audio "tweaked spaces.mp3" "mp3")
                             (Audio "berlin 120bpm prod 1kkhei.mp3" "mp3"))
                   (H1 "Made w/ Grainferno, posted to the discord")))
◊(define GSECF (DS (Video "https://www.youtube.com/embed/HE6LvhV38eU?si=8WNUta11MSuxUtSC")
                   (H1 "3 hr user livestream")))
◊(define GFSOCIALPROOF (DS (Group GSECF GFAUDIOS) (H1 "Testimonials/In Use")))
◊(define GrainfernoExplanation (Group
(ImgWide "gif.gif")
(P "Grainferno is a tool for music producers to warp and generate new sounds with - a .vst3/.au granular synthesizer with an internal, drag and drop modulation system,
 written in C++/JUCE. The DSP, the Modulation System, & the GUI were all written and designed from scratch.")))
◊(define GrainfernoSections (Group GrainfernoExplanation GFVID GFDSP GFMOD
                                   GFDIST GFGUI GFNOVELTY GFSOCIALPROOF
                                   GFDEMO))
◊(define Grainferno (DS GrainfernoSections (TitleSubtitle "Grainferno" "independently developed C++/JUCE synthesizer with 400+ users")))

◊; INERTIA   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define InertiaDescription (Group (ImgWide "lilInertia.gif")
(P "Open Source MIDI fx plugin built from scratch, using concept
 of rhythm phase & rate to generate arpeggios with dynamic tempos that align to the host at the start & end.
The Repo has a great explanation of the logic behind it, as well as all of the code!")
                                   (A (P "github") "https://github.com/joelkeo/ERG")))
◊(define Inertia (DS InertiaDescription (TitleSubtitle "Inertia" "open source C++/JUCE realtime arpeggiator")))



◊; NightSnake >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define NightSnakeSlides (Video "https://docs.google.com/presentation/d/e/2PACX-1vRo0LtcL4JlhMUE3sMBzbuZxFla291ZIeSNklyfciFg2uXRD7twy50gcmlQQNXNMZhVLaWdMxLaazwE/pubembed?start=false&loop=false&delayms=60000"))
◊(define NightSnakeContent (Group (P "For my capstone course at Northeastern, I took Compilers, in which we built a course-led programming language throughout the semester called \"Snake\". We wrote the compiler for Snake in OCaml & C, and targetted ASM.
For our final project, we wanted to allow the language (which up to that point had ids, math operations,
lambdas, recursion, and many other features) to deal with BigNums. We came up with what is potentially a novel
approach to computing bigNums, optimizing subtraction and addition by including in the bigNum memory represtation
two carry-bits. You can read more about it in the slides! The multiplication slide is particularly fun.")
                                  NightSnakeSlides))
◊(define NightSnake (DS NightSnakeContent (TitleSubtitle "NightSnake" "extension upon Northeastern's Compilers course language")))


◊; THIS SITE   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define (DeepHelper n)
   (if (zero? n)
     (H1 "bottom")
     (DS (DeepHelper (sub1 n)) (H1 (sa "Infinity")))))
◊(define Deep (DeepHelper 100))
◊(define ThisSiteContent (Group
(ImgWide "ycomb.gif")(P "I used this website an excuse to delve back into Racket. I ended up making a mini HTML/CSS compiler which ...
doesn't necessarily accomplish all that much that can't be done in plain CSS, but was a lot of fun to build.
It was a great functional programming refresher! You can check out the source code on GitHub.")
                               (A (P "github") "https://github.com/joelkeo/PortfolioSite")))
◊(define ThisSite (DS (Group ThisSiteContent Deep) (TitleSubtitle "This Site" "made with a custom HTML/CSS compiler built in Racket")))

◊; PAGE   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define Subtitle (P "I build audio tools and compilers, specializing in C++, JUCE, and functional programming.
Here are some of my favorite projects. Click on a project to expand!"))
◊(define Projects (Group Subtitle Grainferno Inertia NightSnake ThisSite))
◊(define Joel (DSOPEN Projects
(Flex
  (Columns
    ;(Rows (Animation "blinky"))
    (Rows (H1 "Joel Keohane"))
    (Rows (Img "joel.jpeg"))))))
◊(Page Joel)