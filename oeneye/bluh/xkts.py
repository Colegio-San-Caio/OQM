def init(grid=(16, 16), block=(16, 16)):
    print(f"[BLUH.XKTS] init grid={grid} block={block} by book")
    class Runtime:
        def load(self, name):
            print(f"[BLUH.XKTS] Loaded target: {name}")
            return self
        def exec(self, cmd):
            print(f"[BLUH.XKTS] Executing: {cmd}")
            return self
    return Runtime()
