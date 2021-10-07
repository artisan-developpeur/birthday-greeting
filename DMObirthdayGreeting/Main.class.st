Class {
	#name : #Main,
	#superclass : #Object,
	#category : #DMObirthdayGreeting
}

{ #category : #accessing }
Main class >> main [

	"(date at: 1) = (today at: 1) and: [(date at: 2) = (today at: 2) ]"

	| fileName firstLine line tokens date today |
	"le fichier doit être copier dans le dossier de l'image pour y accéder simplement par son nom"
	[ 
	fileName := 'employees.txt'.
	fileName asFileReference readStreamDo: [ :fileReader | 
			Transcript
				show: 'Reading file...';
				cr.
			firstLine := true.
			[ [ line := fileReader nextLine ] value ~= nil ] whileTrue: [ 
				firstLine
					ifTrue: [ firstLine := false ]
					ifFalse: [ 
						tokens := (line substrings: ',') collect: [ :token | token trim ].
						tokens size = 4
							ifTrue: [ 
								date := (tokens at: 3) substrings: '/'.
								"today := Date today ddmmyyyy substrings: '/'."
								today := '30/03/1970' substrings: '/'.
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
										Exception signal:
											'Cannot read birthdate for ' , (tokens at: 1) , ' '
											, (tokens at: 2) ] ]
							ifFalse: [ Exception signal: 'Invalid file format' ] ] ] ] ]
		on: FileDoesNotExistException
		do: [ 
			Transcript
				show: 'Unable to open file ' , fileName;
				cr ];
		on: FileException
		do: [ Transcript show: 'Error reading file ' , fileName ].
	"	fileReader close."
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
