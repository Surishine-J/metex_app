'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "5d9ccd8b413228da0d31e7ae40284a9f",
"assets/assets/images/groups/ai.jpg": "7186434c84870f9be6d0466c2d6d4ec9",
"assets/assets/images/logo/200-3.png": "33a585dba443a8bf297ef92ff4f0225e",
"assets/assets/images/logo/all.jpg": "ce4752d0e3b7d6ce37ba64d8b74ab53d",
"assets/assets/images/logo/carbon.png": "2f923d8e4728f4eb7949375589ffceda",
"assets/assets/images/logo/carve.png": "8acc1ffbb47d3550d439778488df87ed",
"assets/assets/images/logo/fruit.png": "039e26cd1fe370725a8020ade2d6cade",
"assets/assets/images/logo/hydro.png": "1127f23f1cd4494362c4730e5304207f",
"assets/assets/images/no-image.png": "63dde7ad4546d50165d419599892507e",
"assets/assets/images/profile/15/15-1615970522.jpg": "82066b300645f603b6f4c608c0ae46dd",
"assets/assets/images/profile/17/17-1616042658.jpg": "8c49051bd3bfb04cf8f03f2ceae588e1",
"assets/assets/images/profile/21/21-1616556075.jpg": "66ca015dad0247b082304037a0e97585",
"assets/assets/images/profile/25/25-1627320485.jpeg": "26225acad9dceae5524b5645aaff2e21",
"assets/assets/images/profile/25/25-1627320494.jpeg": "cb349562e920d2da3195d51a9910886d",
"assets/assets/images/profile/25/25-1627320498.jpeg": "f3739b047f3aca886c77bec21e34d55c",
"assets/assets/images/profile/25/25-1627320501.jpeg": "7ea25059ef2a0fc22cacbf39083a01a1",
"assets/assets/images/profile/27/27-1627354793.jpg": "d0f741a48485f38fb11f3035ed83c871",
"assets/assets/images/profile/27/27-1627354800.jpg": "80d8280a22e700cf354a2cf752fe1cd5",
"assets/assets/images/profile/27/27-1627354812.jpg": "c6a532a461de64fd063244cd083d3b3a",
"assets/assets/images/profile/27/27-1627354824.jpg": "530dde30c410d92f32d52a228f5c2525",
"assets/assets/images/profile/28/28-1627355103.jpg": "70c53671924270d73649f75657580eff",
"assets/assets/images/profile/28/28-1627355111.jpg": "96017fa79a6b8fb693a141a12ad476bb",
"assets/assets/images/profile/28/28-1627355118.jpg": "530dde30c410d92f32d52a228f5c2525",
"assets/FontManifest.json": "7e4098711f3052e4bf942082e0717456",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/fonts/sukhumvit-set_text.ttf": "93267945e5183aa83da31ad2b2230871",
"assets/NOTICES": "791dad8dcbddbd91cea39c83cde9d2cb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "a3eedf98af0aa81cd622b17e6d1bbf67",
"/": "a3eedf98af0aa81cd622b17e6d1bbf67",
"main.dart.js": "a98e846ae8a793acc75b32c1620ea8ed",
"manifest.json": "244d241cac84d9760ef0dbcdd99dc1eb",
"version.json": "7e4a79217987864fcb5ee3159d4e7f3b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
