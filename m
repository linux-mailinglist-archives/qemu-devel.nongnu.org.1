Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4AA841A3
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 13:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pze-00089J-V8; Thu, 10 Apr 2025 07:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u2pzb-00088F-Q9
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:47 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u2pzZ-0000F4-M8
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:47 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 7AB251C15D3; Thu, 10 Apr 2025 13:22:40 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v2 6/6] h264: new vnc option to configure h264 at server side
Date: Thu, 10 Apr 2025 13:22:38 +0200
Message-Id: <20250410112238.3550155-7-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410112238.3550155-1-dietmar@proxmox.com>
References: <20250410112238.3550155-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Values can be 'on', 'off', or a space sparated list of
allowed gstreamer encoders.

- on: automatically select the encoder
- off: disbale h264
- encoder-list: select first available encoder from that list.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc-enc-h264.c | 28 +++++++++++++++++++++-------
 ui/vnc.c          | 26 +++++++++++++++++++++-----
 ui/vnc.h          |  6 +++++-
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
index 3eabfc2cfe..33067d3a16 100644
--- a/ui/vnc-enc-h264.c
+++ b/ui/vnc-enc-h264.c
@@ -3,13 +3,21 @@
 
 #include <gst/gst.h>
 
-const char *encoder_list[] = { "x264enc", "openh264enc", NULL };
-
-static const char *get_available_encoder(void)
+static char *get_available_encoder(const char *encoder_list)
 {
+    g_assert(encoder_list != NULL);
+
+    if (!strcmp(encoder_list, "")) {
+        /* use default list */
+        encoder_list = "x264enc openh264enc";
+    }
+
+    char *ret = NULL;
+    char **encoder_array = g_strsplit(encoder_list, " ", -1);
+
     int i = 0;
     do {
-        const char *encoder_name = encoder_list[i];
+        const char *encoder_name = encoder_array[i];
         if (encoder_name == NULL) {
             break;
         }
@@ -17,12 +25,15 @@ static const char *get_available_encoder(void)
             encoder_name, "video-encoder");
         if (element != NULL) {
             gst_object_unref(element);
-            return encoder_name;
+            ret = strdup(encoder_name);
+            break;
         }
         i = i + 1;
     } while (true);
 
-    return NULL;
+    g_strfreev(encoder_array);
+
+    return ret;
 }
 
 static GstElement *create_encoder(const char *encoder_name)
@@ -215,8 +226,10 @@ static bool create_encoder_context(VncState *vs, int w, int h)
 int vnc_h264_encoder_init(VncState *vs)
 {
     g_assert(vs->h264 == NULL);
+    g_assert(vs->vd != NULL);
+    g_assert(vs->vd->h264_encoder_list != NULL);
 
-    const char *encoder_name = get_available_encoder();
+    char *encoder_name = get_available_encoder(vs->vd->h264_encoder_list);
     if (encoder_name == NULL) {
         VNC_DEBUG("No H264 encoder available.\n");
         return -1;
@@ -316,6 +329,7 @@ void vnc_h264_clear(VncState *vs)
 
     destroy_encoder_context(vs);
 
+    g_free(vs->h264->encoder_name);
     g_free(vs->h264);
     vs->h264 = NULL;
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 4ba0b715fd..5a7f93e762 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2190,11 +2190,11 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
 #ifdef CONFIG_GSTREAMER
         case VNC_ENCODING_H264:
-            if (vnc_h264_encoder_init(vs) == 0) {
-                vnc_set_feature(vs, VNC_FEATURE_H264);
-                vs->vnc_encoding = enc;
-            } else {
-                VNC_DEBUG("vnc_h264_encoder_init failed\n");
+            if (vs->vd->h264_encoder_list != NULL) { /* if h264 is enabled */
+                if (vnc_h264_encoder_init(vs) == 0) {
+                    vnc_set_feature(vs, VNC_FEATURE_H264);
+                    vs->vnc_encoding = enc;
+                }
             }
             break;
 #endif
@@ -3634,6 +3634,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "power-control",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "h264",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -4196,6 +4199,19 @@ void vnc_display_open(const char *id, Error **errp)
     }
 #endif
 
+#ifdef CONFIG_GSTREAMER
+    const char *h264_opt = qemu_opt_get(opts, "h264");
+    fprintf(stderr, "GOT %s\n", h264_opt);
+    if (!strcmp(h264_opt, "off")) {
+        vd->h264_encoder_list = NULL; /* disable h264 */
+    } else if  (!strcmp(h264_opt, "on")) {
+        vd->h264_encoder_list = ""; /* use default encoder list */
+    } else  {
+        /* assume this is a list of endiers */
+        vd->h264_encoder_list = h264_opt;
+    }
+#endif
+
     if (vnc_display_setup_auth(&vd->auth, &vd->subauth,
                                vd->tlscreds, password,
                                sasl, false, errp) < 0) {
diff --git a/ui/vnc.h b/ui/vnc.h
index f39dbe21aa..e459441e35 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -188,6 +188,10 @@ struct VncDisplay
     VncDisplaySASL sasl;
 #endif
 
+#ifdef CONFIG_GSTREAMER
+    const char *h264_encoder_list;
+#endif
+
     AudioState *audio_state;
 };
 
@@ -239,7 +243,7 @@ typedef struct VncZywrle {
 /* Number of frames we send after the display is clean. */
 #define VNC_H264_KEEP_DIRTY 10
 typedef struct VncH264 {
-    const char *encoder_name;
+    char *encoder_name;
     GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
     size_t width;
     size_t height;
-- 
2.39.5


