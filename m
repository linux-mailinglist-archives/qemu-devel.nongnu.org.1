Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E48CB051E4
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 08:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZH8-0004f9-Oo; Tue, 15 Jul 2025 02:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZE9-0002X0-M6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZE6-0003cd-GX
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWyeEHTgdMwBOPbQAhP+8TeJjHS/avrQnveaFbPWxjQ=;
 b=gT5iT9nOaGA30fIETRQdCAj3ZFK7LxxQMjgI1VcPgp402jMCMHwIEGPT75mfh3byulTj+R
 WaZYSUTrEWvJdNH0r4jcBlWli+ZqvuM3GXLx6lViUoS/0+CabBi9+DW2Dbz7867RtZzARG
 Cko6jgGPr+S+ZPkLw+ezKoNTGSxdvl8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-rYSM6mgVNoSJOHnq8PDhgw-1; Tue,
 15 Jul 2025 02:33:13 -0400
X-MC-Unique: rYSM6mgVNoSJOHnq8PDhgw-1
X-Mimecast-MFC-AGG-ID: rYSM6mgVNoSJOHnq8PDhgw_1752561193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAF7918002EC; Tue, 15 Jul 2025 06:33:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 248C9180045B; Tue, 15 Jul 2025 06:33:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 01/13] ui/vnc: Do not copy z_stream
Date: Tue, 15 Jul 2025 10:32:47 +0400
Message-ID: <20250715063301.145191-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 ui/vnc.h          |  2 +-
 ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
 ui/vnc.c          | 13 ++++++++++---
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index b3e07269bb..8df0cbab25 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -342,7 +342,7 @@ struct VncState
      *  update vnc_async_encoding_start()
      */
     VncTight *tight;
-    VncZlib zlib;
+    VncZlib *zlib;
     VncHextile hextile;
     VncZrle *zrle;
     VncZywrle zywrle;
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
index e9c30aad62..ab74154e4c 100644
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
@@ -1362,7 +1367,7 @@ void vnc_disconnect_finish(VncState *vs)
     vs->magic = 0;
     g_free(vs->zrle);
     g_free(vs->tight);
-    g_free(vs);
+    g_free(container_of(vs, VncConnection, vs));
 }
 
 size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
@@ -3241,11 +3246,13 @@ static void vnc_refresh(DisplayChangeListener *dcl)
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
@@ -3268,7 +3275,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 #ifdef CONFIG_PNG
     buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
+    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
     buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
     buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
     buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
-- 
2.50.0


