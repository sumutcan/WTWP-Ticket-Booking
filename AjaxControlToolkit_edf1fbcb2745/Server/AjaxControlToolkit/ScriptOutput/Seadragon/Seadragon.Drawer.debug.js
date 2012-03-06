// (c) 2010 CodePlex Foundation
Type.registerNamespace('Sys.Extended.UI.Seadragon');
Type.registerNamespace('Seadragon');


var QUOTA = 100;    // the max number of images we should keep in memory
var MIN_PIXEL_RATIO = 0.5;  // the most shrunk a tile should be


var browser = Seadragon.Utils.getBrowser();
var browserVer = Seadragon.Utils.getBrowserVersion();

var subpixelRenders = browser == Seadragon.Browser.FIREFOX ||
            browser == Seadragon.Browser.OPERA ||
            (browser == Seadragon.Browser.SAFARI && browserVer >= 4) ||
            (browser == Seadragon.Browser.CHROME && browserVer >= 2);

var useCanvas =
            typeof (document.createElement("canvas").getContext) == "function" &&
            subpixelRenders;
Sys.Extended.UI.Seadragon.Tile = function(level, x, y, bounds, exists, url) {
    this.level = level;
    this.x = x;
    this.y = y;
    this.bounds = bounds;   // where this tile fits, in normalized coordinates
    this.exists = exists;   // part of sparse image? tile hasn't failed to load?
    this.loaded = false;    // is this tile loaded?
    this.loading = false;   // or is this tile loading?



    this.elmt = null;       // the HTML element for this tile
    this.image = null;      // the Image object for this tile
    this.url = url;         // the URL of this tile's image


    this.style = null;      // alias of this.elmt.style
    this.position = null;   // this tile's position on screen, in pixels
    this.size = null;       // this tile's size on screen, in pixels
    this.blendStart = null; // the start time of this tile's blending
    this.opacity = null;    // the current opacity this tile should be
    this.distance = null;   // the distance of this tile to the viewport center
    this.visibility = null; // the visibility score of this tile

    this.beingDrawn = false; // whether this tile is currently being drawn
    this.lastTouchTime = 0; // the time that tile was last touched
}
Sys.Extended.UI.Seadragon.Tile.prototype = {
    dispose: function() {
    },
    toString: function() {
        return this.level + "/" + this.x + "_" + this.y;
    },
    drawHTML: function(container) {
        if (!this.loaded) {
            Seadragon.Debug.error("Attempting to draw tile " + this.toString() +
                    " when it's not yet loaded.");
            return;
        }

        if (!this.elmt) {
            this.elmt = Seadragon.Utils.makeNeutralElement("img");
            this.elmt.src = this.url;
            this.style = this.elmt.style;
            this.style.position = "absolute";
            this.style.msInterpolationMode = "nearest-neighbor";
        }

        var elmt = this.elmt;
        var style = this.style;
        var position = this.position.apply(Math.floor);
        var size = this.size.apply(Math.ceil);


        if (elmt.parentNode != container) {
            container.appendChild(elmt);
        }

        style.left = position.x + "px";
        style.top = position.y + "px";
        style.width = size.x + "px";
        style.height = size.y + "px";

        Seadragon.Utils.setElementOpacity(elmt, this.opacity);
    },
    drawCanvas: function(context) {
        if (!this.loaded) {
            Seadragon.Debug.error("Attempting to draw tile " + this.toString() +
                    " when it's not yet loaded.");
            return;
        }

        var position = this.position;
        var size = this.size;

        context.globalAlpha = this.opacity;
        context.drawImage(this.image, position.x, position.y, size.x, size.y);
    },
    unload: function() {
        if (this.elmt && this.elmt.parentNode) {
            this.elmt.parentNode.removeChild(this.elmt);
        }

        this.elmt = null;
        this.image = null;
        this.loaded = false;
        this.loading = false;
    }
}
Sys.Extended.UI.Seadragon.Tile.registerClass('Sys.Extended.UI.Seadragon.Tile', null, Sys.IDisposable);

Sys.Extended.UI.Seadragon.Overlay = function(elmt, loc, placement) {
    this.elmt = elmt;
    this.scales = (loc instanceof Sys.Extended.UI.Seadragon.Rect);
    this.bounds = new Sys.Extended.UI.Seadragon.Rect(loc.x, loc.y, loc.width, loc.height);
    this.placement = loc instanceof Sys.Extended.UI.Seadragon.Point ? placement : Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT;    // rects are always top-left
    this.position = new Sys.Extended.UI.Seadragon.Point(loc.x, loc.y);
    this.size = new Sys.Extended.UI.Seadragon.Point(loc.width, loc.height);
    this.style = elmt.style;
}
Sys.Extended.UI.Seadragon.Overlay.prototype = {

    adjust: function(position, size) {
        switch (this.placement) {
            case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT:
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP:
                position.x -= size.x / 2;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_RIGHT:
                position.x -= size.x;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.RIGHT:
                position.x -= size.x;
                position.y -= size.y / 2;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM_RIGHT:
                position.x -= size.x;
                position.y -= size.y;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM:
                position.x -= size.x / 2;
                position.y -= size.y;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM_LEFT:
                position.y -= size.y;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.LEFT:
                position.y -= size.y / 2;
                break;
            case Sys.Extended.UI.Seadragon.OverlayPlacement.CENTER:
            default:
                position.x -= size.x / 2;
                position.y -= size.y / 2;
                break;
        }
    },
    destroy: function() {
        var elmt = this.elmt;
        var style = this.style;

        if (elmt.parentNode) {
            elmt.parentNode.removeChild(elmt);
        }

        style.top = "";
        style.left = "";
        style.position = "";

        if (this.scales) {
            style.width = "";
            style.height = "";
        }
    },
    drawHTML: function(container) {
        var elmt = this.elmt;
        var style = this.style;
        var scales = this.scales;

        if (elmt.parentNode != container) {
            container.appendChild(elmt);
        }

        if (!scales) {
            this.size = Seadragon.Utils.getElementSize(elmt);
        }

        var position = this.position;
        var size = this.size;

        this.adjust(position, size);

        position = position.apply(Math.floor);
        size = size.apply(Math.ceil);

        style.left = position.x + "px";
        style.top = position.y + "px";
        style.position = "absolute";

        if (scales) {
            style.width = size.x + "px";
            style.height = size.y + "px";
        }
    },
    update: function(loc, placement) {
        this.scales = (loc instanceof Sys.Extended.UI.Seadragon.Rect);
        this.bounds = new Sys.Extended.UI.Seadragon.Rect(loc.x, loc.y, loc.width, loc.height);
        this.placement = loc instanceof Sys.Extended.UI.Seadragon.Point ?
                placement : Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT;    // rects are always top-left
    }

}
Sys.Extended.UI.Seadragon.Overlay.registerClass('Sys.Extended.UI.Seadragon.Overlay', null, Sys.IDisposable);

Sys.Extended.UI.Seadragon.Drawer = function(source, viewport, elmt) {

	this._container = Seadragon.Utils.getElement(elmt);
	this._canvas = Seadragon.Utils.makeNeutralElement(useCanvas ? "canvas" : "div");
	this._context = useCanvas ? this._canvas.getContext("2d") : null;
	this._viewport = viewport;
	this._source = source;
	this.config = this._viewport.config;

	this._imageLoader = new Sys.Extended.UI.Seadragon.ImageLoader(this.config.imageLoaderLimit);
	this._profiler = new Sys.Extended.UI.Seadragon.Profiler();

	this._minLevel = source.minLevel;
	this._maxLevel = source.maxLevel;
	this._tileSize = source.tileSize;
	this._tileOverlap = source.tileOverlap;
	this._normHeight = source.dimensions.y / source.dimensions.x;

	this._cacheNumTiles = {};     // 1d dictionary [level] --> Point
	this._cachePixelRatios = {};  // 1d dictionary [level] --> Point
	this._tilesMatrix = {};       // 3d dictionary [level][x][y] --> Tile
	this._tilesLoaded = [];       // unordered list of Tiles with loaded images
	this._coverage = {};          // 3d dictionary [level][x][y] --> Boolean

	this._overlays = [];          // unordered list of Overlays added
	this._lastDrawn = [];         // unordered list of Tiles drawn last frame
	this._lastResetTime = 0;
	this._midUpdate = false;
	this._updateAgain = true;


	this.elmt = this._container;


	this._init();
}
Sys.Extended.UI.Seadragon.Drawer.prototype = {
    dispose: function() {
    },
    _init: function() {
        this._canvas.style.width = "100%";
        this._canvas.style.height = "100%";
        this._canvas.style.position = "absolute";
        this._container.style.textAlign = "left";    // explicit left-align
        this._container.appendChild(this._canvas);
    },
    _compareTiles: function(prevBest, tile) {
        if (!prevBest) {
            return tile;
        }

        if (tile.visibility > prevBest.visibility) {
            return tile;
        } else if (tile.visibility == prevBest.visibility) {
            if (tile.distance < prevBest.distance) {
                return tile;
            }
        }

        return prevBest;
    },
    _getNumTiles: function(level) {
        if (!this._cacheNumTiles[level]) {
            this._cacheNumTiles[level] = this._source.getNumTiles(level);
        }

        return this._cacheNumTiles[level];
    },

    _getPixelRatio: function(level) {
        if (!this._cachePixelRatios[level]) {
            this._cachePixelRatios[level] = this._source.getPixelRatio(level);
        }

        return this._cachePixelRatios[level];
    },


    _getTile: function(level, x, y, time, numTilesX, numTilesY) {
        if (!this._tilesMatrix[level]) {
            this._tilesMatrix[level] = {};
        }
        if (!this._tilesMatrix[level][x]) {
            this._tilesMatrix[level][x] = {};
        }

        if (!this._tilesMatrix[level][x][y]) {
            var xMod = (numTilesX + (x % numTilesX)) % numTilesX;
            var yMod = (numTilesY + (y % numTilesY)) % numTilesY;
            var bounds = this._source.getTileBounds(level, xMod, yMod);
            var exists = this._source.tileExists(level, xMod, yMod);
            var url = this._source.getTileUrl(level, xMod, yMod);

            bounds.x += 1.0 * (x - xMod) / numTilesX;
            bounds.y += this._normHeight * (y - yMod) / numTilesY;

            this._tilesMatrix[level][x][y] = new Sys.Extended.UI.Seadragon.Tile(level, x, y, bounds, exists, url);
        }

        var tile = this._tilesMatrix[level][x][y];

        tile.lastTouchTime = time;

        return tile;
    },

    _loadTile: function(tile, time) {
        tile.loading = this._imageLoader.loadImage(tile.url,
                    Seadragon.Utils.createCallback(null, Function.createDelegate(this, this._onTileLoad), tile, time));
    },

    _onTileLoad: function(tile, time, image) {
        tile.loading = false;

        if (this._midUpdate) {
            Seadragon.Debug.error("Tile load callback in middle of drawing routine.");
            return;
        } else if (!image) {
            Seadragon.Debug.log("Tile " + tile + " failed to load: " + tile.url);
            tile.exists = false;
            return;
        } else if (time < this._lastResetTime) {
            Seadragon.Debug.log("Ignoring tile " + tile + " loaded before reset: " + tile.url);
            return;
        }

        tile.loaded = true;
        tile.image = image;

        var insertionIndex = this._tilesLoaded.length;

        if (this._tilesLoaded.length >= QUOTA) {
            var cutoff = Math.ceil(Math.log(this._tileSize) / Math.log(2));

            var worstTile = null;
            var worstTileIndex = -1;

            for (var i = this._tilesLoaded.length - 1; i >= 0; i--) {
                var prevTile = this._tilesLoaded[i];

                if (prevTile.level <= this._cutoff || prevTile.beingDrawn) {
                    continue;
                } else if (!worstTile) {
                    worstTile = prevTile;
                    worstTileIndex = i;
                    continue;
                }

                var prevTime = prevTile.lastTouchTime;
                var worstTime = worstTile.lastTouchTime;
                var prevLevel = prevTile.level;
                var worstLevel = worstTile.level;

                if (prevTime < worstTime ||
                            (prevTime == worstTime && prevLevel > worstLevel)) {
                    worstTile = prevTile;
                    worstTileIndex = i;
                }
            }

            if (worstTile && worstTileIndex >= 0) {
                worstTile.unload();
                insertionIndex = worstTileIndex;
            }
        }

        this._tilesLoaded[insertionIndex] = tile;
        this._updateAgain = true;
    },

    _clearTiles: function() {
        this._tilesMatrix = {};
        this._tilesLoaded = [];
    },



    /**
    * Returns true if the given tile provides coverage to lower-level tiles of
    * lower resolution representing the same content. If neither x nor y is
    * given, returns true if the entire visible level provides coverage.
    * 
    * Note that out-of-bounds tiles provide coverage in this sense, since
    * there's no content that they would need to cover. Tiles at non-existent
    * levels that are within the image bounds, however, do not.
    */
    _providesCoverage: function(level, x, y) {
        if (!this._coverage[level]) {
            return false;
        }

        if (x === undefined || y === undefined) {
            var rows = this._coverage[level];
            for (var i in rows) {
                if (rows.hasOwnProperty(i)) {
                    var cols = rows[i];
                    for (var j in cols) {
                        if (cols.hasOwnProperty(j) && !cols[j]) {
                            return false;
                        }
                    }
                }
            }

            return true;
        }

        return (this._coverage[level][x] === undefined ||
                    this._coverage[level][x][y] === undefined ||
                    this._coverage[level][x][y] === true);
    },

    /**
    * Returns true if the given tile is completely covered by higher-level
    * tiles of higher resolution representing the same content. If neither x
    * nor y is given, returns true if the entire visible level is covered.
    */
    _isCovered: function(level, x, y) {
        if (x === undefined || y === undefined) {
            return this._providesCoverage(level + 1);
        } else {
            return (this._providesCoverage(level + 1, 2 * x, 2 * y) &&
                        this._providesCoverage(level + 1, 2 * x, 2 * y + 1) &&
                        this._providesCoverage(level + 1, 2 * x + 1, 2 * y) &&
                        this._providesCoverage(level + 1, 2 * x + 1, 2 * y + 1));
        }
    },

    /**
    * Sets whether the given tile provides coverage or not.
    */
    _setCoverage: function(level, x, y, covers) {
        if (!this._coverage[level]) {
            Seadragon.Debug.error("Setting coverage for a tile before its " +
                        "level's coverage has been reset: " + level);
            return;
        }

        if (!this._coverage[level][x]) {
            this._coverage[level][x] = {};
        }

        this._coverage[level][x][y] = covers;
    },

    /**
    * Resets coverage information for the given level. This should be called
    * after every draw routine. Note that at the beginning of the next draw
    * routine, coverage for every visible tile should be explicitly set. 
    */
    _resetCoverage: function(level) {
        this._coverage[level] = {};
    },


    _compareTiles: function(prevBest, tile) {
        if (!prevBest) {
            return tile;
        }

        if (tile.visibility > prevBest.visibility) {
            return tile;
        } else if (tile.visibility == prevBest.visibility) {
            if (tile.distance < prevBest.distance) {
                return tile;
            }
        }

        return prevBest;
    },


    _getOverlayIndex: function(elmt) {
        for (var i = this._overlays.length - 1; i >= 0; i--) {
            if (this._overlays[i].elmt == elmt) {
                return i;
            }
        }

        return -1;
    },


    _updateActual: function() {
        this._updateAgain = false;

        var _canvas = this._canvas;
        var _context = this._context;
        var _container = this._container;
        var _useCanvas = useCanvas;
        var _lastDrawn = this._lastDrawn;

        while (_lastDrawn.length > 0) {
            var tile = _lastDrawn.pop();
            tile.beingDrawn = false;
        }

        var viewportSize = this._viewport.getContainerSize();
        var viewportWidth = viewportSize.x;
        var viewportHeight = viewportSize.y;

        _canvas.innerHTML = "";
        if (_useCanvas) {
            _canvas.width = viewportWidth;
            _canvas.height = viewportHeight;
            _context.clearRect(0, 0, viewportWidth, viewportHeight);
        }

        var viewportBounds = this._viewport.getBounds(true);
        var viewportTL = viewportBounds.getTopLeft();
        var viewportBR = viewportBounds.getBottomRight();
        if (!this.config.wrapHorizontal &&
                    (viewportBR.x < 0 || viewportTL.x > 1)) {
            return;
        } else if (!this.config.wrapVertical &&
                    (viewportBR.y < 0 || viewportTL.y > this._normHeight)) {
            return;
        }




        var _abs = Math.abs;
        var _ceil = Math.ceil;
        var _floor = Math.floor;
        var _log = Math.log;
        var _max = Math.max;
        var _min = Math.min;
        var alwaysBlend = this.config.alwaysBlend;
        var blendTimeMillis = 1000 * this.config.blendTime;
        var immediateRender = this.config.immediateRender;
        var minDimension = this.config.minZoomDimension;   // for backwards compatibility
        var minImageRatio = this.config.minImageRatio;
        var wrapHorizontal = this.config.wrapHorizontal;
        var wrapVertical = this.config.wrapVertical;

        if (!wrapHorizontal) {
            viewportTL.x = _max(viewportTL.x, 0);
            viewportBR.x = _min(viewportBR.x, 1);
        }
        if (!wrapVertical) {
            viewportTL.y = _max(viewportTL.y, 0);
            viewportBR.y = _min(viewportBR.y, this._normHeight);
        }

        var best = null;
        var haveDrawn = false;
        var currentTime = new Date().getTime();

        var viewportCenter = this._viewport.pixelFromPoint(this._viewport.getCenter());
        var zeroRatioT = this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(0), false).x;
        var optimalPixelRatio = immediateRender ? 1 : zeroRatioT;

        minDimension = minDimension || 64;
        var lowestLevel = _max(this._minLevel, _floor(_log(minDimension) / _log(2)));
        var zeroRatioC = this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(0), true).x;
        var highestLevel = _min(this._maxLevel,
                    _floor(_log(zeroRatioC / MIN_PIXEL_RATIO) / _log(2)));

        lowestLevel = _min(lowestLevel, highestLevel);

        for (var level = highestLevel; level >= lowestLevel; level--) {
            var drawLevel = false;
            var renderPixelRatioC = this._viewport.deltaPixelsFromPoints(
                        this._source.getPixelRatio(level), true).x;     // note the .x!

            if ((!haveDrawn && renderPixelRatioC >= MIN_PIXEL_RATIO) ||
                        level == lowestLevel) {
                drawLevel = true;
                haveDrawn = true;
            } else if (!haveDrawn) {
                continue;
            }

            this._resetCoverage(level);

            var levelOpacity = _min(1, (renderPixelRatioC - 0.5) / 0.5);
            var renderPixelRatioT = this._viewport.deltaPixelsFromPoints(
                        this._source.getPixelRatio(level), false).x;
            var levelVisibility = optimalPixelRatio /
                        _abs(optimalPixelRatio - renderPixelRatioT);

            var tileTL = this._source.getTileAtPoint(level, viewportTL);
            var tileBR = this._source.getTileAtPoint(level, viewportBR);
            var numTiles = this._getNumTiles(level);
            var numTilesX = numTiles.x;
            var numTilesY = numTiles.y;
            if (!wrapHorizontal) {
                tileBR.x = _min(tileBR.x, numTilesX - 1);
            }
            if (!wrapVertical) {
                tileBR.y = _min(tileBR.y, numTilesY - 1);
            }

            for (var x = tileTL.x; x <= tileBR.x; x++) {
                for (var y = tileTL.y; y <= tileBR.y; y++) {
                    var tile = this._getTile(level, x, y, currentTime, numTilesX, numTilesY);
                    var drawTile = drawLevel;

                    this._setCoverage(level, x, y, false);

                    if (!tile.exists) {
                        continue;
                    }

                    if (haveDrawn && !drawTile) {
                        if (this._isCovered(level, x, y)) {
                            this._setCoverage(level, x, y, true);
                        } else {
                            drawTile = true;
                        }
                    }

                    if (!drawTile) {
                        continue;
                    }

                    var boundsTL = tile.bounds.getTopLeft();
                    var boundsSize = tile.bounds.getSize();
                    var positionC = this._viewport.pixelFromPoint(boundsTL, true);
                    var sizeC = this._viewport.deltaPixelsFromPoints(boundsSize, true);

                    if (!this._tileOverlap) {
                        sizeC = sizeC.plus(new Sys.Extended.UI.Seadragon.Point(1, 1));
                    }

                    var positionT = this._viewport.pixelFromPoint(boundsTL, false);
                    var sizeT = this._viewport.deltaPixelsFromPoints(boundsSize, false);
                    var tileCenter = positionT.plus(sizeT.divide(2));
                    var tileDistance = viewportCenter.distanceTo(tileCenter);

                    tile.position = positionC;
                    tile.size = sizeC;
                    tile.distance = tileDistance;
                    tile.visibility = levelVisibility;

                    if (tile.loaded) {
                        if (!tile.blendStart) {
                            tile.blendStart = currentTime;
                        }

                        var deltaTime = currentTime - tile.blendStart;
                        var opacity = _min(1, deltaTime / blendTimeMillis);
                        
                        if (alwaysBlend) {
                            opacity *= levelOpacity;
                        }

                        tile.opacity = opacity;

                        _lastDrawn.push(tile);

                        if (opacity == 1) {
                            this._setCoverage(level, x, y, true);
                        } else if (deltaTime < blendTimeMillis) {
                            updateAgain = true;
                        }
                    } else if (tile.Loading) {
                    } else {
                        best = this._compareTiles(best, tile);
                    }
                }
            }

            if (this._providesCoverage(level)) {
                break;
            }
        }

        for (var i = _lastDrawn.length - 1; i >= 0; i--) {
            var tile = _lastDrawn[i];

            if (_useCanvas) {
                tile.drawCanvas(_context);
            } else {
                tile.drawHTML(_canvas);
            }

            tile.beingDrawn = true;
        }

        var numOverlays = this._overlays.length;
        for (var i = 0; i < numOverlays; i++) {
            var overlay = this._overlays[i];
            var bounds = overlay.bounds;

            overlay.position = this._viewport.pixelFromPoint(bounds.getTopLeft(), true);
            overlay.size = this._viewport.deltaPixelsFromPoints(bounds.getSize(), true);
            overlay.drawHTML(_container);
        }

        if (best) {
            this._loadTile(best, currentTime);
            this._updateAgain = true; // because we haven't finished drawing, so
        }
    },


    addOverlay: function(elmt, loc, placement) {
        var elmt = Seadragon.Utils.getElement(elmt);

        if (this._getOverlayIndex(elmt) >= 0) {
            return;     // they're trying to add a duplicate overlay
        }

        this._overlays.push(new Sys.Extended.UI.Seadragon.Overlay(elmt, loc, placement));
        this._updateAgain = true;
    },

    updateOverlay: function(elmt, loc, placement) {
        var elmt = Seadragon.Utils.getElement(elmt);
        var i = this._getOverlayIndex(elmt);

        if (i >= 0) {
            this._overlays[i].update(loc, placement);
            this._updateAgain = true;
        }
    },

    removeOverlay: function(elmt) {
        var elmt = Seadragon.Utils.getElement(elmt);
        var i = this._getOverlayIndex(elmt);

        if (i >= 0) {
            this._overlays[i].destroy();
            this._overlays.splice(i, 1);
            this._updateAgain = true;
        }
    },

    clearOverlays: function() {
        while (this._overlays.length > 0) {
            this._overlays.pop().destroy();
            this._updateAgain = true;
        }
    },


    needsUpdate: function() {
        return this._updateAgain;
    },

    numTilesLoaded: function() {
        return this._tilesLoaded.length;
    },

    reset: function() {
        this._clearTiles();
        this._lastResetTime = new Date().getTime();
        this._updateAgain = true;
    },

    update: function() {
        this._profiler.beginUpdate();
        this._midUpdate = true;
        this._updateActual();
        this._midUpdate = false;
        this._profiler.endUpdate();
    },

    idle: function() {
    }
}
Sys.Extended.UI.Seadragon.Drawer.registerClass('Sys.Extended.UI.Seadragon.Drawer', null, Sys.IDisposable);

