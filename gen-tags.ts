import { isLatest } from "./dockerhub.ts";
import Version from "./version.ts";

const ref = Deno.env.get("GITHUB_REF")?.slice(11) as string;
console.log(`ghcr.io/x2ox/gitlab-db:v${ref}`);

const ok = await isLatest(new Version(ref));
if (ok) {
  console.log(`ghcr.io/x2ox/gitlab-db:latest`);
}
