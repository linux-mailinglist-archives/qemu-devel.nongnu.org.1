Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644CA91943
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 12:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MRG-00065x-Sw; Thu, 17 Apr 2025 06:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MRE-00065N-4S
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u5MRB-00075i-Tn
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744885539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPvdBPxtUAgTddV1yewBvjESBsX9d9esW3wgEE0sHAI=;
 b=BcHKdIPr51eN4F7ulOQDJ1w+yuR42hmMrqUJDPSPwZlkiRGmM2Y/Z6fnqtnnhzif57HJaV
 oBotz6vt81lLHLhvXKnMHYU1maPYs7AspsFgiKRqlcCMuDEZh4GyBc0+AMJTJ/Z2Xoyz4Q
 C3KsbW3QufeoWqnd/H40zhqJ4lgKjxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-TJwIr8l1Pj-ycZgw3pzDvQ-1; Thu,
 17 Apr 2025 06:25:38 -0400
X-MC-Unique: TJwIr8l1Pj-ycZgw3pzDvQ-1
X-Mimecast-MFC-AGG-ID: TJwIr8l1Pj-ycZgw3pzDvQ_1744885537
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86F591800876
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:25:37 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C2D9180045B; Thu, 17 Apr 2025 10:25:33 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] virtio_net: Add the check for vdpa's mac address
Date: Thu, 17 Apr 2025 18:24:16 +0800
Message-ID: <20250417102522.4125379-3-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-1-lulu@redhat.com>
References: <20250417102522.4125379-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When using a VDPA device, it is important to ensure that the MAC
address is correctly set. The MAC address in the hardware should
match the MAC address from the QEMU command line. This is a recommended
configuration and will allow the system to boot.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bd37651dab..0b6a4e5634 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3744,12 +3744,29 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     /* failover_primary_hidden is set during feature negotiation */
     return qatomic_read(&n->failover_primary_hidden);
 }
+static bool virtio_net_check_vdpa_mac(VirtIONet *n, uint8_t *hwmac,
+                                      MACAddr *cmdline_mac, Error **errp)
+{
+    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
+
+    if (memcmp(hwmac, &zero, sizeof(MACAddr)) != 0) {
+        /*
+         * 1. The hardware MAC address is the same as the QEMU command line MAC
+         *   address, and both of them are not 0.
+         */
+        if ((memcmp(hwmac, cmdline_mac, sizeof(MACAddr)) == 0)) {
+            return true;
+        }
+    }
 
+    return false;
+}
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
     NetClientState *nc;
+    MACAddr macaddr_cmdline;
     int i;
 
     if (n->net_conf.mtu) {
@@ -3857,6 +3874,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac));
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
@@ -3903,8 +3921,28 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
-   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+    if (nc->peer && (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA)) {
+
         struct virtio_net_config netcfg = {};
+        if (nc->peer->check_mac) {
+            vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
+                                 ETH_ALEN);
+            if (!virtio_net_check_vdpa_mac(n, (uint8_t *)&netcfg.mac,
+                                           &macaddr_cmdline, errp)) {
+                error_setg(errp, "vDPA device's MAC address "
+                           "%02x:%02x:%02x:%02x:%02x:%02x "
+                           "is not same as the QEMU command line MAC address"
+                           "%02x:%02x:%02x:%02x:%02x:%02x,"
+                           "Initialization failed.",
+                           netcfg.mac[0], netcfg.mac[1], netcfg.mac[2],
+                           netcfg.mac[3], netcfg.mac[4], netcfg.mac[5],
+                           macaddr_cmdline.a[0], macaddr_cmdline.a[1],
+                           macaddr_cmdline.a[2], macaddr_cmdline.a[3],
+                           macaddr_cmdline.a[4], macaddr_cmdline.a[5]);
+                virtio_cleanup(vdev);
+                return;
+            }
+        }
         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
         vhost_net_set_config(get_vhost_net(nc->peer),
             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
-- 
2.45.0


