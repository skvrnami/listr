context("Test academic titles parsing")

test_that("Academic titles are parsed correctly", {
    expect_equal(extract_titles("prof. Karel Novák"), "prof.")
    expect_equal(extract_titles("prof. Karel Novák Ph.D."), "prof. Ph.D.")
    expect_equal(extract_titles("Mgr. Karel Novák"), "Mgr.")
    expect_equal(extract_titles("prom.fyzik Karel Novák"), "prom.fyzik")
    expect_equal(extract_titles("Karel Novák"), "")
    expect_equal(extract_titles("Karel Novák MBA LLM"), "MBA LLM")
    expect_equal(extract_titles("Karel Novák D.I.C."), "DIC")
    expect_equal(extract_titles("Karel Novák MSc"), "MSc")
    expect_equal(extract_titles("Karel Novák DiS."), "DiS.")
    expect_equal(extract_titles("genmjr. Karel Novák"), "genmjr.")
    expect_equal(extract_titles("JUDr. PhDr. Mgr. et Mgr. Henryk Lahola"),
                 "JUDr. PhDr. Mgr. et Mgr.")
})

test_that("Rest of the string before academic titles is extracted correctly", {
    expect_equal(extract_text_before_titles("Karel Novák prof."), "Karel Novák")
    expect_equal(extract_text_before_titles("Karel Novák LLM MBA"), "Karel Novák")
    expect_equal(extract_text_before_titles("Karel Novák"), "Karel Novák")
    expect_equal(extract_text_before_titles("Novák ml. Karel"), "Novák Karel")
})

test_that("The recoding of titles returns the highest attained title", {
    expect_equal(as.character(recode_titles("prof. Karel Novák CSc.")), "Professor")
    expect_equal(as.character(recode_titles("Karel Novák Ph.D.")), "Doctor")
    expect_equal(as.character(recode_titles("Karel Novák LLM MBA")), "Master")
    expect_equal(as.character(recode_titles("Karel Novák")), "No title")
    expect_equal(as.character(recode_titles("Novák ml. Karel")), "No title")
    expect_true(recode_titles("Karel Novák") < recode_titles("Mgr. Karel Novák"))
})
