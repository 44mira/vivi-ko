return {
	s("frag", t('<!-- element class="fragment" -->')),
	s("temp", {
		t('<!-- slide template="[['),
		i(1),
		(t(']]" -->')),
		i(0),
	}),
}
