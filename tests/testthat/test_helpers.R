context("Test helpers")

test_that("capitalization works properly", {
    expect_equal(capitalize("KAREL NOVÁK"), "Karel Novák")
    expect_equal(capitalize("KAREL Novák"), "Karel Novák")
    expect_equal(capitalize("ŘEHOŘ NOVÁK"), "Řehoř Novák")
    expect_equal(capitalize("JANA NOVÁKOVÁ-ŘEHOŘOVÁ"), "Jana Nováková Řehořová")
})
