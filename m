Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F8BDF3A8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 17:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xP-0007ej-LL; Wed, 15 Oct 2025 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xN-0007eO-KI
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:25 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xH-0000aB-9c
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C78C7C050E;
 Wed, 15 Oct 2025 17:58:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-oQDO0m51; Wed, 15 Oct 2025 17:58:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540292;
 bh=Cc4fro7LMqaYMZ5I3F9f9KBUdUTKDXhLsBEoX+i+vMw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w2DFPtx0BKSIMZAjTZpImHwRd1AuhdEl10ceHDRmyf4qJaNmxBiVYAFA4uVn7tpaU
 47ZbzMEvKjHpFPMAt+N2XNGWHOB9rPeqDz/eRxoA4FSXUPNGmWZJXa53HjK+vXjp5r
 ZX0gjcR1INpFf+5q0RngWfEYBvBSnARI+YgeBDp8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 01/23] vhost-user: rework enabling vrings
Date: Wed, 15 Oct 2025 17:57:45 +0300
Message-ID: <20251015145808.1112843-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We call the handler almost the same way in three places:

 - cryptodev-vhost.c
 - vhost_net.c
 - vhost.c

The only difference, is that in vhost.c we don't try to call the handler
for old vhost-user (when VHOST_USER_F_PROTOCOL_FEATURES is not supported).

cryptodev-vhost and vhost_net code will just fail in this case. Probably
they were developed only for newer vhost-user. Anyway, it doesn't seem
correct to rely on this error path, if these devices want to check,
that they don't communicate to old vhost-user protocol, they should
do that earlier.

Let's create the common helper, to call .vhost_set_vring_enable and
use in all three places. For vhost-user let's just always skip
enable/disable if it's unsupported.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 backends/cryptodev-vhost.c |  8 +-------
 hw/net/vhost_net.c         |  7 +------
 hw/virtio/vhost-user.c     |  7 ++++++-
 hw/virtio/vhost.c          | 21 ---------------------
 include/hw/virtio/vhost.h  |  9 +++++++++
 5 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 943680a23a..abdfce33af 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -152,7 +152,6 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
 {
     CryptoDevBackendVhost *crypto =
                        cryptodev_get_vhost(cc, b, queue);
-    const VhostOps *vhost_ops;
 
     cc->vring_enable = enable;
 
@@ -160,12 +159,7 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
         return 0;
     }
 
-    vhost_ops = crypto->dev.vhost_ops;
-    if (vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&crypto->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&crypto->dev, enable);
 }
 
 int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a8ee18a912..25e9f1fd24 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -587,7 +587,6 @@ VHostNetState *get_vhost_net(NetClientState *nc)
 int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 {
     VHostNetState *net = get_vhost_net(nc);
-    const VhostOps *vhost_ops = net->dev.vhost_ops;
 
     /*
      * vhost-vdpa network devices need to enable dataplane virtqueues after
@@ -601,11 +600,7 @@ int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 
     nc->vring_enable = enable;
 
-    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&net->dev, enable);
 }
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..f367ce06ce 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1235,7 +1235,12 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
     int i;
 
     if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return -EINVAL;
+        /*
+         * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
+         * been negotiated, the rings start directly in the enabled state,
+         * and can't be disabled.
+         */
+        return 0;
     }
 
     for (i = 0; i < dev->nvqs; ++i) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..414a48a218 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2013,27 +2013,6 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
     return 0;
 }
 
-static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
-{
-    if (!hdev->vhost_ops->vhost_set_vring_enable) {
-        return 0;
-    }
-
-    /*
-     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
-     * been negotiated, the rings start directly in the enabled state, and
-     * .vhost_set_vring_enable callback will fail since
-     * VHOST_USER_SET_VRING_ENABLE is not supported.
-     */
-    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
-        !virtio_has_feature(hdev->backend_features,
-                            VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return 0;
-    }
-
-    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
-}
-
 /*
  * Host notifiers must be enabled at this point.
  *
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..1ee639dd7e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -215,6 +215,15 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
+{
+    if (!hdev->vhost_ops->vhost_set_vring_enable) {
+        return 0;
+    }
+
+    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
+}
+
 /**
  * vhost_dev_start() - start the vhost device
  * @hdev: common vhost_dev structure
-- 
2.48.1


