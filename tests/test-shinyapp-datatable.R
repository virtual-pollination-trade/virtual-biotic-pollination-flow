app <- ShinyDriver$new("../")
app$snapshotInit("test-shinyapp-datatable")

app$setInputs(year = "2001")
app$setInputs(colormap = "HDI")
app$setInputs(destination = character(0))
app$setInputs(destination = "Brazil")
app$snapshot()
