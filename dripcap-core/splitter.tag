<drip-splitter-content>
  <yield/>
  <style>
    :scope {
      display: grid;
      overflow: hidden;
    }

    :scope > * {
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
      bottom: 0;
    }
  </style>
</drip-splitter-content>

<drip-splitter-bar>
  <style>
    :scope {
      background-color: var(--color-selection-background);
      -webkit-app-region: no-drag;
    }
  </style>
</drip-splitter-bar>

<drip-splitter-dragarea>
<style>
  :scope {
    -webkit-app-region: no-drag;
  }
</style>
</drip-splitter-dragarea>

<drip-vsplitter>
  <drip-splitter-content>
    <yield from="top"/>
  </drip-splitter-content>
  <drip-splitter-bar onmousedown={ startDrag } onmouseup={ stopDrag }></drip-splitter-bar>
  <drip-splitter-dragarea show={ dragging } onmouseup={ stopDrag } onmouseout={ stopDrag } onmousemove={ move }></drip-splitter-dragarea>
  <drip-splitter-content>
    <yield from="bottom"/>
  </drip-splitter-content>
  <style>
    :scope > drip-splitter-content:first-child {
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
      bottom: 50%;
    }

    :scope > drip-splitter-bar {
      position: absolute;
      top: 50%;
      left: 0;
      right: 0;
      bottom: 0;
      height: 2px;
      cursor: row-resize;
      z-index: 1;
    }

    :scope > drip-splitter-dragarea {
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
      bottom: 0;
      cursor: row-resize;
      z-index: 2;
    }

    :scope > drip-splitter-content:last-child {
      position: absolute;
      top: 50%;
      right: 0;
      left: 0;
      bottom: 0;
    }
  </style>

  <script>
    this.dragging = false;
    const $ = require('jquery');

    this.on('mount', () => {
      this._top = $(this.root).children('drip-splitter-content:first-child');
      this._bottom = $(this.root).children('drip-splitter-content:last-child');
      this._bar = $(this.root).children('drip-splitter-bar');
      this.updateRatio(opts.ratio || 0.5);
    });

    move(e) {
      let $this = $(this.root);
      let top = $this.offset().top;
      let height = $this.height();
      if (this.dragging) {
        console.log((e.clientY - top), height)
        this.updateRatio((e.clientY - top) / (height - 2));
      }
      e.preventUpdate = true;
      return false;
    }

    shouldUpdate(force) {
      return !this.dragging || force;
    }

    updateRatio(ratio) {
      if (ratio >= 0.05 && ratio <= 0.95) {
        this._top.css('bottom', `${(1-ratio)*100}%`);
        this._bottom.css('top', `${ratio*100}%`);
        this._bar.css('top', `${ratio*100}%`);
      }
    }

    startDrag() {
      this.dragging = true;
      this.update(true);
      return false;
    }

    stopDrag() {
      this.dragging = false;
      this.update(true);
      return false;
    }
  </script>
</drip-vsplitter>

<drip-hsplitter>
  <drip-splitter-content>
    <yield from="left"/>
  </drip-splitter-content>
  <drip-splitter-bar onmousedown={ startDrag } onmouseup={ stopDrag }></drip-splitter-bar>
  <drip-splitter-dragarea show={ dragging } onmouseup={ stopDrag } onmouseout={ stopDrag } onmousemove={ move }></drip-splitter-dragarea>
  <drip-splitter-content>
    <yield from="right"/>
  </drip-splitter-content>
  <style>
    :scope > drip-splitter-content:first-child {
      position: absolute;
      top: 0;
      right: 50%;
      left: 0;
      bottom: 0;
    }

    :scope > drip-splitter-bar {
      position: absolute;
      top: 0;
      left: 50%;
      right: 0;
      bottom: 0;
      width: 2px;
      cursor: col-resize;
      z-index: 1;
    }

    :scope > drip-splitter-dragarea {
      position: absolute;
      top: 0;
      right: 0;
      left: 0;
      bottom: 0;
      cursor: row-resize;
      z-index: 2;
    }

    :scope > drip-splitter-content:last-child {
      position: absolute;
      top: 0;
      left: 50%;
      right: 0;
      bottom: 0;
    }
  </style>

  <script>
    this.dragging = false;
    const $ = require('jquery');

    this.on('mount', () => {
      this._left = $(this.root).children('drip-splitter-content:first-child');
      this._right = $(this.root).children('drip-splitter-content:last-child');
      this._bar = $(this.root).children('drip-splitter-bar');
      this.updateRatio(opts.ratio || 0.5);
    });

    shouldUpdate(force) {
      return !this.dragging || force;
    }

    move(e) {
      let $this = $(this.root);
      let left = $this.offset().left;
      let width = $this.width();
      if (this.dragging) {
        this.updateRatio((e.clientX - left) / width);
      }
      e.preventUpdate = true;
      return false;
    }

    updateRatio(ratio) {
      if (ratio >= 0.05 && ratio <= 0.95) {
        this._left.css('right', `${(1-ratio)*100}%`);
        this._right.css('left', `${ratio*100}%`);
        this._bar.css('left', `${ratio*100}%`);
      }
    }

    startDrag() {
      this.dragging = true;
      this.update(true);
      return false;
    }

    stopDrag() {
      this.dragging = false;
      this.update(true);
      return false;
    }
  </script>
</drip-hsplitter>