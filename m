Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18884B18F1C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 16:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiD93-0002lE-W1; Sat, 02 Aug 2025 10:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uiD78-0007R4-M1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 10:21:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uiD76-0000pC-S0
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 10:21:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAE8313D0BF;
 Sat, 02 Aug 2025 17:21:00 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 303D82551CC;
 Sat,  2 Aug 2025 17:21:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/2] virtio-net: make VirtIONet.vlans an array instead of a
 pointer
Date: Sat,  2 Aug 2025 17:21:08 +0300
Message-ID: <20250802142115.41638-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This field is a fixed-size buffer (number of elements is MAX_VLAN,
known at build time).  There's no need to allocate it dynamically,
it can be made an integral part of VirtIONet structure.

This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/virtio-net.c            | 8 +++-----
 include/hw/virtio/virtio-net.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..3973dd0e5f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -931,7 +931,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 
     if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
         bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
-        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
+        memset(n->vlans, vlan ? 0 : 0xff, sizeof(n->vlans));
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3524,7 +3524,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * buffer; hold onto your endiannesses; it's actually used as a bitmap
          * but based on the uint.
          */
-        VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_BUFFER(vlans, VirtIONet),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -3942,8 +3942,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
-    n->vlans = g_malloc0(MAX_VLAN >> 3);
-    memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, sizeof(n->vlans));
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -3992,7 +3991,6 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     n->netclient_type = NULL;
 
     g_free(n->mac_table.macs);
-    g_free(n->vlans);
 
     if (n->failover) {
         qobject_unref(n->primary_opts);
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 73fdefc0dc..4a0cc34ae6 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -202,7 +202,7 @@ struct VirtIONet {
         uint8_t uni_overflow;
         uint8_t *macs;
     } mac_table;
-    uint32_t *vlans;
+    uint32_t vlans[MAX_VLAN];
     virtio_net_conf net_conf;
     NICConf nic_conf;
     DeviceState *qdev;
-- 
2.47.2


