-- Copyright 2021 Jeremy Wall
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

local base = SILE.baseClass
local plain = SILE.require("plain", "classes")
local resume = plain { id = resume }

SILE.require("packages/url")
SILE.require("packages/pdf")
SILE.require("packages/rules")

-- Setup our settings.
SILE.settings.declare({
    parameter = "resume.author",
    default = "",
    type = "string",
    help = "The author of this resume"
})

SILE.settings.declare({
    parameter = "resume.email",
    default = "",
    type = "string",
    help = "Resume Author email address",
})

SILE.settings.declare({
    parameter = "resume.site",
    default = "",
    type = "string",
    help = "Resume Author website",
})

SILE.settings.declare({
    parameter = "resume.keywords",
    default = "",
    type = "string",
    help = "Resume keywords",
})

SILE.settings.set("document.parindent", SILE.nodefactory.glue())

local simpletable = SILE.require("packages/simpletable")
simpletable.init(SILE.documentState.documentClass, {tableTag = "table", trTag = "tr", tdTag = "td"})

resume.defaultFrameset = {
  content = {
    left = "10%pw",
    right = "90%pw",
    top = "5%ph",
    bottom = "92%ph"
  }
}

resume.endPage = function(self)
    -- We skip calling plains endPage but we still need
    -- to call the base classes endPage callback.
    base.endPage(self)
end


SILE.registerCommand("resume", function(opts, content)
    local author = SILE.settings.get("resume.author")
    if author == "" then
        SILE.warn("resume.author was empty. Author info will be missing.")
    else
        SILE.call("pdf:metadata", {key="Author", val=author}, "")
    end
    local keywords = SILE.settings.get("resume.keywords")
    if keywords == "" then
        SILE.warn("resume.keywords was empty. site keywords will be missing.")
    else
        SILE.call("pdf:metadata", {key="Keywords", val=keywords}, "")
    end
    local email = SILE.settings.get("resume.email")
    if email == "" then
        SILE.warn("resume.email was empty. Email info will be missing.")
    end
    local site = SILE.settings.get("resume.site")
    if site == "" then
        SILE.warn("resume.site was empty. site info will be missing.")
    end

    SILE.call("section", {}, function()
        SILE.typesetter:typeset(author)
    end)

    SILE.call("table", {}, function()
        SILE.call("tr", {}, function() 
            SILE.call("td", {}, function()
                SILE.call("bold", {}, function()
                    SILE.typesetter:typeset("Email: ")
                end)
            end)
            SILE.call("td", {}, function()
                SILE.call("email", {src=email})
            end)
        end)
        SILE.call("tr", {}, function() 
            SILE.call("td", {}, function()
                SILE.call("bold", {}, function()
                    SILE.typesetter:typeset("Site: ")
                end)
            end)
            SILE.call("td", {}, function()
                SILE.call("psite")
            end)
        end)
    end)

    SILE.process(content)
end)

SILE.registerCommand("email", function(opts, content)
    if opts["src"] then
        SILE.call("href", {src="mailto:" .. opts["src"]}, opts["src"])
    else
        SILE.error("src attribute is required")
    end
end)

SILE.registerCommand("site", function(opts, content)
    if opts["src"] then
        SILE.call("href", {src="https://" .. opts["src"]}, opts["src"])
    end
end)

SILE.registerCommand("psite", function(opts, content)
    local site = SILE.settings.get("resume.site")
    if site == "" then
        SILE.warn("resume.site was empty. site info will be missing.")
    end
    SILE.call("site", {src=site}, "")
end)

-- TODO(jwall): Bullet could be way better than it currently is.
resume.registerCommands = function()
    plain.registerCommands()
    SILE.doTexlike([[%
\define[command=section]{\font[size=3em]{\process} \bigskip}%
\define[command=subsection]{\bigskip \font[size=2em]{\process} \bigskip}%
\define[command=bold]{\font[style=bold]{\process}}%
\define[command=para]{\process \medskip}%
\define[command=bullet]{* \process}%
]])
end

return resume