{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Text.Greek.Mounce.NounThirdDeclension where

import Text.Greek.Grammar
import Text.Greek.Mounce.Morphology
import Text.Greek.Mounce.Quote

thirdDeclensionNouns :: [Cited Noun]
thirdDeclensionNouns = 
  [ mounce §§ ["n-3a(1)"] $
    Noun "Stems ending in π"
      [nounCaseEndings|
        ψ   πες
        πος πων
        πι  ψι
        πα  πας
        ψ   πες
      |]
      [greekWords|
        Αἰθίοψ κώνωψ λαῖλαψ μώλωψ σκόλοψ
      |]
  , mounce §§ ["n-3a(2)"] $
    Noun "Stems ending in β"
      [nounCaseEndings|
        ψ   βες
        βος βων
        βι  ψι
        βα  βας
        ψ   βες
      |]
      [greekWords|
        Ἄραψ λίψ
      |]
  , mounce §§ ["n-3b(1)"] $
    Noun "Stems ending in κ"
      [nounCaseEndings|
        ξ   κες
        κος κων
        κι  ξι
        κα  κας
        ξ   κες
      |]
      [greekWords|
        ἀλώπηξ ἄνθραξ γυνή δεσμοφύλαξ θώραξ
        κῆρυξ κίλιξ κόραξ ὄρνιξ πίναξ
        πλάξ σάρξ σκώληξ Φῆλιξ Φοῖνιξ
        φοῖνιξ φύλαξ χάραξ χοῖνιξ
      |]
  , mounce §§ ["n-3b(2)"] $
    Noun "Stems ending in γ"
      [nounCaseEndings|
        ξ   γες
        γος γων
        γι  ξι
        γα  γας
        ξ   γες
      |]
      [greekWords|
        αἴξ ἅρπαξ λάρυγξ μάστιξ πτέρυξ
        σάλπιγξ φάραγξ φλόξ
      |]
  , mounce §§ ["n-3b(3)"] $
    Noun "Stems ending in χ"
      [nounCaseEndings|
        ξ   χες
        χος χων
        χι  ξι
        χα  χας
        ξ   χες
      |]
      [greekWords|
        θρίξ σαρδόνυξ ψίξ
      |]
  , mounce §§ ["n-3c(1)"] $
    Noun "Stems ending in τ"
      [nounCaseEndings|
        ς   τες
        τος των
        τι  σι
        τα  τας
        -   τες
      |]
      [greekWords|
        ἁγιότης ἁγνότης ἀδελφότης ἀδηλότης ἁδρότης
        αἰσχρότης ἀκαθάρτης ἁπλότης ἀφελότης βραδύτης
        γέλως γόης γυμνότης ἑνότης ἐσθής
        εὐθύτης θειότης θεότης ἱδρώς ἱκανότης
        ἱλαρότης ἰσότης Ἰωσῆς καθαρότης καινότης
        Κρής κυριότης λαμπρότης ματαιότης μεγαλειότης
        νεότης νύξ ὁμοιότης ὁσιότης παλαιότης
        πένης πιότης πλάνης πραότης πραΰτης
        σεμνότης σής σκληρότης τελειότης χάρις
        χρηστότης χρώς
      |]
  , mounce §§ ["n-3c(1)"] $
    Noun "Stems ending in τ with accusative, singular ν"
      [nounCaseEndings|
        ς   τες
        τος των
        τι  σι
        ν   τας
        -   τες
      |]
      [greekWords|
        χάρις
      |]
  , mounce §§ ["n-3c(2)"] $
    Noun "Stems ending in δ"
      [nounCaseEndings|
        ς   δες
        δος δων
        δι  σι
        δα  δας
        -   δες
      |]
      [greekWords|
        ἀκρίς Ἀντιπατρίς Ἄρτεμις ἀσπίς ἀτμίς
        βολίς Δάμαρις δισμυριάς Δορκάς Ἑβραΐς
        Ἑλλάς ἐλπίς ἔρις Ἡρῳδιάς θυρίς
        ἴασπις ἰκμάς ἶρις Ἰωσῆς κεφαλίς
        κλείς λαμπάς λεπίς Λωΐς μερίς
        μοιχαλίς μυριάς νῆστις παγίς παῖς
        παραστάτις παροψίς πατρίς Περσίς πινακίς
        πορφυρόπωλις πούς πρεσβῦτις προστάτις προφῆτις
        Πτολεμαΐς ῥαφίς ῥυτίς Σαμαρῖτις σανίς
        σπιλάς σπυρίς στιβάς στοιβάς συγγενίς
        σφραγίς τετράπουν Τιβεριάς Τραχωνῖτις Τρῳάς
        ὑπολαμπάς χιλιάς χλαμύς
      |]
  , mounce §§ ["n-3c(3)"] $
    Noun "Stems ending in θ"
      [nounCaseEndings|
        ς   θες
        θος θων
        θι  σι
        θα  θας
        -   θες
      |]
      [greekWords|
        ὄρνις
      |]
  , mounce §§ ["n-3c(4)"] $
    Noun "Stems ending in ματ"
      [nounCaseEndings|
        -  α
        ος ων
        ι  σι
        -  α
        ς  α
      |]
      [greekWords|
        ἀγνόημα ἀδίκημα αἷμα αἴνιγμα αἴτημα
        αἰτίαμα αἰτίωμα ἀλίσγημα ἁμάρτημα ἀνάθεμα
        ἀνάθημα ἀντάλλαγμα ἀνταπόδομα ἄντλημα ἀπαύγασμα
        ἀπόκριμα ἀποσκίασμα ἅρμα ἄρωμα ἀσθένημα
        βάπτισμα βδέλυγμα βῆμα βλέμμα βούλημα
        βρῶμα γένημα γέννημα γράμμα δεῖγμαδέρμα
        διάδημα διανόημα διάστημα διάταγμα δικαίωμα
        διόρθωμα δόγμα δόμα δῶμα δώρημα
        ἔγκλημα ἑδραίωμα ἔκτρωμα ἕλιγμα ἔνδειγμα
        ἔνδυμα ἐνέργημα ἔνταλμα ἐξέραμα ἐπάγγελμα
        ἐπερώτημα ἐπίβλημα ἐπικάλυμμα ζήτημα ἥττημα
        θαῦμα θέλημα θρέμμα ουμίαμα ἴαμα
        ἱεράτευμα κάθαρμα κάλυμμα κατάθεμα κατάκριμα
        καταλείμμα κατάλυμα κατανάθεμα καταπέτασμα κατάστημα
        κατόρθωμα καῦμα καύχημα κέλευσμα κέρμα
        κήρυγμα κλάσμα κλέμμα κλῆμα κλίμα
        κρίμα κτῆμα κτίσμα κύλισμα κῦμα
        λεῖμμα μεσουράνημα μίασμα μίγμα μίσθωμα
        μνῆμα νόημα νόμισμα νόσημα οἴκημα
        ὁλοκαύτωμα ὄμμα ὁμοίωμα ὄνομα ὅραμα
        ὅρμημα ὀφείλημα ὀχύρωμα πάθημα παράπτωμα
        περικάθαρμα περίσσευμα περίψημα πλάσμα πλέγμα
        πλήρωμα πνεῦμα ποίημα πολίτευμα πόμα
        πρᾶγμα πρόκριμα πρόσκομμα πτύσμα πιῶμα
        ῥᾳδιούργημα ῥάπισμα ῥῆγμα ῥῆμα σέβασμα
        σκέπασμα σκήνωμα σπέρμα στέμμα στερέωμα
        στίγμα στόμα στράτευμα σύντριμμα σχῆμα
        σχίσμα σῶμα τάγμα τραῦμα τρῆμα
        τρύπημα ὑπόδειγμα ὑπόδημα ὑπόλειμμα ὑστέρημα
        ὕψωμα φάντασμα φίλημα φρόνημα φύραμα
        χάραγμα χάρισμα χάσμα χόρτασμα χρῆμα
        χρῖσμα ψεῦσμα
    |]
  , mounce §§ ["n-3c(5)"] $
    Noun "Stems ending in ντ (using ς in the nom. sing.)"
      [nounCaseEndings|
        ς  ες
        ος ων
        ι  σι
        ς  α
        ς  ας
      |]
      [greekWords|
        ἱμάντος
        Κλήμεντος
        Κρήσκεντος
        ὀδόντος
        Πούδεντος
      |]
      {-
        ἱμάς, άντος
        Κλήμης, μεντος
        Κρήσκης, κεντος
        ὀδούς, όντος
        Πούδης, δεντος
      -}
  , mounce §§ ["n-3c(6)"] $
    Noun "Stems ending in ντ (with no ending in the nom. sg.)"
      [nounCaseEndings|
        -  ες
        ος ων
        ι  σι
        -  α
        ς  ας
      |]
      [greekWords|
        ἄρχων γέρων δράκων θεράπων λέων
        Σαλωμών Σολομών Φλέγων
      |]
  ]
