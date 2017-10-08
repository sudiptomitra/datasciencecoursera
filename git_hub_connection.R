library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "967550be82093e86ea64",
                   secret = "a7f2dae4ddfa5cae3b08336313d9be2329e541c1")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)


repo_list <- content(req)

answer1 <- c() 
for (i in 1:length(repo_list)) {
        repo <- repo_list[[i]]
        if (repo$name == "repos") {
                answer1 = repo
                break
        }
}

# Expected output: The repository 'datasharing' was created at 2013-11-07T13:25:07Z
if (length(answer1) == 0) {
        print("No such repository found: 'repos'")
} else {
        print("The repository 'datasharing' was created at", answer1$created_at)
}