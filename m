Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4573E5BA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpNg-0001XL-Me; Mon, 26 Jun 2023 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpNe-0001Vt-Pe
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1qDpNd-0002DV-63
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687798076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8HpeGkkRf8eFnhSKYeoXx4UEgSpblYZ1KWtTpUNkcc=;
 b=UQkUIu9EGkzRkYnwJEIGvG9BMprS2ZaAuvApHV2I8vgkg/7B8PTgmjyWJsz/uPeUkJh9P1
 5Mz5cnjihpyeZ9U8b5WIkcQS0EY/DgIW/Soew4a/0MY1NXEogRj/9Bu8Tyv3CFWlDCU7TK
 CQ5sioA5N6+kqsPBAVpn3ZjdZpuHXJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-Gp9ro20FOwirnX0cVHYjOQ-1; Mon, 26 Jun 2023 12:47:53 -0400
X-MC-Unique: Gp9ro20FOwirnX0cVHYjOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E85B790ED53
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:47:37 +0000 (UTC)
Received: from centennial.enunes.eu.com (unknown [10.67.24.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C0A1121330;
 Mon, 26 Jun 2023 16:47:33 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, kraxel@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH v4 4/4] vhost-user-gpu: implement get_edid frontend feature
Date: Mon, 26 Jun 2023 18:47:08 +0200
Message-Id: <20230626164708.1163239-5-ernunes@redhat.com>
In-Reply-To: <20230626164708.1163239-1-ernunes@redhat.com>
References: <20230626164708.1163239-1-ernunes@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the frontend side of the get_edid feature in the qemu
vhost-user-gpu frontend device.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 15f9d99d09..543ea92721 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -31,6 +31,7 @@ typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_UPDATE,
     VHOST_USER_GPU_DMABUF_SCANOUT,
     VHOST_USER_GPU_DMABUF_UPDATE,
+    VHOST_USER_GPU_GET_EDID,
 } VhostUserGpuRequest;
 
 typedef struct VhostUserGpuDisplayInfoReply {
@@ -78,6 +79,10 @@ typedef struct VhostUserGpuDMABUFScanout {
     int fd_drm_fourcc;
 } QEMU_PACKED VhostUserGpuDMABUFScanout;
 
+typedef struct VhostUserGpuEdidRequest {
+    uint32_t scanout_id;
+} QEMU_PACKED VhostUserGpuEdidRequest;
+
 typedef struct VhostUserGpuMsg {
     uint32_t request; /* VhostUserGpuRequest */
     uint32_t flags;
@@ -88,6 +93,8 @@ typedef struct VhostUserGpuMsg {
         VhostUserGpuScanout scanout;
         VhostUserGpuUpdate update;
         VhostUserGpuDMABUFScanout dmabuf_scanout;
+        VhostUserGpuEdidRequest edid_req;
+        struct virtio_gpu_resp_edid resp_edid;
         struct virtio_gpu_resp_display_info display_info;
         uint64_t u64;
     } payload;
@@ -99,6 +106,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 
 #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
 
+#define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+
 static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked);
 
 static void
@@ -161,6 +170,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             .request = msg->request,
             .flags = VHOST_USER_GPU_MSG_FLAG_REPLY,
             .size = sizeof(uint64_t),
+            .payload = {
+                .u64 = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID)
+            }
         };
 
         vhost_user_gpu_send_msg(g, &reply);
@@ -184,6 +196,26 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         vhost_user_gpu_send_msg(g, &reply);
         break;
     }
+    case VHOST_USER_GPU_GET_EDID: {
+        VhostUserGpuEdidRequest *m = &msg->payload.edid_req;
+        struct virtio_gpu_resp_edid resp = { {} };
+        VhostUserGpuMsg reply = {
+            .request = msg->request,
+            .flags = VHOST_USER_GPU_MSG_FLAG_REPLY,
+            .size = sizeof(reply.payload.resp_edid),
+        };
+
+        if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
+            error_report("invalid scanout: %d", m->scanout_id);
+            break;
+        }
+
+        resp.hdr.type = VIRTIO_GPU_RESP_OK_EDID;
+        virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(g), m->scanout_id, &resp);
+        memcpy(&reply.payload.resp_edid, &resp, sizeof(resp));
+        vhost_user_gpu_send_msg(g, &reply);
+        break;
+    }
     case VHOST_USER_GPU_SCANOUT: {
         VhostUserGpuScanout *m = &msg->payload.scanout;
 
-- 
2.40.1


