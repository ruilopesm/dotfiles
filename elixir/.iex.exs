clear()

IEx.configure(
  colors: [
    eval_result: [:green, :bright] ,
    eval_error: [:red, :bright],
    eval_info: [:yellow, :bright],
 ],
 default_prompt: [
  "\e[G",
  :red,
  "|%counter|",
  :blue,
  ">>>",
  :reset
  ] |> IO.ANSI.format |> IO.chardata_to_string
)
