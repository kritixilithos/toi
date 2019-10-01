∇ output←input(args Toi)code;k;E;ps;pl;pm;pt;p;s;prog;toi
	⍝https://esolangs.org/wiki/Toi
	k←{⍺⍵}
	E←{⍞←'Error: ',⍵⋄→}

	⍝parse_set
	ps←{
		'e'≡⊃⍵:(1↓⍵)⍬
		'<>'≡2↑⍵:(2↓⍵)⍬
		~'<e'∊⍨⊃1↓⍵:E 'expected `>`'
		i r←ps 1↓⍵
		1≢'<>e'∊⍨⊃i:E 'unexpected `',(⊃i),'`'
		I R←ps '<',i
		I k (⊂r)∪R
	}

	⍝parse_loop
	pl←{
		i r←⍵
		n←'-'≡⊃i
		I R←p ((n+1)↓i) ⍬
		t←⊃I
		1≢t∊'[{':E '`[` or `{` expected'
		J S←p (1↓I) ⍬
		(⊃J)≢mt←']}'['[{'⍳t]:E 'expected `',mt,'`'
		(1↓J) k t n R S
	}

	⍝parse_minus
	pm←{
		i r←⍵
		(,'-')≡i:E '`-` right operand missing'
		'<e'∊⍨2⊃i:{⊂'-',⍵}@2⊢pt(1↓i)r
		'('≡2⊃i:pl i ⍬
	}

	⍝token
	pt←{
		i r←⍵
		'<e'∊⍨⊃i:{⊂'s',⍵}@2⊢ps i
		'-'≡⊃i:pm i ⍬
		'('≡⊃i:pl i ⍬
		'Endrau.:'∊⍨⊃i:(1↓i) k ⊃i
		i ''
	}

	⍝parse
	p←{i r←pt⍵⋄i k (2⊃⍵),⊂r}⍣{(1≡'[{}]'∊⍨⊃⊃⍺)∨''≡⊃⍺}

	⍝step
	s←{
		⍬≡⍵:⍺
		c←⊃in←⍵
		c≡'-':⍺~1↓2⊃⍵
		c≡'s':⍺∪1↓⍵
		c≡'{':∪{res←⍵prog R⋄~⍣n⊢(,0)≢⍴res:⍵prog S⋄⍵}¨⍺⊣t n R S←in
		⍝recursion to make ⍣ not run cond with (f⍵)
		c≡'[':{(⍵prog S)s in}⍣(~⍣n⊢(,0)≢⍴⍺prog R)⊢⍺⊣t n R S←in
		c∊'.:':⍺⊣⎕←c ⍝was ⍞←c
		c≡'n':⍺⊣⎕←'' ⍝was ⍞←⎕ucs 10
		c≡'u':,⊂⍺
		c≡'d':⍺⊣⎕←d ⍺
		c≡'a':⍺∪⊃∪/⍺
		c≡'r':⊃∪/⍺
		⍺
	}

	prog←{⊃{q w←⍵⋄(q s⊃w)(1↓w)}⍣{⍬≡⊃2⊃⍺}⍺(⍵,⊂⍬)}

	toi←{
		i r←p(⍵∩'<>-({}[].:eEndrau')⍬
		''≢i:E 'parse error'
		⍬ prog (r,⊂⍬)
	}

	output←{args≡'j':⎕json⍵⋄args≡'d':display⍵⊣'display'⎕cy'dfns'⋄⍬}toi⊃⎕NGET code
∇
