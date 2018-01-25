context("Test parsing gender")

test_that("Gender is parsed accurately", {
    expect_equal(parse_person_gender("Karel", "Novák", 0), "Male")
    expect_equal(parse_person_gender("Jana", "Nováková", 0), "Female")
    expect_equal(parse_person_gender("Kateřina", "Jacques", 0), "Female")
    expect_equal(parse_person_gender("Anna-Veronika", "Nováková", 0), "Female")
    expect_equal(parse_person_gender("Karel Maria", "Remarque", 0), "Male")
})
