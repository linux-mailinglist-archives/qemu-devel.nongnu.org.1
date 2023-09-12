Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1179CEB9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vG-0002rL-5D; Tue, 12 Sep 2023 06:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vE-0002qo-BE
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vC-0003EL-1M
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2bxcIHBHpFaidbRkCTSYJN8Ogex1gp3OkpT+6Cmerk=;
 b=Ja1yYlPtB4TPjHdDzDW4kNAQCBHTjaTj/mazKYOEfsWPIyf+fpOvbK5pApeInHP3xyTONH
 Py+WQOt/TpnCQJ9QBbHVJBBsKfULzDIAMuLhOrwIQKyLeqdqc2hkIH9CYbsv/WOrfmy0qA
 bkN5XV8O7z59hyiG1rySdVf8QoOlJqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-QGeoN68HPtmtzfv1lRWq3Q-1; Tue, 12 Sep 2023 06:47:04 -0400
X-MC-Unique: QGeoN68HPtmtzfv1lRWq3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D07BD181A6E7
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE50C2156722;
 Tue, 12 Sep 2023 10:47:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Erico Nunes <ernunes@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 03/14] vhost-user-gpu: support dmabuf modifiers
Date: Tue, 12 Sep 2023 14:46:37 +0400
Message-ID: <20230912104649.1638640-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Erico Nunes <ernunes@redhat.com>

When the backend sends VHOST_USER_GPU_DMABUF_SCANOUT2, handle it
by getting the modifiers information which is now available.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20230714153900.475857-4-ernunes@redhat.com>
---
 hw/display/vhost-user-gpu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index e8ee03094e..1150521d9d 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -32,6 +32,7 @@ typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_DMABUF_SCANOUT,
     VHOST_USER_GPU_DMABUF_UPDATE,
     VHOST_USER_GPU_GET_EDID,
+    VHOST_USER_GPU_DMABUF_SCANOUT2,
 } VhostUserGpuRequest;
 
 typedef struct VhostUserGpuDisplayInfoReply {
@@ -79,6 +80,11 @@ typedef struct VhostUserGpuDMABUFScanout {
     int fd_drm_fourcc;
 } QEMU_PACKED VhostUserGpuDMABUFScanout;
 
+typedef struct VhostUserGpuDMABUFScanout2 {
+    struct VhostUserGpuDMABUFScanout dmabuf_scanout;
+    uint64_t modifier;
+} QEMU_PACKED VhostUserGpuDMABUFScanout2;
+
 typedef struct VhostUserGpuEdidRequest {
     uint32_t scanout_id;
 } QEMU_PACKED VhostUserGpuEdidRequest;
@@ -93,6 +99,7 @@ typedef struct VhostUserGpuMsg {
         VhostUserGpuScanout scanout;
         VhostUserGpuUpdate update;
         VhostUserGpuDMABUFScanout dmabuf_scanout;
+        VhostUserGpuDMABUFScanout2 dmabuf_scanout2;
         VhostUserGpuEdidRequest edid_req;
         struct virtio_gpu_resp_edid resp_edid;
         struct virtio_gpu_resp_display_info display_info;
@@ -107,6 +114,7 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
 
 #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+#define VHOST_USER_GPU_PROTOCOL_F_DMABUF2 1
 
 static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked);
 
@@ -171,7 +179,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             .flags = VHOST_USER_GPU_MSG_FLAG_REPLY,
             .size = sizeof(uint64_t),
             .payload = {
-                .u64 = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID)
+                .u64 = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID) |
+                       (1 << VHOST_USER_GPU_PROTOCOL_F_DMABUF2)
             }
         };
 
@@ -236,6 +245,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         break;
     }
+    case VHOST_USER_GPU_DMABUF_SCANOUT2:
     case VHOST_USER_GPU_DMABUF_SCANOUT: {
         VhostUserGpuDMABUFScanout *m = &msg->payload.dmabuf_scanout;
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
@@ -269,6 +279,11 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             .fourcc = m->fd_drm_fourcc,
             .y0_top = m->fd_flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
         };
+        if (msg->request == VHOST_USER_GPU_DMABUF_SCANOUT2) {
+            VhostUserGpuDMABUFScanout2 *m2 = &msg->payload.dmabuf_scanout2;
+            dmabuf->modifier = m2->modifier;
+        }
+
         dpy_gl_scanout_dmabuf(con, dmabuf);
         break;
     }
-- 
2.41.0


