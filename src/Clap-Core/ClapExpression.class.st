"
I am a concrete manifestation (a match) of my specification (a ClapParameter) in the context of a specific command-line invocation.

"
Class {
	#name : 'ClapExpression',
	#superclass : 'Object',
	#instVars : [
		'specification'
	],
	#category : 'Clap-Core-Activation',
	#package : 'Clap-Core',
	#tag : 'Activation'
}

{ #category : 'testing' }
ClapExpression class >> isAbstract [
	^ self == ClapExpression
]

{ #category : 'instance creation' }
ClapExpression class >> specification: aParameter [ 
	^ self new
		specification: aParameter;
		yourself
]

{ #category : 'validation' }
ClapExpression >> allValidations [
	^ self context allValidations
]

{ #category : 'accessing' }
ClapExpression >> context [
	^ self subclassResponsibility
]

{ #category : 'evaluating' }
ClapExpression >> exitSuccess [
	^ self context exitSuccess
]

{ #category : 'testing' }
ClapExpression >> ifMatch: aBlock [
	^ self
		ifMatch: aBlock
		ifMismatch: [ self ]
]

{ #category : 'testing' }
ClapExpression >> ifMatch: matchBlock ifMismatch: mismatchBlock [
	^ self subclassResponsibility
]

{ #category : 'testing' }
ClapExpression >> ifMismatch: aBlock [
	^ self
		ifMatch: [ self ]
		ifMismatch: aBlock
]

{ #category : 'testing' }
ClapExpression >> isFullMatch [

	"This method is used to test if flags with positionals are a full match,
	i.e. a matched flag has no positional or its positionals are matched.
	See `ClapNamedMatch >> #isFullMatch` "
	^ true
]

{ #category : 'testing' }
ClapExpression >> isMatch [
	^ self
		ifMatch: [ true ]
		ifMismatch: [ false ]
]

{ #category : 'testing' }
ClapExpression >> isMatchOf: identifierOrSpec [
	^ identifierOrSpec identifiesClapParameter: self specification
]

{ #category : 'testing' }
ClapExpression >> isMismatch [
	^ self
		ifMatch: [ false ]
		ifMismatch: [ true ]
]

{ #category : 'testing' }
ClapExpression >> isValid [
	"Semantic validation, post-parse"
	self flag: 'obsolete?'.
	^ self allValidations isSuccess
]

{ #category : 'validation' }
ClapExpression >> isValid: aValidation [
	
	self subclassResponsibility 
]

{ #category : 'accessing' }
ClapExpression >> specification [
	^ specification
]

{ #category : 'initialization' }
ClapExpression >> specification: anArgumentSpec [ 
	specification := anArgumentSpec
]

{ #category : 'validation' }
ClapExpression >> validate: aClapValidationClass on: aReport [
	"Recursively validate the receiver and any subexpressions, enriching aReport"
	
	self specification
		validate: aClapValidationClass on: aReport match: self
]

{ #category : 'validation' }
ClapExpression >> validateAll [
	"Validate the activation as a whole, or report and exit."
	self context validateAll
]

{ #category : 'validation' }
ClapExpression >> validateOn: aReport [
	"Recursively validate the receiver and any subexpressions, enriching aReport"
	
	self specification
		validate: self on: aReport
]

{ #category : 'evaluating' }
ClapExpression >> value [
	
	^ self value: nil
]

{ #category : 'evaluating' }
ClapExpression >> value: arg [
	^ specification valueFor: self with: arg
]
