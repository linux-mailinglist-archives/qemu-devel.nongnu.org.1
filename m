Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E145C73B0BB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:28:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCaFM-0003A2-CA; Fri, 23 Jun 2023 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1qCaF7-00037x-T2
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:26:02 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1qCaF4-0002Jo-PT
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687501558; x=1719037558;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QIocm1Y//9pegDEM18FMTbxasLNFF6KPTaxZPgdd5js=;
 b=iwtZ4+weB3C4NG9Ya5CsOseq3yKsTLNEv9H8VpwX02QDZU+83tq5O+2M
 jpvx1NhrT7xr6pBUpPvQHh3QVQDiEA9JpVHcW0YjX7qN8DFCZ/wlNyqAB
 hct5rxS361ZWC0rXfIWfzZQo/3N+cOYyNpzUZoVPipl9f3rSpWZReSmT1
 xmalURJ3ZZAi3kdkfDhvb23Hv9nfSTjdTHSoj7m+7eLMCiblwnxBgeaf4
 EjFrjoLcvWcYMU7B3wSmrWzoAO+XhtPE9dUX1VCNEFE/8g4Gcnwi+UBod
 jmaBGvSQoN5e5wst2Y13zamO9bXwEJiy+hu9lt/Q5YoK8Qllow0GNMSCm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390619801"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; d="scan'208";a="390619801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2023 23:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828260759"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; d="scan'208";a="828260759"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.127])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2023 23:25:48 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1] virtio-gpu: Make non-gl display updates work again when
 blob=true
Date: Thu, 22 Jun 2023 23:04:54 -0700
Message-Id: <20230623060454.3749910-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=vivek.kasireddy@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/display/virtio-gpu.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..97cd987cf3 100644
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


