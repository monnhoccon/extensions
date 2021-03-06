local id, page = ...
if text:is_empty(page) then
    page = 1
end

local doc = http:get("https://blogtruyen.vn/ajax/Category/AjaxLoadMangaByCategory"):params({["id"] = id, ["orderBy"] = "1", ["p"] = page}):html()

if doc ~= nil then
    local el = doc:select(".list .tiptip")
    local novelList = {}
    local next

    local last = doc:select(".paging > .current_page + .page"):last()
    if last ~= nil then
        next = last:text()
    end

    for i = 0, el:size() - 1 do
        local e = el:get(i)
        local id = e:attr("data-tiptip")

        local info = doc:select("#" .. id)
        local novel = {
            ["name"] = e:select("a"):text(),
            ["link"] =  e:select("a"):attr("href"),
            ["cover"] = info:select("img"):attr("src"),
            ["host"] = "https://blogtruyen.vn"
        }
        table.insert(novelList, novel)
    end

    return response:success(novelList, next)
end

return nil