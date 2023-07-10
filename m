Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B800B74E1B5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuD-0003GX-HJ; Mon, 10 Jul 2023 19:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuB-00037S-JN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzu5-00048F-Oz
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91ehsKt74UQJMB5yd1wqn/5XX3vDbWuqDYEZyK7Ivzc=;
 b=TI5VWdd3G/v5kRen3sQJEdM3K0WPooOEkYzw3SJRdSeao1d4TCvhC2XPVE2ry8ObFsJ9th
 MBEhmiRe/3xUXG+VcFHTNiOfGfafPPx0YkxBJoWuTXIoq6qlQ7cTD/Iy1YCqcj9BH5Uenp
 U0Y34MI+sKCMGe0tQ/XDqVezAcHvBbw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-1KCLqDgqNOiMx2fX7EqEhA-1; Mon, 10 Jul 2023 19:02:47 -0400
X-MC-Unique: 1KCLqDgqNOiMx2fX7EqEhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbcae05906so33511395e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030165; x=1691622165;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91ehsKt74UQJMB5yd1wqn/5XX3vDbWuqDYEZyK7Ivzc=;
 b=hjAdsI4zCOEqyDeWjB82O9aDQzERzKts4xEIq5QoGgfq7JVJeFlOx1Kx6BBxwJz2oL
 LOOjsNaXP1GuwCh6HaC6DCu6Kyck2umzw73Nbs0vOQdPNrHhZJw8R70/Nx8qwvlo2evT
 Nsgr5ECTqkBqTwMP+3UPa5zEoywArkQDH277Ss1Z5DsTacTZJN4+XCTo6bwZ/u4Dj71r
 7yip8HjNAo9xYa4RKh8Mvg49mVVgHJe7s6ZkvVfejWxGN5+5CEXmaqizIMcHyWpR8C6F
 P/FbB6iL4CN7XvyTBRF/3wjr7jGBWpBTBwFdRkh9TQ6qJdeSDpBDI+XZ0N28+xcnv2Vh
 2znw==
X-Gm-Message-State: ABy/qLZzkunZWF79Qz4kY7561kAv2Qz3+cOmFsxw7ZzRl+wIBfBIafkW
 MfwaAkJAc9rjmvd1T1PJ4hlPysLFv5lhbv1unQ86MASqSDBf/vZVo4n8VKqFsAYh1BEk+f4/Php
 f+6GjtAZFGCBJxo1G2hTDX9SdGuxxdp1GKHmXmsqict1800iijOgaZ09IhkQelgoL/wEN
X-Received: by 2002:a05:600c:20b:b0:3fb:415a:d07 with SMTP id
 11-20020a05600c020b00b003fb415a0d07mr13841334wmi.36.1689030165614; 
 Mon, 10 Jul 2023 16:02:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+j3t90UvZgPhJiAOJl2z740F9kWilaCqy99V4KlnBnrKuJj4liILNUR/wJmX/7Zf04Iqe8A==
X-Received: by 2002:a05:600c:20b:b0:3fb:415a:d07 with SMTP id
 11-20020a05600c020b00b003fb415a0d07mr13841302wmi.36.1689030165185; 
 Mon, 10 Jul 2023 16:02:45 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v21-20020a7bcb55000000b003fba9db141esm11435823wmj.38.2023.07.10.16.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:44 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Erico Nunes <ernunes@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 06/66] contrib/vhost-user-gpu: implement get_edid feature
Message-ID: <c06444261e20f5c74962db08638b021e6ca2ad43.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230626164708.1163239-4-ernunes@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-gpu/vugpu.h          | 11 ++++
 contrib/vhost-user-gpu/vhost-user-gpu.c | 73 +++++++++++++++++++++++--
 contrib/vhost-user-gpu/virgl.c          |  3 +
 3 files changed, 81 insertions(+), 6 deletions(-)

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
-- 
MST


