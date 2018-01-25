context("Test name parsing")

test_that("Names are parsed correctly", {
    expect_equal(split_full_name("Novák Karel"),
                 list("Karel", "Novák"))
    expect_equal(split_full_name("Novák Adam", reversed = TRUE, tolerance = 0),
                 list("Adam", "Novák"))
    expect_equal(split_full_name("Petr Pavel", reversed = FALSE, tolerance = 0),
                 list("Petr", "Pavel"))
    expect_equal(split_full_name("Jana Smiggels Kavková", reversed = FALSE),
                 list("Jana", "Smiggels Kavková"))
    expect_equal(split_full_name("Augustin Karel Andrle Sylor", FALSE),
                 list("Augustin Karel", "Andrle Sylor"))
})
