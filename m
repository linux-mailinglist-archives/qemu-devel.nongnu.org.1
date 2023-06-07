Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C03726372
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uZ8-0002sx-VF; Wed, 07 Jun 2023 10:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q6uZ4-0002qp-41
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q6uZ2-0001HR-3U
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686149707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aoDGpbP3AD2aOXFWJz1EDWgOCRFFDI/asGXqPwa5IA=;
 b=PzxucxggTwVEIPzDFJ5qWLwP0bh4o87MJErZnybLPospDY66saXq726VLzMe7FnKvEnxb1
 EscUh7U+SdeQ1FBkbKqpRLjpQEjw4hhL1Dyrcpu/ko3hWXAer1K3a7NYtfN35lq3badV4Q
 OoycntidNGxaG+YMb6mloXTNHtw2kvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-gGEEm3OKMiOLVspvflgBMA-1; Wed, 07 Jun 2023 10:55:05 -0400
X-MC-Unique: gGEEm3OKMiOLVspvflgBMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50C0B185A7B4
 for <qemu-devel@nongnu.org>; Wed,  7 Jun 2023 14:55:05 +0000 (UTC)
Received: from centennial.enunes.eu.com (unknown [10.45.227.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68484477F61;
 Wed,  7 Jun 2023 14:55:04 +0000 (UTC)
From: Erico Nunes <ernunes@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, kraxel@redhat.com,
 Erico Nunes <ernunes@redhat.com>
Subject: [PATCH v3 3/4] contrib/vhost-user-gpu: implement get_edid feature
Date: Wed,  7 Jun 2023 16:54:54 +0200
Message-Id: <20230607145455.158267-4-ernunes@redhat.com>
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

Implement the virtio-gpu feature in contrib/vhost-user-gpu, which was
unsupported until now.
In this implementation, the feature is enabled inconditionally to avoid
creating another optional config argument.
Similarly to get_display_info, vhost-user-gpu sends a message back to
the frontend to have access to all the display information. In the
case of get_edid, it also needs to pass which scanout we should
retrieve the edid for.

The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the
frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend
sets the virtio-gpu feature but does not support the protocol feature,
the backend will abort with an error.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 73 +++++++++++++++++++++++--
 contrib/vhost-user-gpu/virgl.c          |  3 +
 contrib/vhost-user-gpu/vugpu.h          | 11 ++++
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index bfb8d93cf8..2e7815a7a3 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -303,6 +303,53 @@ vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
     cmd->state = VG_CMD_STATE_PENDING;
 }
 
+static gboolean
+get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
+{
+    struct virtio_gpu_resp_edid resp_edid;
+    VuGpu *vg = user_data;
+    struct virtio_gpu_ctrl_command *cmd = QTAILQ_LAST(&vg->fenceq);
+
+    g_debug("get edid cb");
+    assert(cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
+    if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,
+                     sizeof(resp_edid), &resp_edid)) {
+        return G_SOURCE_CONTINUE;
+    }
+
+    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
+    vg_ctrl_response(vg, cmd, &resp_edid.hdr, sizeof(resp_edid));
+
+    vg->wait_in = 0;
+    vg_handle_ctrl(&vg->dev.parent, 0);
+
+    return G_SOURCE_REMOVE;
+}
+
+void
+vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_cmd_get_edid get_edid;
+
+    VUGPU_FILL_CMD(get_edid);
+    virtio_gpu_bswap_32(&get_edid, sizeof(get_edid));
+
+    VhostUserGpuMsg msg = {
+        .request = VHOST_USER_GPU_GET_EDID,
+        .size = sizeof(VhostUserGpuEdidRequest),
+        .payload.edid_req = {
+                .scanout_id = get_edid.scanout,
+        },
+    };
+
+    assert(vg->wait_in == 0);
+
+    vg_send_msg(vg, &msg, -1);
+    vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
+                               get_edid_cb, vg);
+    cmd->state = VG_CMD_STATE_PENDING;
+}
+
 static void
 vg_resource_create_2d(VuGpu *g,
                       struct virtio_gpu_ctrl_command *cmd)
@@ -837,8 +884,9 @@ vg_process_cmd(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
     case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
         vg_resource_detach_backing(vg, cmd);
         break;
-    /* case VIRTIO_GPU_CMD_GET_EDID: */
-    /*     break */
+    case VIRTIO_GPU_CMD_GET_EDID:
+        vg_get_edid(vg, cmd);
+        break;
     default:
         g_warning("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
@@ -1022,26 +1070,36 @@ vg_queue_set_started(VuDev *dev, int qidx, bool started)
 static gboolean
 protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data)
 {
+    const uint64_t protocol_edid = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID);
     VuGpu *g = user_data;
-    uint64_t u64;
+    uint64_t protocol_features;
     VhostUserGpuMsg msg = {
         .request = VHOST_USER_GPU_GET_PROTOCOL_FEATURES
     };
 
-    if (!vg_recv_msg(g, msg.request, sizeof(u64), &u64)) {
+    if (!vg_recv_msg(g, msg.request,
+                     sizeof(protocol_features), &protocol_features)) {
         return G_SOURCE_CONTINUE;
     }
 
+    protocol_features &= protocol_edid;
+
     msg = (VhostUserGpuMsg) {
         .request = VHOST_USER_GPU_SET_PROTOCOL_FEATURES,
         .size = sizeof(uint64_t),
-        .payload.u64 = 0
+        .payload.u64 = protocol_features,
     };
     vg_send_msg(g, &msg, -1);
 
     g->wait_in = 0;
     vg_handle_ctrl(&g->dev.parent, 0);
 
+    if (g->edid_inited && !(protocol_features & protocol_edid)) {
+        g_printerr("EDID feature set by the frontend but it does not support "
+                   "the EDID vhost-user-gpu protocol.\n");
+        exit(EXIT_FAILURE);
+    }
+
     return G_SOURCE_REMOVE;
 }
 
@@ -1049,7 +1107,7 @@ static void
 set_gpu_protocol_features(VuGpu *g)
 {
     VhostUserGpuMsg msg = {
-        .request = VHOST_USER_GPU_GET_PROTOCOL_FEATURES
+        .request = VHOST_USER_GPU_GET_PROTOCOL_FEATURES,
     };
 
     vg_send_msg(g, &msg, -1);
@@ -1086,6 +1144,7 @@ vg_get_features(VuDev *dev)
     if (opt_virgl) {
         features |= 1 << VIRTIO_GPU_F_VIRGL;
     }
+    features |= 1 << VIRTIO_GPU_F_EDID;
 
     return features;
 }
@@ -1103,6 +1162,8 @@ vg_set_features(VuDev *dev, uint64_t features)
         g->virgl_inited = true;
     }
 
+    g->edid_inited = !!(features & (1 << VIRTIO_GPU_F_EDID));
+
     g->virgl = virgl;
 }
 
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 3e45e1bd33..211aa110a9 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -495,6 +495,9 @@ void vg_virgl_process_cmd(VuGpu *g, struct virtio_gpu_ctrl_command *cmd)
     case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
         vg_get_display_info(g, cmd);
         break;
+    case VIRTIO_GPU_CMD_GET_EDID:
+        vg_get_edid(g, cmd);
+        break;
     default:
         g_debug("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index e2864bba68..f0f2069c47 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -36,6 +36,7 @@ typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_UPDATE,
     VHOST_USER_GPU_DMABUF_SCANOUT,
     VHOST_USER_GPU_DMABUF_UPDATE,
+    VHOST_USER_GPU_GET_EDID,
 } VhostUserGpuRequest;
 
 typedef struct VhostUserGpuDisplayInfoReply {
@@ -83,6 +84,10 @@ typedef struct VhostUserGpuDMABUFScanout {
     int fd_drm_fourcc;
 } QEMU_PACKED VhostUserGpuDMABUFScanout;
 
+typedef struct VhostUserGpuEdidRequest {
+    uint32_t scanout_id;
+} QEMU_PACKED VhostUserGpuEdidRequest;
+
 typedef struct VhostUserGpuMsg {
     uint32_t request; /* VhostUserGpuRequest */
     uint32_t flags;
@@ -93,6 +98,8 @@ typedef struct VhostUserGpuMsg {
         VhostUserGpuScanout scanout;
         VhostUserGpuUpdate update;
         VhostUserGpuDMABUFScanout dmabuf_scanout;
+        VhostUserGpuEdidRequest edid_req;
+        struct virtio_gpu_resp_edid resp_edid;
         struct virtio_gpu_resp_display_info display_info;
         uint64_t u64;
     } payload;
@@ -104,6 +111,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 
 #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
 
+#define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+
 struct virtio_gpu_scanout {
     uint32_t width, height;
     int x, y;
@@ -122,6 +131,7 @@ typedef struct VuGpu {
 
     bool virgl;
     bool virgl_inited;
+    bool edid_inited;
     uint32_t inflight;
 
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
@@ -171,6 +181,7 @@ int     vg_create_mapping_iov(VuGpu *g,
                               struct iovec **iov);
 void    vg_cleanup_mapping_iov(VuGpu *g, struct iovec *iov, uint32_t count);
 void    vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
+void    vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
 
 void    vg_wait_ok(VuGpu *g);
 
-- 
2.40.1


