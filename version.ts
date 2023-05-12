export default class Version {
  major = 0;
  minor = 0;
  patch = 0;

  constructor(s?: string) {
    if (!s || s === "") return;
    if (s.startsWith("v")) s = s.slice(1);

    const arr = s.split(".");
    if (arr.length > 0) this.major = Number(arr[0]);
    if (arr.length > 1) this.minor = Number(arr[1]);
    if (arr.length > 2) this.patch = Number(arr[2]);
  }

  toString(): string {
    return `${this.major}.${this.minor}.${this.patch}`;
  }

  // this < v
  less(v: Version): boolean {
    if (this.major > v.major) return false;
    if (this.major < v.major) return true;

    if (this.minor > v.minor) return false;
    if (this.minor < v.minor) return true;

    if (this.patch > v.patch) return false;

    return this.patch < v.patch;
  }
}

export function sort(array: Version[]): Version[] {
  function _sort(left: number, right: number): void {
    if (left >= right) {
      return;
    }
    const val = array[left];
    let i = left;
    let j = right;

    while (i < j) {
      while (i < j && val.less(array[j])) {
        j--;
      }
      if (i < j) {
        array[i] = array[j];
        i++;
      }
      while (i < j && array[i].less(val)) {
        i++;
      }
      if (i < j) {
        array[j] = array[i];
        j--;
      }
    }
    array[i] = val;
    _sort(left, i - 1);
    _sort(i + 1, right);
  }

  _sort(0, array.length - 1);
  return array;
}

export function cleanUnsafe(arr: Version[]): Version[] {
  const m = new Map<string, number>(); // major.minor : patch
  arr.forEach((v) => {
    const key = `${v.major}.${v.minor}`;
    const val = m.get(key);
    if (!val || val < v.patch) {
      m.set(key, v.patch);
    }
  });

  const res: Version[] = [];
  m.forEach((val, key) => {
    res.push(new Version(`${key}.${val}`));
  });

  return res;
}
