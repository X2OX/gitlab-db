import {cleanUnsafe, sort} from "./version.ts";
import {getGitLabVersion} from "./dockerhub.ts";
import {getGCRVersion} from "./github.ts";

const gitlab = cleanUnsafe(await getGitLabVersion())
sort(gitlab);
const data = gitlab.slice(gitlab.length - 3)

const gcr = await getGCRVersion();
const s = new Set(gcr)

const tags = data.map(v => {
    if (!s.has(`v${v.toString()}`)) return v.toString()
    return ''
}).filter(v => v !== '')

console.log(tags);
if (tags.length !== 0) {
    for (const v of tags) {
        await fetch('https://api.github.com/repos/x2ox/gitlab-db/git/refs', {
            body: JSON.stringify({
                "ref": `refs/tags/v${v}`,
                "sha": `${Deno.env.get("GITHUB_SHA")}`
            }),
            headers: {Authorization: `token ${Deno.env.get("GITHUB_TOKEN")}`},
        })
    }
}
