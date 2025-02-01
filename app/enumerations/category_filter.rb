class CategoryFilter < EnumerateIt::Base~
  associate_values(
    who: 0,
    when: 1,
    where: 2,
    how_much: 3
  )
end
