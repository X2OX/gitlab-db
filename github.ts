interface Data {
  id: number;
  name: string;
  url: string;
  package_html_url: string;
  created_at: string;
  updated_at: string;
  html_url: string;
  metadata: Metadata;
}

interface Metadata {
  package_type: string;
  container: Container;
}

interface Container {
  tags: string[];
}

export async function getGCRVersion() {
  let page = 1;
  const arr: string[] = [];

  while (true) {
    const resp = await fetch(
      `https://api.github.com/orgs/x2ox/packages/container/gitlab-db/versions?active=active&per_page=100&page=${page}`,
      {
        headers: { Authorization: `token ${Deno.env.get("GITHUB_TOKEN")}` },
      },
    );
    const data = await resp.json() as Data[];
    if (data.length === 0) break;

    data.forEach((v) => {
      if (v.metadata.container.tags.length !== 0) {
        arr.push(...v.metadata.container.tags);
      }
    });
    page++;
  }

  return arr;
}
