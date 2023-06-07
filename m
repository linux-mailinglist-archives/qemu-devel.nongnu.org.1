Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8C726368
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uZF-0002sv-Iy; Wed, 07 Jun 2023 10:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q6uZ1-0002qG-Ot
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q6uYz-0001Gs-Qw
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686149704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVoMp3+5Oq/xn+gjsVsNm8rlyUbbwZcVPcLIKO5cNbI=;
 b=W5PnmSnT0paMJJqr+2jLIWJ4iDEWsZlo+96ds+ebb4PzvjnSvDXiahT2w62SeGPuszR6D+
 ue7xBe2bWJskp6g8Dlu95S7GY6crtojDwsumQ1FjDDOawRTCZAzwdkj7EkBGDWr3VBbAvS
 IKWwQKiNF24uB6aQy6MxAdu26Za7AxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-COn1zsV3NyuDwjc9DpVBCA-1; Wed, 07 Jun 2023 10:55:03 -0400
X-MC-Unique: COn1zsV3NyuDwjc9DpVBCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA0B6101B045
 for <qemu-devel@nongnu.org>; Wed,  7 Jun 2023 14:55:02 +0000 (UTC)
Received: from centennial.enunes.eu.com (unknown [10.45.227.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1C2F403367;
 Wed,  7 Jun 2023 14:55:01 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, kraxel@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH v3 1/4] virtio-gpu: refactor generate_edid function to
 virtio_gpu_base
Date: Wed,  7 Jun 2023 16:54:52 +0200
Message-Id: <20230607145455.158267-2-ernunes@redhat.com>
In-Reply-To: <20230607145455.158267-1-ernunes@redhat.com>
References: <20230607145455.158267-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This functionality can be shared with upcoming use in vhost-user-gpu, so
move it to the shared file to avoid duplicating it.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
 hw/display/virtio-gpu-base.c   | 17 +++++++++++++++++
 hw/display/virtio-gpu.c        | 20 +-------------------
 include/hw/virtio/virtio-gpu.h |  2 ++
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index a29f191aa8..7ab7d08d0a 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -17,6 +17,7 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/display/edid.h"
 #include "trace.h"
 
 void
@@ -51,6 +52,22 @@ virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
     }
 }
 
+void
+virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
+                              struct virtio_gpu_resp_edid *edid)
+{
+    qemu_edid_info info = {
+        .width_mm = g->req_state[scanout].width_mm,
+        .height_mm = g->req_state[scanout].height_mm,
+        .prefx = g->req_state[scanout].width,
+        .prefy = g->req_state[scanout].height,
+        .refresh_rate = g->req_state[scanout].refresh_rate,
+    };
+
+    edid->size = cpu_to_le32(sizeof(edid->edid));
+    qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
+}
+
 static void virtio_gpu_invalidate_display(void *opaque)
 {
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..9ff1a43353 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -24,7 +24,6 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/display/edid.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -207,23 +206,6 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
                              sizeof(display_info));
 }
 
-static void
-virtio_gpu_generate_edid(VirtIOGPU *g, int scanout,
-                         struct virtio_gpu_resp_edid *edid)
-{
-    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
-    qemu_edid_info info = {
-        .width_mm = b->req_state[scanout].width_mm,
-        .height_mm = b->req_state[scanout].height_mm,
-        .prefx = b->req_state[scanout].width,
-        .prefy = b->req_state[scanout].height,
-        .refresh_rate = b->req_state[scanout].refresh_rate,
-    };
-
-    edid->size = cpu_to_le32(sizeof(edid->edid));
-    qemu_edid_generate(edid->edid, sizeof(edid->edid), &info);
-}
-
 void virtio_gpu_get_edid(VirtIOGPU *g,
                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -242,7 +224,7 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
     trace_virtio_gpu_cmd_get_edid(get_edid.scanout);
     memset(&edid, 0, sizeof(edid));
     edid.hdr.type = VIRTIO_GPU_RESP_OK_EDID;
-    virtio_gpu_generate_edid(g, get_edid.scanout, &edid);
+    virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(g), get_edid.scanout, &edid);
     virtio_gpu_ctrl_response(g, cmd, &edid.hdr, sizeof(edid));
 }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2e28507efe..39c1a6a6ea 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -239,6 +239,8 @@ void virtio_gpu_base_reset(VirtIOGPUBase *g);
 void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
                         struct virtio_gpu_resp_display_info *dpy_info);
 
+void virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
+                                   struct virtio_gpu_resp_edid *edid);
 /* virtio-gpu.c */
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
-- 
2.40.1


