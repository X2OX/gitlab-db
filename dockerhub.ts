import Version from "./version.ts";

export interface DockerTagsResponse {
  count: number;
  next: string;
  results: {
    name: string;
    digest: string;
  }[];
}

export async function getGitLabVersion() {
  const resp = await fetch(
    "https://registry.hub.docker.com/v2/repositories/gitlab/gitlab-ee/tags/?page_size=100&page=1&name&ordering",
  );
  const data = await resp.json() as DockerTagsResponse;

  const arr = data.results.map(({ name }) => {
    if (name === "latest" || name === "rc" || name === "nightly") return "";
    if (name.startsWith("15.")) return "";
    if (!name.endsWith("-ee.0")) {
      console.log("unsupported version", name);
      return "";
    }
    return name.slice(0, name.length - 5);
  }).filter((v) => v !== "");

  return arr.map((v) => new Version(v));
}

export async function isLatest(v: Version) {
  const resp = await fetch(
    "https://registry.hub.docker.com/v2/repositories/gitlab/gitlab-ee/tags/?page_size=100&page=1&name&ordering",
  );
  const data = await resp.json() as DockerTagsResponse;

  const diff = {
    latestDigest: "",
    currentDigest: "",
  };
  data.results.forEach(({ name, digest }) => {
    if (name === "latest") {
      diff.latestDigest = digest;
      return;
    }
    if (!name.endsWith("-ee.0")) return;
    if (v.toString() === name.slice(0, name.length - 5)) {
      diff.currentDigest = digest;
      return;
    }
  });

  return diff.latestDigest !== "" && diff.latestDigest === diff.currentDigest;
}
