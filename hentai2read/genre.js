function execute() {
    const doc = Http.get("https://hentai2read.com/hentai-list").html();
    const el = doc.select("div.block-header > ul > li:nth-child(3) > ul > li a");
    const data = [];
    for (var i = 0; i < el.size(); i++) {
        var e = el.get(i);
        data.push({
           title: e.text(),
           input: e.attr('href')+'all/name-az/',
           script: 'gen.js'
        });
    }
    return Response.success(data);
}