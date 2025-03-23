return {
	s("frag", t('<!-- element class="fragment" -->')),
	s("temp", {
		t('<!-- slide template="[['),
		i(1),
		(t(']]" -->')),
		i(0),
	}),
	s("end", t("<!-- end_slide -->")),
	s("pause", t("<!-- pause -->")),
	s(
		"cll",
		fmt([[<!-- column_layout: [{},{}] -->]], {
			i(1),
			i(2),
		})
	),
	s(
		"col",
		fmt([[<!-- column: {} -->]], {
			i(1),
		})
	),
	s("res", t("<!-- reset_layout -->")),
	s(
		"ilist",
		fmt([[<!-- incremental_lists: {} -->]], {
			c(1, { t("true"), t("false") }),
		})
	),
}
