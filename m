Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74376713842
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ANX-00040i-R9; Sun, 28 May 2023 02:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANU-0003tD-BX; Sun, 28 May 2023 02:59:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANS-0001pE-6Q; Sun, 28 May 2023 02:59:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4B398E1D;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 597737E27;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: (nullmailer pid 42616 invoked by uid 1000);
 Sun, 28 May 2023 06:59:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 46/53] e1000: Count CRC in Tx statistics
Date: Sun, 28 May 2023 09:59:19 +0300
Message-Id: <20230528065940.42582-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The Software Developer's Manual 13.7.4.5 "Packets Transmitted (64 Bytes)
Count" says:
> This register counts the number of packets transmitted that are
> exactly 64 bytes (from <Destination Address> through <CRC>,
> inclusively) in length.

It also says similar for the other Tx statistics registers. Add the
number of bytes for CRC to those registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit c50b152485d4e10dfa1e1d7ea668f29a5fb92e9c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick this for 7.2 too: a fix by its own and makes next patch to apply cleanly)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index e26e0a64c1..9cd3d6f495 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -567,7 +567,7 @@ e1000_send_packet(E1000State *s, const uint8_t *buf, int size)
         qemu_send_packet(nc, buf, size);
     }
     inc_tx_bcast_or_mcast_count(s, buf);
-    e1000x_increase_size_stats(s->mac_reg, PTCregs, size);
+    e1000x_increase_size_stats(s->mac_reg, PTCregs, size + 4);
 }
 
 static void
@@ -631,7 +631,7 @@ xmit_seg(E1000State *s)
     }
 
     e1000x_inc_reg_if_not_full(s->mac_reg, TPT);
-    e1000x_grow_8reg_if_not_full(s->mac_reg, TOTL, s->tx.size);
+    e1000x_grow_8reg_if_not_full(s->mac_reg, TOTL, s->tx.size + 4);
     s->mac_reg[GPTC] = s->mac_reg[TPT];
     s->mac_reg[GOTCL] = s->mac_reg[TOTL];
     s->mac_reg[GOTCH] = s->mac_reg[TOTH];
-- 
2.39.2


