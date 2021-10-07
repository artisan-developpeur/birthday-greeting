Class {
	#name : #Main,
	#superclass : #Object,
	#category : #'DMObirthdayGreeting-pharoSmalltalk'
}

{ #category : #accessing }
Main class >> main [

	| fileName firstLine line tokens date today lineNb |
	"le fichier doit être copier dans le dossier de l'image pour y accéder simplement par son nom"
	[ 
	fileName := 'employees.txt'.
	fileName asFileReference readStreamDo: [ :fileReader | 
		Transcript
			show: 'Reading file...';
			cr.
		firstLine := true.
		lineNb := 1.
		[ 
		line := fileReader nextLine.
		line isNotNil ] whileTrue: [ 
			firstLine
				ifTrue: [ firstLine := false ]
				ifFalse: [ 
					lineNb := lineNb + 1.
					tokens := (line substrings: ',') collect: [ :token | token trim ].
					tokens size = 4
						ifTrue: [ 
							date := (tokens at: 3) substrings: '/'.
							"today := Date today ddmmyyyy substrings: '/'."
							today := '12/11/1900' substrings: '/'.
							date size = 3
								ifTrue: [ 
									((date at: 1) = (today at: 1) and: [ 
										 (date at: 2) = (today at: 2) ]) ifTrue: [ 
										self
											sendMailTo: (tokens at: 4)
											title: 'Joyeux Anniversaire ! '
											body: 'Bonjour ' , (tokens at: 1)
												, ',<n>Joyeux Anniversaire !<n>A bientôt,' expandMacros ] ]
								ifFalse: [ 
									Transcript
										show:
											'Cannot read birthdate for ' , (tokens at: 1) , ' '
											, (tokens at: 2);
										cr ] ]
						ifFalse: [ 
							Transcript
								show: 'Invalid file format on line : ' , lineNb asString;
								cr ] ] ] ] ]
		on: FileException
		do: [ :e | 
			Transcript
				show: 'Problem with file ' , fileName;
				cr;
				show: 'exception : ' , e asString;
				cr ].

	Transcript show: 'Batch job done.'
]

{ #category : #'as yet unclassified' }
Main class >> sendMailTo: to title: title body: body [

	Transcript
		show: 'Sending email to : ' , to;
		cr;
		show: 'Title: ' , title;
		cr;
		show: 'Body: ' , body;
		cr;
		show: '-------------------------';
		cr
]
