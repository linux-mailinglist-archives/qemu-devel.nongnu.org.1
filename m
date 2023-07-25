Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C62761A58
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIMQ-0005G3-7y; Tue, 25 Jul 2023 09:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIM6-0005CV-82; Tue, 25 Jul 2023 09:45:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIM3-0001FW-1S; Tue, 25 Jul 2023 09:45:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 08E1E160E9;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AAACF194AC;
 Tue, 25 Jul 2023 16:45:29 +0300 (MSK)
Received: (nullmailer pid 3370785 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 01/31] virtio-net: correctly report maximum
 tx_queue_size value
Date: Tue, 25 Jul 2023 16:44:46 +0300
Message-Id: <20230725134517.3370706-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Laurent Vivier <lvivier@redhat.com>

Maximum value for tx_queue_size depends on the backend type.
1024 for vDPA/vhost-user, 256 for all the others.

The value is returned by virtio_net_max_tx_queue_size() to set the
parameter:

    n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                    n->net_conf.tx_queue_size);

But the parameter checking uses VIRTQUEUE_MAX_SIZE (1024).

So the parameter is silently ignored and ethtool reports a different
value than the one provided by the user.

   ... -netdev tap,... -device virtio-net,tx_queue_size=1024

    # ethtool -g enp0s2
    Ring parameters for enp0s2:
    Pre-set maximums:
    RX:		256
    RX Mini:	n/a
    RX Jumbo:	n/a
    TX:		256
    Current hardware settings:
    RX:		256
    RX Mini:	n/a
    RX Jumbo:	n/a
    TX:		256

   ... -netdev vhost-user,... -device virtio-net,tx_queue_size=2048

    Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024

With this patch the correct maximum value is checked and displayed.

For vDPA/vhost-user:

    Invalid tx_queue_size (= 2048), must be a power of 2 between 256 and 1024

For all the others:

    Invalid tx_queue_size (= 512), must be a power of 2 between 256 and 256

Fixes: 2eef278b9e63 ("virtio-net: fix tx queue size for !vhost-user")
Cc: mst@redhat.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 4271f4038372f174dbafffacca1a748d058a03ba)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index af1e89706c..5c0a771170 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3629,12 +3629,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
-        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
+        n->net_conf.tx_queue_size > virtio_net_max_tx_queue_size(n) ||
         !is_power_of_2(n->net_conf.tx_queue_size)) {
         error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
                    "must be a power of 2 between %d and %d",
                    n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
-                   VIRTQUEUE_MAX_SIZE);
+                   virtio_net_max_tx_queue_size(n));
         virtio_cleanup(vdev);
         return;
     }
-- 
2.39.2


