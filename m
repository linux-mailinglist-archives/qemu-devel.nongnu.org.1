Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79317713823
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 08:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ALT-0006OC-Rc; Sun, 28 May 2023 02:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ALC-0006Jk-Dm; Sun, 28 May 2023 02:57:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3AL9-0001Ye-V7; Sun, 28 May 2023 02:57:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A212B8DF8;
 Sun, 28 May 2023 09:57:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 268ED7E18;
 Sun, 28 May 2023 09:57:15 +0300 (MSK)
Received: (nullmailer pid 42051 invoked by uid 1000);
 Sun, 28 May 2023 06:57:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 "timothee.cocault@gmail.com" <timothee.cocault@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 60/73] e1000e: Fix tx/rx counters
Date: Sun, 28 May 2023 09:56:58 +0300
Message-Id: <20230528065714.42005-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230528095540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "timothee.cocault@gmail.com" <timothee.cocault@gmail.com>

The bytes and packets counter registers are cleared on read.

Copying the "total counter" registers to the "good counter" registers has
side effects.
If the "total" register is never read by the OS, it only gets incremented.
This leads to exponential growth of the "good" register.

This commit increments the counters individually to avoid this.

Signed-off-by: Timothée Cocault <timothee.cocault@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 8d689f6aae8be096b4a1859be07c1b083865f755)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 23d660619f..59bacb5d3b 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -637,9 +637,8 @@ xmit_seg(E1000State *s)
 
     e1000x_inc_reg_if_not_full(s->mac_reg, TPT);
     e1000x_grow_8reg_if_not_full(s->mac_reg, TOTL, s->tx.size + 4);
-    s->mac_reg[GPTC] = s->mac_reg[TPT];
-    s->mac_reg[GOTCL] = s->mac_reg[TOTL];
-    s->mac_reg[GOTCH] = s->mac_reg[TOTH];
+    e1000x_inc_reg_if_not_full(s->mac_reg, GPTC);
+    e1000x_grow_8reg_if_not_full(s->mac_reg, GOTCL, s->tx.size + 4);
 }
 
 static void
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c0c09b6965..cfa3f55e96 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -711,9 +711,8 @@ e1000e_on_tx_done_update_stats(E1000ECore *core, struct NetTxPkt *tx_pkt)
         g_assert_not_reached();
     }
 
-    core->mac[GPTC] = core->mac[TPT];
-    core->mac[GOTCL] = core->mac[TOTL];
-    core->mac[GOTCH] = core->mac[TOTH];
+    e1000x_inc_reg_if_not_full(core->mac, GPTC);
+    e1000x_grow_8reg_if_not_full(core->mac, GOTCL, tot_len);
 }
 
 static void
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index b844af590a..4c8e7dcf70 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -220,15 +220,14 @@ e1000x_update_rx_total_stats(uint32_t *mac,
 
     e1000x_increase_size_stats(mac, PRCregs, data_fcs_size);
     e1000x_inc_reg_if_not_full(mac, TPR);
-    mac[GPRC] = mac[TPR];
+    e1000x_inc_reg_if_not_full(mac, GPRC);
     /* TOR - Total Octets Received:
     * This register includes bytes received in a packet from the <Destination
     * Address> field through the <CRC> field, inclusively.
     * Always include FCS length (4) in size.
     */
     e1000x_grow_8reg_if_not_full(mac, TORL, data_size + 4);
-    mac[GORCL] = mac[TORL];
-    mac[GORCH] = mac[TORH];
+    e1000x_grow_8reg_if_not_full(mac, GORCL, data_size + 4);
 }
 
 void
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index d733fed6cf..826e7a6cf1 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -538,9 +538,8 @@ igb_on_tx_done_update_stats(IGBCore *core, struct NetTxPkt *tx_pkt, int qn)
         g_assert_not_reached();
     }
 
-    core->mac[GPTC] = core->mac[TPT];
-    core->mac[GOTCL] = core->mac[TOTL];
-    core->mac[GOTCH] = core->mac[TOTH];
+    e1000x_inc_reg_if_not_full(core->mac, GPTC);
+    e1000x_grow_8reg_if_not_full(core->mac, GOTCL, tot_len);
 
     if (core->mac[MRQC] & 1) {
         uint16_t pool = qn % IGB_NUM_VM_POOLS;
-- 
2.39.2


