Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD1B2502D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Aug 2025 18:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfe-0002go-AA; Wed, 13 Aug 2025 12:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfB-0002cZ-Lv; Wed, 13 Aug 2025 12:49:22 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf2-0007me-K5; Wed, 13 Aug 2025 12:49:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id ED134813ED;
 Wed, 13 Aug 2025 19:49:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-VO6HtPTH; Wed, 13 Aug 2025 19:49:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103741;
 bh=1D8TczXfj+PsAi0lOr8ci9eOjVbXTipR5Kb9tGv3kuw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PkchNhvZ3/t7jHg3xiAgTxmKvCYpivjVCl1hMj0RHTY19dLPvWnObVcB4p69edntd
 Y+pyRuw9YSRR/TADrhs+ig8LUdiVnDwIkxHjXL1eqUjG+WaF4JDn6P11cdQGAhxwID
 RH6sj09ysadadBXBRvV871kXZRYj/QvCFwEAQbos=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 01/33] vhost: introduce
 vhost_ops->vhost_set_vring_enable_supported method
Date: Wed, 13 Aug 2025 19:48:22 +0300
Message-ID: <20250813164856.950363-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove vhost-user specific hack from generic code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c            |  8 ++++++++
 hw/virtio/vhost.c                 | 15 ++++++---------
 include/hw/virtio/vhost-backend.h |  2 ++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e..1b2879a90c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1230,6 +1230,12 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
 }
 
+static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
+{
+    return virtio_has_feature(dev->backend_features,
+                              VHOST_USER_F_PROTOCOL_FEATURES);
+}
+
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
 {
     int i;
@@ -3032,6 +3038,8 @@ const VhostOps user_ops = {
         .vhost_reset_device = vhost_user_reset_device,
         .vhost_get_vq_index = vhost_user_get_vq_index,
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
+        .vhost_set_vring_enable_supported =
+            vhost_user_set_vring_enable_supported,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12..c33dad4acd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1986,15 +1986,12 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
         return 0;
     }
 
-    /*
-     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
-     * been negotiated, the rings start directly in the enabled state, and
-     * .vhost_set_vring_enable callback will fail since
-     * VHOST_USER_SET_VRING_ENABLE is not supported.
-     */
-    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
-        !virtio_has_feature(hdev->backend_features,
-                            VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (hdev->vhost_ops->vhost_set_vring_enable_supported &&
+        !hdev->vhost_ops->vhost_set_vring_enable_supported(hdev)) {
+        /*
+         * This means, that rings are always enabled, and disable/enable
+         * API is not supported.
+         */
         return 0;
     }
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209a2f..f65fa26298 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -105,6 +105,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef bool (*vhost_set_vring_enable_supported_op)(struct vhost_dev *dev);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -193,6 +194,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vring_enable_supported_op vhost_set_vring_enable_supported;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
-- 
2.48.1


