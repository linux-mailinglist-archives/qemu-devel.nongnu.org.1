Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016CB089BC
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 11:50:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLEH-0008D9-Dp; Thu, 17 Jul 2025 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1z-000341-8i; Thu, 17 Jul 2025 05:35:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1x-00027n-5W; Thu, 17 Jul 2025 05:35:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C15D7137CFF;
 Thu, 17 Jul 2025 12:34:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A4C1F2491F8;
 Thu, 17 Jul 2025 12:34:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 62/65] ui/vnc: Do not copy z_stream
Date: Thu, 17 Jul 2025 12:33:58 +0300
Message-ID: <20250717093412.728292-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

vnc_worker_thread_loop() copies z_stream stored in its local VncState to
the persistent VncState, and the copied one is freed with deflateEnd()
later. However, deflateEnd() refuses to operate with a copied z_stream
and returns Z_STREAM_ERROR, leaking the allocated memory.

Avoid copying the zlib state to fix the memory leak.

Fixes: bd023f953e5e ("vnc: threaded VNC server")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit aef22331b5a4670f42638a5f63a26e93bf779aae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 900ae5b30f..52e9193eab 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -48,21 +48,21 @@ void vnc_zlib_zfree(void *x, void *addr)
 
 static void vnc_zlib_start(VncState *vs)
 {
-    buffer_reset(&vs->zlib.zlib);
+    buffer_reset(&vs->zlib->zlib);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->zlib.tmp = vs->output;
-    vs->output = vs->zlib.zlib;
+    vs->zlib->tmp = vs->output;
+    vs->output = vs->zlib->zlib;
 }
 
 static int vnc_zlib_stop(VncState *vs)
 {
-    z_streamp zstream = &vs->zlib.stream;
+    z_streamp zstream = &vs->zlib->stream;
     int previous_out;
 
     // switch back to normal output/zlib buffers
-    vs->zlib.zlib = vs->output;
-    vs->output = vs->zlib.tmp;
+    vs->zlib->zlib = vs->output;
+    vs->output = vs->zlib->tmp;
 
     // compress the zlib buffer
 
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib->level = vs->tight->compression;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->compression != vs->zlib.level) {
+    if (vs->tight->compression != vs->zlib->level) {
         if (deflateParams(zstream, vs->tight->compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib->level = vs->tight->compression;
     }
 
     // reserve memory in output buffer
-    buffer_reserve(&vs->output, vs->zlib.zlib.offset + 64);
+    buffer_reserve(&vs->output, vs->zlib->zlib.offset + 64);
 
     // set pointers
-    zstream->next_in = vs->zlib.zlib.buffer;
-    zstream->avail_in = vs->zlib.zlib.offset;
+    zstream->next_in = vs->zlib->zlib.buffer;
+    zstream->avail_in = vs->zlib->zlib.offset;
     zstream->next_out = vs->output.buffer + vs->output.offset;
     zstream->avail_out = vs->output.capacity - vs->output.offset;
     previous_out = zstream->avail_out;
@@ -147,8 +147,8 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 
 void vnc_zlib_clear(VncState *vs)
 {
-    if (vs->zlib.stream.opaque) {
-        deflateEnd(&vs->zlib.stream);
+    if (vs->zlib->stream.opaque) {
+        deflateEnd(&vs->zlib->stream);
     }
-    buffer_free(&vs->zlib.zlib);
+    buffer_free(&vs->zlib->zlib);
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index c96bd8ceea..ca02ff872a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -56,6 +56,11 @@
 #include "io/dns-resolver.h"
 #include "monitor/monitor.h"
 
+typedef struct VncConnection {
+    VncState vs;
+    VncZlib zlib;
+} VncConnection;
+
 #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
 #define VNC_REFRESH_INTERVAL_INC  50
 #define VNC_REFRESH_INTERVAL_MAX  GUI_REFRESH_INTERVAL_IDLE
@@ -1364,7 +1369,7 @@ void vnc_disconnect_finish(VncState *vs)
     vs->magic = 0;
     g_free(vs->zrle);
     g_free(vs->tight);
-    g_free(vs);
+    g_free(container_of(vs, VncConnection, vs));
 }
 
 size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
@@ -3243,11 +3248,13 @@ static void vnc_refresh(DisplayChangeListener *dcl)
 static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
                         bool skipauth, bool websocket)
 {
-    VncState *vs = g_new0(VncState, 1);
+    VncConnection *vc = g_new0(VncConnection, 1);
+    VncState *vs = &vc->vs;
     bool first_client = QTAILQ_EMPTY(&vd->clients);
     int i;
 
     trace_vnc_client_connect(vs, sioc);
+    vs->zlib = &vc->zlib;
     vs->zrle = g_new0(VncZrle, 1);
     vs->tight = g_new0(VncTight, 1);
     vs->magic = VNC_MAGIC;
@@ -3270,7 +3277,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 #ifdef CONFIG_PNG
     buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
+    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
     buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
     buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
     buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
diff --git a/ui/vnc.h b/ui/vnc.h
index 02613aa63a..82b883bb69 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -340,7 +340,7 @@ struct VncState
      *  update vnc_async_encoding_start()
      */
     VncTight *tight;
-    VncZlib zlib;
+    VncZlib *zlib;
     VncHextile hextile;
     VncZrle *zrle;
     VncZywrle zywrle;
-- 
2.47.2


