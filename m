Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B6E72328C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:52:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6I7H-00071o-J6; Mon, 05 Jun 2023 17:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6I7F-00071a-Ks; Mon, 05 Jun 2023 17:51:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6I7B-0005gG-0O; Mon, 05 Jun 2023 17:51:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 592BC746361;
 Mon,  5 Jun 2023 23:51:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 29458746335; Mon,  5 Jun 2023 23:51:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] mv64361: Add dummy gigabit ethernet PHY access registers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230605215145.29458746335@zero.eik.bme.hu>
Date: Mon,  5 Jun 2023 23:51:45 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We don't emulate the gigabit ethernet part of the chip but the MorphOS
driver accesses these and expects to get some valid looking result
otherwise it hangs. Add some minimal dummy implementation to avoid rhis.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This is only used by MorphOS on pegasos2 so most likely could go via
the ppc queue.

 hw/pci-host/mv64361.c | 6 ++++++
 hw/pci-host/mv643xx.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 19e8031a3f..01bd8c887f 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -541,6 +541,12 @@ static uint64_t mv64361_read(void *opaque, hwaddr addr, unsigned int size)
             }
         }
         break;
+    case MV64340_ETH_PHY_ADDR:
+        ret = 0x98;
+        break;
+    case MV64340_ETH_SMI:
+        ret = BIT(27);
+        break;
     case MV64340_CUNIT_ARBITER_CONTROL_REG:
         ret = 0x11ff0000 | (s->gpp_int_level << 10);
         break;
diff --git a/hw/pci-host/mv643xx.h b/hw/pci-host/mv643xx.h
index cd26a43f18..f2e1baea88 100644
--- a/hw/pci-host/mv643xx.h
+++ b/hw/pci-host/mv643xx.h
@@ -656,6 +656,9 @@
 /*        Ethernet Unit Registers       */
 /****************************************/
 
+#define MV64340_ETH_PHY_ADDR                                        0x2000
+#define MV64340_ETH_SMI                                             0x2004
+
 /*******************************************/
 /*          CUNIT  Registers               */
 /*******************************************/
-- 
2.30.9


