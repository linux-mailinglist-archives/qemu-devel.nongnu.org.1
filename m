Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC47787D8
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 09:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUMFW-00048H-Gy; Fri, 11 Aug 2023 03:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFP-00047E-PV
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:47 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFL-0008Hm-2s
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:47 -0400
Received: from pasha-ThinkPad-X280.lan02.inno (unknown [188.162.65.26])
 by mail.ispras.ru (Postfix) with ESMTPSA id DCE34406BB55;
 Fri, 11 Aug 2023 07:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DCE34406BB55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691737657;
 bh=dgIZp3cwFpi0PXZyu8OYHo4xa8pRq0vWZpPkkY0Qxvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p6+W2APqVrGe2/M0I3GEoXOlQ5qRLy+N7T1QJuxY/UuasNBX8BXWkUF1fOPuAYVDk
 UEYmg4sSRtyC0ZaIZf0b/ZLVJ/0s6wt1em/W0/mQCBkw+KBIAXq7lU26RO5ZtvRnoB
 6cLdKDvId+xg4plnnumZxnE6dd2jatjDuTnH55kI=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 1/3] replay: improve determinism of virtio-net
Date: Fri, 11 Aug 2023 10:06:06 +0300
Message-Id: <20230811070608.3383343-2-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811070608.3383343-1-pavel.dovgalyuk@ispras.ru>
References: <20230811070608.3383343-1-pavel.dovgalyuk@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

virtio-net device uses bottom halves for callbacks.
These callbacks should be deterministic, because they affect VM state.
This patch replaces BH invocations with corresponding replay functions,
making them deterministic in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 hw/net/virtio-net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..43fd34b0c8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -46,6 +46,7 @@
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
 #include "sysemu/qtest.h"
+#include "sysemu/replay.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -417,7 +418,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
                 timer_mod(q->tx_timer,
                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
             } else {
-                qemu_bh_schedule(q->tx_bh);
+                replay_bh_schedule_event(q->tx_bh);
             }
         } else {
             if (q->tx_timer) {
@@ -2799,7 +2800,7 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    qemu_bh_schedule(q->tx_bh);
+    replay_bh_schedule_event(q->tx_bh);
 }
 
 static void virtio_net_tx_timer(void *opaque)
@@ -2882,7 +2883,7 @@ static void virtio_net_tx_bh(void *opaque)
     /* If we flush a full burst of packets, assume there are
      * more coming and immediately reschedule */
     if (ret >= n->tx_burst) {
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
         return;
     }
@@ -2896,7 +2897,7 @@ static void virtio_net_tx_bh(void *opaque)
         return;
     } else if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
-        qemu_bh_schedule(q->tx_bh);
+        replay_bh_schedule_event(q->tx_bh);
         q->tx_waiting = 1;
     }
 }
-- 
2.34.1


