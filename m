Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882F744C40
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 06:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFort-0007mu-OJ; Sun, 02 Jul 2023 00:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qForq-0007mC-QQ; Sun, 02 Jul 2023 00:39:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qForo-0002SQ-Op; Sun, 02 Jul 2023 00:39:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5C50310D18;
 Sun,  2 Jul 2023 07:39:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 971D3110A7;
 Sun,  2 Jul 2023 07:39:07 +0300 (MSK)
Received: (nullmailer pid 2090159 invoked by uid 1000);
 Sun, 02 Jul 2023 04:39:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 44/49] virtio-gpu: Make non-gl display updates work
 again when blob=true
Date: Sun,  2 Jul 2023 07:38:44 +0300
Message-Id: <20230702043850.2090131-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230702073703@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

In the case where the console does not have gl capability, and
if blob is set to true, make sure that the display updates still
work. Commit e86a93f55463 accidentally broke this by misplacing
the return statement (in resource_flush) causing the updates to
be silently ignored.

Fixes: e86a93f55463 ("virtio-gpu: splitting one extended mode guest fb into n-scanouts")
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230623060454.3749910-1-vivek.kasireddy@intel.com>
(cherry picked from commit 34e29d85a7734802317c4cac9ad52b10d461c1dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5e15c79b94..4e2e0dd53a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -498,6 +498,8 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     struct virtio_gpu_resource_flush rf;
     struct virtio_gpu_scanout *scanout;
     pixman_region16_t flush_region;
+    bool within_bounds = false;
+    bool update_submitted = false;
     int i;
 
     VIRTIO_GPU_FILL_CMD(rf);
@@ -518,13 +520,28 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
                 rf.r.x < scanout->x + scanout->width &&
                 rf.r.x + rf.r.width >= scanout->x &&
                 rf.r.y < scanout->y + scanout->height &&
-                rf.r.y + rf.r.height >= scanout->y &&
-                console_has_gl(scanout->con)) {
-                dpy_gl_update(scanout->con, 0, 0, scanout->width,
-                              scanout->height);
+                rf.r.y + rf.r.height >= scanout->y) {
+                within_bounds = true;
+
+                if (console_has_gl(scanout->con)) {
+                    dpy_gl_update(scanout->con, 0, 0, scanout->width,
+                                  scanout->height);
+                    update_submitted = true;
+                }
             }
         }
-        return;
+
+        if (update_submitted) {
+            return;
+        }
+        if (!within_bounds) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: flush bounds outside scanouts"
+                          " bounds for flush %d: %d %d %d %d\n",
+                          __func__, rf.resource_id, rf.r.x, rf.r.y,
+                          rf.r.width, rf.r.height);
+            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+            return;
+        }
     }
 
     if (!res->blob &&
-- 
2.39.2


