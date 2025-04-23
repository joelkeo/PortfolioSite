#lang pollen

<head>
  <meta charset="UTF-8">
  <title></title>
  <link rel="stylesheet" type="text/css" href="style.css" />
</head>

◊; Grainferno >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define GFDEMO (DS (Video "https://www.youtube.com/embed/_madxtR7E30?si=GmM1NFfWLiS0FQs6")
                    (H1 "Demo Video: Crazy Sounds")))
◊(define GFDSP (DS (P
"A realtime .vst synthesizer must process input MIDI and return an audio buffer in < 1ms.
This meant that I had to be extremely careful about even the tiniest of details. Stack frame creation,
 conditionals, memory allocation, and complex operations needed to be avoided or optimized. I used
profiling tools to eliminate bottlenecks, and used precomputed LUT buffers,
lazy modulator computation, and other techniques to ensure glitch-free audio and low CPU usage.")
                    (H1 "DSP & Realtime Capabilities")))
◊(define GFMOD (DS (P "Modern synths often offer flexible, drag and drop modulations, and grainferno is no exception.
Such flexibility means that DSP computations cannot work with static (per buffer) parameter values:
modulations must first be applied, from various sources. Additionally, the state of these modulators may
differ per synth voice.")
                   (H1 "Modular System")))
◊(define GFDIST (DS (P
"From the very beginning, grainferno was designed for the end-user in mind. This means it needs to be usable
even for users with no programming, and limited systems and synthesizer knowlege. Every beta, I've made sure
the .vst3 or .au file would automatically pass validations and not trigger any serious anti-malware. I've also
made various release and demo videos, explaining how to install and use the software. All of this has been
organized via discord, where users (over 400) can also provide feedback regarding bugs or feature suggestions")
                    (H1 "Distribution")))
◊(define GFGUI (DS (P "I designed the GUI to be unique and interactive, while still being intuitive. Grain generation feedback is
shown over the sample window (grain position, amplitude, and compression) and behind the envelopes
(waveform of the most recently generated game. Modulation amounts are also displayed, and LFOs and drawable.")
                   (H1 "GUI")))
◊(define GFNOVELTY (DS (P  "I wanted grainferno to provide high quality sound and an intuivitve interface, but also some brand new
features for users to play with. Initially this was \"tonal granulation\": the ability to generate grains at
audio rate, keytracked to the note being played. This required grain positions to be able to exist between sample positions
(solved with sinc interpolation/fractional delays). However, months into development, Serum 2 brought this exact
feature to users with an even more powerful modulation system, and additional FX. To remain competitive, I developed
\"Granular Compression\", a novel granular feature, which compresses individual grain upwards in volume.")
                       (H1 "Novelty")))
◊(define GrainfernoExplanation (P "Grainferno is a tool for music producers to warp and generate new sounds with.
Its is a .vst3/.au granular synthesizer with tonal granulation and
 modulation capabilities, written in C++/JUCE. The DSP, the Modulation System, & the vast majority of the
GUI were written and designed from scratch."))
◊(define GrainfernoSections (Group GrainfernoExplanation GFDSP GFMOD GFDIST GFGUI GFNOVELTY GFDEMO))
◊(define Grainferno (DS GrainfernoSections (H1 "Grainferno")))

◊; INERTIA   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
◊(define InertiaDescription (Group (P "Open Source MIDI fx plugin built from scratch, using concept
 of rhythm phase & rate to generate arpeggios with dynamic tempos that align to the host at the start & end.
The Repo has a great explanation of the logic behind it, as well as all of the code!")
                                   (A (P "github") "https://github.com/joelkeo/ERG")))
◊(define Inertia (DS InertiaDescription (H1 "Inertia")))

◊(define Subtitle (P "Hi, I'm a Software Developer, check out my projects"))
◊(define Projects (Group Subtitle Grainferno Inertia))
◊(define Joel (DS Projects (H1 "Joel Keohane")))
◊(Page Joel)
