"
I am a failed match of my specification at a given word of the arguments sequence.
"
Class {
	#name : 'ClapMismatch',
	#superclass : 'ClapWordMatch',
	#category : 'Clap-Core-Activation',
	#package : 'Clap-Core',
	#tag : 'Activation'
}

{ #category : 'accessing' }
ClapMismatch >> at: identifierOrSpec [
	^ specification at: identifierOrSpec
		ifPresent: [ :spec | ClapImplicit of: spec in: self ]
]

{ #category : 'matching' }
ClapMismatch >> completeMatchOn: aStream [
	word := aStream peek.
	startIndex := aStream position + 1.
]

{ #category : 'testing' }
ClapMismatch >> ifMatch: matchingBlock ifMismatch: mismatchBlock [
	^ mismatchBlock cull: self
]

{ #category : 'testing' }
ClapMismatch >> isValid [
	^ false
]

{ #category : 'testing' }
ClapMismatch >> isValid: aValidation [

	^ aValidation isValidMismatch: self
]

{ #category : 'printing' }
ClapMismatch >> printDetailsOn: aStream [
	aStream
		print: specification;
		nextPutAll: ' mismatched'.
	word
		ifNil: [ aStream nextPutAll: ' (nothing to match)' ]
		ifNotNil: [
			aStream
				nextPutAll: ' word ''';
				nextPutAll: word;
				nextPutAll: '''' ]
]

{ #category : 'adding' }
ClapMismatch >> recordIn: parentMatch [ 
	"this match failed, so do nothing"
]

{ #category : 'accessing' }
ClapMismatch >> subcommands [

	^ #()
]

{ #category : 'accessing' }
ClapMismatch >> value [
	^ self
]
