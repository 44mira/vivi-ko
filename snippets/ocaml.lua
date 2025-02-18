return {
	-- inline test
	s(
		"itest",
		fmt([[let%test {} = {}]], {
			c(2, {
				t("_"),
				sn(nil, {
					t('"'),
					i(1),
					t('"'),
				}),
			}),
			i(1),
		})
	),

	-- fold maker
	s(
		"ff",
		fmt(
			[[
(** <> {{{*)
<>
(*}}}*)
    ]],
			{ i(1), i(2) },
			{ delimiters = "<>" }
		)
	),
}
