Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C384673E227
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNU-0006H6-Jo; Mon, 26 Jun 2023 08:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMO-0005BB-Kb
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlML-0003YL-Dv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvcHKGZtRsCg9xVfQMjrL0yyTleYbIs/ROTH+Yj3riA=;
 b=Up6CRTnYGUERWJQIiH6IjKMAZVp4+7dryCRgITHfoMn8azVSIDHKeJ/M/baBygJ+H71GT6
 lRw5N3oBPD9aDvUjnZHR7XoMtHoQC8oYuAv5ybPJCoDArfygzTIZIsdKnGIGIg80EJNEDc
 NXBBXUj4hWs8cel4wy79eeTArt150AU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-YGqIxmCyOdiELs0A5NoJlw-1; Mon, 26 Jun 2023 08:30:18 -0400
X-MC-Unique: YGqIxmCyOdiELs0A5NoJlw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3112e243c68so2468344f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782615; x=1690374615;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NvcHKGZtRsCg9xVfQMjrL0yyTleYbIs/ROTH+Yj3riA=;
 b=DkoF1RIqoQge8PJBYTNQuS7bhbXlbyQGWo/0X3MI8L4sW8fwoMJbkEC2+UKfD1TfZt
 8oF8rYZDIdykDN1+/1XIwCwnRHVaKVk0t3mas8dn4ajL14Ls1qPXoAuHB6UQfRRw3/gS
 1vi0y+KRNEuT7vU4EgNDvXU0JLXFsdPlADLPXWXrDZQpUhytEyaZ5RfV9R54xcEGqGcG
 IyiASY38JS9ug/lMW9ONJXGJKBjVO9c3mKP2hZh1eB2sgIj7er+kfTTNvWNW+Ayf24wI
 Bt3eFOBG1/ei+Lt3t6xSTnRreggS6VIVCPUo1e4TeVmx1ja0jzPcz61EHFb82EuMNAQM
 kDrw==
X-Gm-Message-State: AC+VfDyFEqHgy5dViyMRYu63O712ZB9k0pFtl9O/I+/cXNbOpXduK8fh
 VnDtjzRYdEUEMOinXyx6RjEYHYAVblTIEtJcdbUxkA63nmCEgJpRcxbsI781tMuW/tbK89b0m4M
 YqPuHOK/1gjFLTqgnGNZOcTqsHBXPckbaMh0keA3EXEXFx9Vez9QrGy6qvVpTkQAhw/RQ
X-Received: by 2002:a5d:5608:0:b0:30e:3f55:ebc9 with SMTP id
 l8-20020a5d5608000000b0030e3f55ebc9mr25116319wrv.13.1687782614674; 
 Mon, 26 Jun 2023 05:30:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QfoE8ZVgPS6/o0T4A0wYpdUi3RMy7YijyWQkIMbiAwCn7v227c4l6PuuSLbof5UpzKuY77w==
X-Received: by 2002:a5d:5608:0:b0:30e:3f55:ebc9 with SMTP id
 l8-20020a5d5608000000b0030e3f55ebc9mr25116286wrv.13.1687782614101; 
 Mon, 26 Jun 2023 05:30:14 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 b3-20020adfe303000000b0030fd03e3d25sm7294493wrj.75.2023.06.26.05.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:13 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 48/53] vhost-user: fully use new backend/frontend naming
Message-ID: <94c16765eb27bddb47640b03d1eaa80074ecb707.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Slave/master nomenclature was replaced with backend/frontend in commit
1fc19b65279a ("vhost-user: Adopt new backend naming")

This patch replaces all remaining uses of master and slave in the
codebase.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20230613080849.2115347-1-manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/vhost-backend.h         |  2 +-
 subprojects/libvhost-user/libvhost-user.h | 20 +++++----
 block/export/vhost-user-blk-server.c      |  2 +-
 contrib/vhost-user-blk/vhost-user-blk.c   |  2 +-
 hw/block/vhost-user-blk.c                 |  2 +-
 hw/display/vhost-user-gpu.c               |  2 +-
 hw/input/vhost-user-input.c               |  2 +-
 hw/net/virtio-net.c                       |  4 +-
 hw/virtio/vdpa-dev.c                      |  2 +-
 hw/virtio/vhost-user.c                    | 52 +++++++++++-----------
 hw/virtio/virtio-qmp.c                    |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 54 +++++++++++------------
 12 files changed, 74 insertions(+), 72 deletions(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ec3fbae58d..31a251a9f5 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -22,7 +22,7 @@ typedef enum VhostBackendType {
 } VhostBackendType;
 
 typedef enum VhostSetConfigType {
-    VHOST_SET_CONFIG_TYPE_MASTER = 0,
+    VHOST_SET_CONFIG_TYPE_FRONTEND = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 49208cceaa..708370c5f5 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -39,7 +39,7 @@
 #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
 
 typedef enum VhostSetConfigType {
-    VHOST_SET_CONFIG_TYPE_MASTER = 0,
+    VHOST_SET_CONFIG_TYPE_FRONTEND = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;
 
@@ -112,7 +112,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_MAX
 } VhostUserRequest;
 
-typedef enum VhostUserSlaveRequest {
+typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_NONE = 0,
     VHOST_USER_BACKEND_IOTLB_MSG = 1,
     VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
@@ -120,7 +120,7 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_BACKEND_VRING_CALL = 4,
     VHOST_USER_BACKEND_VRING_ERR = 5,
     VHOST_USER_BACKEND_MAX
-}  VhostUserSlaveRequest;
+}  VhostUserBackendRequest;
 
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
@@ -296,8 +296,10 @@ typedef struct VuVirtqInflight {
      * Zero value indicates a vm reset happened. */
     uint16_t version;
 
-    /* The size of VuDescStateSplit array. It's equal to the virtqueue
-     * size. Slave could get it from queue size field of VhostUserInflight. */
+    /*
+     * The size of VuDescStateSplit array. It's equal to the virtqueue size.
+     * Backend could get it from queue size field of VhostUserInflight.
+     */
     uint16_t desc_num;
 
     /* The head of list that track the last batch of used descriptors. */
@@ -384,9 +386,9 @@ struct VuDev {
     VuVirtq *vq;
     VuDevInflightInfo inflight_info;
     int log_call_fd;
-    /* Must be held while using slave_fd */
-    pthread_mutex_t slave_mutex;
-    int slave_fd;
+    /* Must be held while using backend_fd */
+    pthread_mutex_t backend_mutex;
+    int backend_fd;
     uint64_t log_size;
     uint8_t *log_table;
     uint64_t features;
@@ -445,7 +447,7 @@ typedef struct VuVirtqElement {
  * vu_init:
  * @dev: a VuDev context
  * @max_queues: maximum number of virtqueues
- * @socket: the socket connected to vhost-user master
+ * @socket: the socket connected to vhost-user frontend
  * @panic: a panic callback
  * @set_watch: a set_watch callback
  * @remove_watch: a remove_watch callback
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 81b59761e3..f7b5073605 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -167,7 +167,7 @@ vu_blk_set_config(VuDev *vu_dev, const uint8_t *data,
     uint8_t wce;
 
     /* don't support live migration */
-    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
+    if (flags != VHOST_SET_CONFIG_TYPE_FRONTEND) {
         return -EINVAL;
     }
 
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 7941694e53..89e5f11a64 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -421,7 +421,7 @@ vub_set_config(VuDev *vu_dev, const uint8_t *data,
     int fd;
 
     /* don't support live migration */
-    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
+    if (flags != VHOST_SET_CONFIG_TYPE_FRONTEND) {
         return -1;
     }
 
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index aff4d2b8cb..eecf3f7a81 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -81,7 +81,7 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     ret = vhost_dev_set_config(&s->dev, &blkcfg->wce,
                                offsetof(struct virtio_blk_config, wce),
                                sizeof(blkcfg->wce),
-                               VHOST_SET_CONFIG_TYPE_MASTER);
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("set device config space failed");
         return;
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 1386e869e5..15f9d99d09 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -452,7 +452,7 @@ vhost_user_gpu_set_config(VirtIODevice *vdev,
 
     ret = vhost_dev_set_config(&g->vhost->dev, config_data,
                                0, sizeof(struct virtio_gpu_config),
-                               VHOST_SET_CONFIG_TYPE_MASTER);
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("vhost-user-gpu: set device config space failed");
         return;
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
index 1352e372ff..4ee3542106 100644
--- a/hw/input/vhost-user-input.c
+++ b/hw/input/vhost-user-input.c
@@ -69,7 +69,7 @@ static void vhost_input_set_config(VirtIODevice *vdev,
 
     ret = vhost_dev_set_config(&vhi->vhost->dev, config_data,
                                0, sizeof(virtio_input_config),
-                               VHOST_SET_CONFIG_TYPE_MASTER);
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("vhost-user-input: set device config space failed");
         return;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e8897a8bc..aa421a908a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -211,7 +211,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
         vhost_net_set_config(get_vhost_net(nc->peer),
                              (uint8_t *)&netcfg, 0, n->config_size,
-                             VHOST_SET_CONFIG_TYPE_MASTER);
+                             VHOST_SET_CONFIG_TYPE_FRONTEND);
       }
 }
 
@@ -3733,7 +3733,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         struct virtio_net_config netcfg = {};
         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
         vhost_net_set_config(get_vhost_net(nc->peer),
-            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
+            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
     }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index e08e830006..363b625243 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -203,7 +203,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const uint8_t *config)
     int ret;
 
     ret = vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
-                               VHOST_SET_CONFIG_TYPE_MASTER);
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("set device config space failed");
         return;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2ad75a7964..c4e0cbd702 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -124,13 +124,13 @@ typedef enum VhostUserRequest {
     VHOST_USER_MAX
 } VhostUserRequest;
 
-typedef enum VhostUserSlaveRequest {
+typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_NONE = 0,
     VHOST_USER_BACKEND_IOTLB_MSG = 1,
     VHOST_USER_BACKEND_CONFIG_CHANGE_MSG = 2,
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
     VHOST_USER_BACKEND_MAX
-}  VhostUserSlaveRequest;
+}  VhostUserBackendRequest;
 
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
@@ -245,8 +245,8 @@ struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
     VhostUserState *user;
-    QIOChannel *slave_ioc;
-    GSource *slave_src;
+    QIOChannel *backend_ioc;
+    GSource *backend_src;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
     uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
@@ -1495,7 +1495,7 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
     return vhost_user_write(dev, &msg, NULL, 0);
 }
 
-static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)
+static int vhost_user_backend_handle_config_change(struct vhost_dev *dev)
 {
     if (!dev->config_ops || !dev->config_ops->vhost_dev_config_notifier) {
         return -ENOSYS;
@@ -1532,7 +1532,7 @@ static VhostUserHostNotifier *fetch_or_create_notifier(VhostUserState *u,
     return n;
 }
 
-static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
+static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
                                                        VhostUserVringArea *area,
                                                        int fd)
 {
@@ -1594,16 +1594,16 @@ static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
     return 0;
 }
 
-static void close_slave_channel(struct vhost_user *u)
+static void close_backend_channel(struct vhost_user *u)
 {
-    g_source_destroy(u->slave_src);
-    g_source_unref(u->slave_src);
-    u->slave_src = NULL;
-    object_unref(OBJECT(u->slave_ioc));
-    u->slave_ioc = NULL;
+    g_source_destroy(u->backend_src);
+    g_source_unref(u->backend_src);
+    u->backend_src = NULL;
+    object_unref(OBJECT(u->backend_ioc));
+    u->backend_ioc = NULL;
 }
 
-static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
+static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                            gpointer opaque)
 {
     struct vhost_dev *dev = opaque;
@@ -1645,10 +1645,10 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
         break;
     case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
-        ret = vhost_user_slave_handle_config_change(dev);
+        ret = vhost_user_backend_handle_config_change(dev);
         break;
     case VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG:
-        ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
+        ret = vhost_user_backend_handle_vring_host_notifier(dev, &payload.area,
                                                           fd ? fd[0] : -1);
         break;
     default:
@@ -1684,7 +1684,7 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
     goto fdcleanup;
 
 err:
-    close_slave_channel(u);
+    close_backend_channel(u);
     rc = G_SOURCE_REMOVE;
 
 fdcleanup:
@@ -1696,7 +1696,7 @@ fdcleanup:
     return rc;
 }
 
-static int vhost_setup_slave_channel(struct vhost_dev *dev)
+static int vhost_setup_backend_channel(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_BACKEND_REQ_FD,
@@ -1725,10 +1725,10 @@ static int vhost_setup_slave_channel(struct vhost_dev *dev)
         error_report_err(local_err);
         return -ECONNREFUSED;
     }
-    u->slave_ioc = ioc;
-    u->slave_src = qio_channel_add_watch_source(u->slave_ioc,
+    u->backend_ioc = ioc;
+    u->backend_src = qio_channel_add_watch_source(u->backend_ioc,
                                                 G_IO_IN | G_IO_HUP,
-                                                slave_read, dev, NULL, NULL);
+                                                backend_read, dev, NULL, NULL);
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
@@ -1746,7 +1746,7 @@ static int vhost_setup_slave_channel(struct vhost_dev *dev)
 out:
     close(sv[1]);
     if (ret) {
-        close_slave_channel(u);
+        close_backend_channel(u);
     }
 
     return ret;
@@ -2072,7 +2072,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                  virtio_has_feature(dev->protocol_features,
                     VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
             error_setg(errp, "IOMMU support requires reply-ack and "
-                       "slave-req protocol features.");
+                       "backend-req protocol features.");
             return -EINVAL;
         }
 
@@ -2108,7 +2108,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     }
 
     if (dev->vq_index == 0) {
-        err = vhost_setup_slave_channel(dev);
+        err = vhost_setup_backend_channel(dev);
         if (err < 0) {
             error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
             return -EPROTO;
@@ -2138,8 +2138,8 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
         close(u->postcopy_fd.fd);
         u->postcopy_fd.handler = NULL;
     }
-    if (u->slave_ioc) {
-        close_slave_channel(u);
+    if (u->backend_ioc) {
+        close_backend_channel(u);
     }
     g_free(u->region_rb);
     u->region_rb = NULL;
@@ -2235,7 +2235,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
         return ret;
     }
 
-    /* If reply_ack supported, slave has to ack specified MTU is valid */
+    /* If reply_ack supported, backend has to ack specified MTU is valid */
     if (reply_supported) {
         return process_message_reply(dev, &msg);
     }
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3528fc628d..3d32dbec8d 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -117,7 +117,7 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
             "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for virtio "
             "device configuration space supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
-            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Slave fd communication "
+            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd communication "
             "channel supported"),
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
             "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for specified "
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8fb61e2df2..0469a50101 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -421,8 +421,8 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 }
 
 /*
- * Processes a reply on the slave channel.
- * Entered with slave_mutex held and releases it before exit.
+ * Processes a reply on the backend channel.
+ * Entered with backend_mutex held and releases it before exit.
  * Returns true on success.
  */
 static bool
@@ -436,7 +436,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
         goto out;
     }
 
-    if (!vu_message_read_default(dev, dev->slave_fd, &msg_reply)) {
+    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
         goto out;
     }
 
@@ -449,7 +449,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
     result = msg_reply.payload.u64 == 0;
 
 out:
-    pthread_mutex_unlock(&dev->slave_mutex);
+    pthread_mutex_unlock(&dev->backend_mutex);
     return result;
 }
 
@@ -1393,13 +1393,13 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
         return false;
     }
 
-    pthread_mutex_lock(&dev->slave_mutex);
-    if (!vu_message_write(dev, dev->slave_fd, &vmsg)) {
-        pthread_mutex_unlock(&dev->slave_mutex);
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &vmsg)) {
+        pthread_mutex_unlock(&dev->backend_mutex);
         return false;
     }
 
-    /* Also unlocks the slave_mutex */
+    /* Also unlocks the backend_mutex */
     return vu_process_message_reply(dev, &vmsg);
 }
 
@@ -1463,7 +1463,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
      * a device implementation can return it in its callback
      * (get_protocol_features) if it wants to use this for
      * simulation, but it is otherwise not desirable (if even
-     * implemented by the master.)
+     * implemented by the frontend.)
      */
     uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_MQ |
                         1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
@@ -1508,7 +1508,7 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
          * of the other features are required.
          * Theoretically, one could use only kick messages, or do them without
          * having F_REPLY_ACK, but too many (possibly pending) messages on the
-         * socket will eventually cause the master to hang, to avoid this in
+         * socket will eventually cause the frontend to hang, to avoid this in
          * scenarios where not desired enforce that the settings are in a way
          * that actually enables the simulation case.
          */
@@ -1550,18 +1550,18 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
-vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
+vu_set_backend_req_fd(VuDev *dev, VhostUserMsg *vmsg)
 {
     if (vmsg->fd_num != 1) {
-        vu_panic(dev, "Invalid slave_req_fd message (%d fd's)", vmsg->fd_num);
+        vu_panic(dev, "Invalid backend_req_fd message (%d fd's)", vmsg->fd_num);
         return false;
     }
 
-    if (dev->slave_fd != -1) {
-        close(dev->slave_fd);
+    if (dev->backend_fd != -1) {
+        close(dev->backend_fd);
     }
-    dev->slave_fd = vmsg->fds[0];
-    DPRINT("Got slave_fd: %d\n", vmsg->fds[0]);
+    dev->backend_fd = vmsg->fds[0];
+    DPRINT("Got backend_fd: %d\n", vmsg->fds[0]);
 
     return false;
 }
@@ -1577,7 +1577,7 @@ vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
     }
 
     if (ret) {
-        /* resize to zero to indicate an error to master */
+        /* resize to zero to indicate an error to frontend */
         vmsg->size = 0;
     }
 
@@ -1917,7 +1917,7 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
     case VHOST_USER_SET_VRING_ENABLE:
         return vu_set_vring_enable_exec(dev, vmsg);
     case VHOST_USER_SET_BACKEND_REQ_FD:
-        return vu_set_slave_req_fd(dev, vmsg);
+        return vu_set_backend_req_fd(dev, vmsg);
     case VHOST_USER_GET_CONFIG:
         return vu_get_config(dev, vmsg);
     case VHOST_USER_SET_CONFIG:
@@ -2038,11 +2038,11 @@ vu_deinit(VuDev *dev)
     }
 
     vu_close_log(dev);
-    if (dev->slave_fd != -1) {
-        close(dev->slave_fd);
-        dev->slave_fd = -1;
+    if (dev->backend_fd != -1) {
+        close(dev->backend_fd);
+        dev->backend_fd = -1;
     }
-    pthread_mutex_destroy(&dev->slave_mutex);
+    pthread_mutex_destroy(&dev->backend_mutex);
 
     if (dev->sock != -1) {
         close(dev->sock);
@@ -2080,8 +2080,8 @@ vu_init(VuDev *dev,
     dev->remove_watch = remove_watch;
     dev->iface = iface;
     dev->log_call_fd = -1;
-    pthread_mutex_init(&dev->slave_mutex, NULL);
-    dev->slave_fd = -1;
+    pthread_mutex_init(&dev->backend_mutex, NULL);
+    dev->backend_fd = -1;
     dev->max_queues = max_queues;
 
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
@@ -2439,9 +2439,9 @@ static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
             vmsg.flags |= VHOST_USER_NEED_REPLY_MASK;
         }
 
-        vu_message_write(dev, dev->slave_fd, &vmsg);
+        vu_message_write(dev, dev->backend_fd, &vmsg);
         if (ack) {
-            vu_message_read_default(dev, dev->slave_fd, &vmsg);
+            vu_message_read_default(dev, dev->backend_fd, &vmsg);
         }
         return;
     }
@@ -2468,7 +2468,7 @@ void vu_config_change_msg(VuDev *dev)
         .flags = VHOST_USER_VERSION,
     };
 
-    vu_message_write(dev, dev->slave_fd, &vmsg);
+    vu_message_write(dev, dev->backend_fd, &vmsg);
 }
 
 static inline void
-- 
MST


