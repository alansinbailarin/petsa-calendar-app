export function debounce(fn: Function, wait: number) {
  let timer: ReturnType<typeof setTimeout>;
  return function (this: unknown, ...args: any[]) {
    if (timer) {
      clearTimeout(timer);
    }
    const context = this;
    timer = setTimeout(() => {
      fn.apply(context, args);
    }, wait);
  };
}
