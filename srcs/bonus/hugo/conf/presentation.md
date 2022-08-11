---
title: "Presentation"
date: 2022-08-10T10:46:32Z
draft: false
---

# Welcome to this really small website 🐋

This site has been entirely designed to respond to a bonus from the school 42 inception project.

It has **no other purpose**.

Below is some code from an older project to brighten up this page :

```c++
static bool matchStar(char c, const char *regex, const char *text)
{
    do {
        if (match(text, regex))
            return (true);
    } while (*text != '\0' && (*text++ == c || c == '?'));
    return (false);
}

static bool match(const char *text, const char *regex)
{
    if (regex[0] == '\0')
        return (true);
    if (regex[1] == '*')
        return (matchStar(regex[0], regex + 2, text));
    if (*text != '\0' && (regex[0] == '?' || regex[0] == *text))
        return (match(text + 1, regex + 1));
    return (false);
}
```