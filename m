Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E1A7F5C7
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Apr 2025 09:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23BX-0004WH-UH; Tue, 08 Apr 2025 03:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u23BR-0004Vk-2Q
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:15:46 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u23BK-0000x8-Le
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:15:42 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id DF5EC1C159B; Tue,  8 Apr 2025 09:15:35 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH 3/3] vnc: h264: send additional frames after the display is
 clean
Date: Tue,  8 Apr 2025 09:15:32 +0200
Message-Id: <20250408071532.2417316-4-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408071532.2417316-1-dietmar@proxmox.com>
References: <20250408071532.2417316-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The H264 implementation only sends frames when it detects changes in
the server's framebuffer. This leads to artifacts when there are no
further changes, as the internal H264 encoder may still contain data.

This patch modifies the code to send a few additional frames in such
situations to flush the H264 encoder data.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc.c | 25 ++++++++++++++++++++++++-
 ui/vnc.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2e60b55e47..4ba0b715fd 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3239,7 +3239,30 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     vnc_unlock_display(vd);
 
     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
-        rects += vnc_update_client(vs, has_dirty);
+        int client_dirty = has_dirty;
+        if (vs->h264) {
+            if (client_dirty) {
+                vs->h264->keep_dirty = VNC_H264_KEEP_DIRTY;
+            } else {
+                if (vs->h264->keep_dirty > 0) {
+                    client_dirty = 1;
+                    vs->h264->keep_dirty--;
+                }
+            }
+        }
+
+        int count = vnc_update_client(vs, client_dirty);
+        rects += count;
+
+        if (vs->h264 && !count && vs->h264->keep_dirty) {
+            VncJob *job = vnc_job_new(vs);
+            int height = pixman_image_get_height(vd->server);
+            int width = pixman_image_get_width(vd->server);
+            vs->job_update = vs->update;
+            vs->update = VNC_STATE_UPDATE_NONE;
+            vnc_job_add_rect(job, 0, 0, width, height);
+            vnc_job_push(job);
+        }
         /* vs might be free()ed here */
     }
 
diff --git a/ui/vnc.h b/ui/vnc.h
index 7e232f7dac..e1b81d6bcc 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -236,10 +236,13 @@ typedef struct VncZywrle {
 } VncZywrle;
 
 #ifdef CONFIG_GSTREAMER
+/* Number of frames we send after the display is clean. */
+#define VNC_H264_KEEP_DIRTY 10
 typedef struct VncH264 {
     GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
     size_t width;
     size_t height;
+    guint keep_dirty;
 } VncH264;
 #endif
 
-- 
2.39.5


