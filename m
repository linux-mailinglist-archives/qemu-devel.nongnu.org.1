Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B51AFB25F1D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 10:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTTw-0007Lm-7F; Thu, 14 Aug 2025 04:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTTs-0007LE-4n
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1umTTq-00065a-1B
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755160716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9I8pN3Ic6kx4QGFOkHjvVo+AEU5MXFerKiYPdyNHE0=;
 b=D1Q99AAgPbGWViA9Tjlw0M3pQapMOM5hlrgJR9PzCBpthvaHtHCz36ZdU17V70rZhCkeRj
 9iSpPp52AqVLHT6N50aOVzUp84pJtWPJPzr8RnUtx43Fh/K+vUmudX2JeWmdzZPjfONtAT
 e0ouxlPF4n0k1cvSJ1AYOS/q3r+SMxY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-rzllMo6aOOaF2aura_mTfg-1; Thu,
 14 Aug 2025 04:38:34 -0400
X-MC-Unique: rzllMo6aOOaF2aura_mTfg-1
X-Mimecast-MFC-AGG-ID: rzllMo6aOOaF2aura_mTfg_1755160713
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9007B1800366; Thu, 14 Aug 2025 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.203])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F32D18004D4; Thu, 14 Aug 2025 08:38:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 hi@alyssa.is, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, dbassey@redhat.com, stevensd@chromium.org,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v6 4/8] vhost_user: Add frontend get_shmem_config command
Date: Thu, 14 Aug 2025 10:37:45 +0200
Message-ID: <20250814083749.1317197-5-aesteve@redhat.com>
In-Reply-To: <20250814083749.1317197-1-aesteve@redhat.com>
References: <20250814083749.1317197-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The frontend can use this command to retrieve
VirtIO Shared Memory Regions configuration from
the backend. The response contains the number of
shared memory regions, their size, and shmid.

This is useful when the frontend is unaware of
specific backend type and configuration,
for example, in the `vhost-user-device` case.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c            | 43 +++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h | 10 +++++++
 include/hw/virtio/vhost-user.h    |  1 +
 include/hw/virtio/virtio.h        |  2 ++
 4 files changed, 56 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index eb3ad728b0..d1bf162497 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -105,6 +105,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_SET_DEVICE_STATE_FD = 42,
     VHOST_USER_CHECK_DEVICE_STATE = 43,
+    VHOST_USER_GET_SHMEM_CONFIG = 44,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -139,6 +140,12 @@ typedef struct VhostUserMemRegMsg {
     VhostUserMemoryRegion region;
 } VhostUserMemRegMsg;
 
+typedef struct VhostUserShMemConfig {
+    uint32_t nregions;
+    uint32_t padding;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+} VhostUserShMemConfig;
+
 typedef struct VhostUserLog {
     uint64_t mmap_size;
     uint64_t mmap_offset;
@@ -245,6 +252,7 @@ typedef union {
         VhostUserShared object;
         VhostUserTransferDeviceState transfer_state;
         VhostUserMMap mmap;
+        VhostUserShMemConfig shmem;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -3213,6 +3221,40 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+static int vhost_user_get_shmem_config(struct vhost_dev *dev,
+                                       int *nregions,
+                                       uint64_t *memory_sizes,
+                                       Error **errp)
+{
+    int ret;
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_GET_SHMEM_CONFIG,
+        .hdr.flags = VHOST_USER_VERSION,
+    };
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_SHMEM)) {
+        return 0;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    assert(msg.payload.shmem.nregions <= VIRTIO_MAX_SHMEM_REGIONS);
+    *nregions = msg.payload.shmem.nregions;
+    memcpy(memory_sizes,
+           &msg.payload.shmem.memory_sizes,
+           sizeof(uint64_t) * msg.payload.shmem.nregions);
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -3251,4 +3293,5 @@ const VhostOps user_ops = {
         .vhost_supports_device_state = vhost_user_supports_device_state,
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
+        .vhost_get_shmem_config = vhost_user_get_shmem_config,
 };
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209a2f..42400b276e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -159,6 +159,15 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
                                             int *reply_fd,
                                             Error **errp);
 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+/*
+ * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
+ * number of memory_sizes that will be accepted.
+ */
+typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
+                                         int *nregions,
+                                         uint64_t *memory_sizes,
+                                         Error **errp);
+
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -214,6 +223,7 @@ typedef struct VhostOps {
     vhost_supports_device_state_op vhost_supports_device_state;
     vhost_set_device_state_fd_op vhost_set_device_state_fd;
     vhost_check_device_state_op vhost_check_device_state;
+    vhost_get_shmem_config_op vhost_get_shmem_config;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 9a3f238b43..bacc7d184c 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
+    VHOST_USER_PROTOCOL_F_SHMEM = 20,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index a563bbac2c..2109186d7d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -81,6 +81,8 @@ typedef struct VirtQueueElement
 
 #define VIRTIO_NO_VECTOR 0xffff
 
+#define VIRTIO_MAX_SHMEM_REGIONS 256
+
 /* special index value used internally for config irqs */
 #define VIRTIO_CONFIG_IRQ_IDX -1
 
-- 
2.49.0


