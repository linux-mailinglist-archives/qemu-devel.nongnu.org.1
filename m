Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA967F95EB
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 23:51:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Nwg-0002fs-0e; Sun, 26 Nov 2023 17:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwY-0002fA-DR
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwV-0002Pr-Lj
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:38 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E60B75A4C6;
 Sun, 26 Nov 2023 23:49:33 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0420E75A4BF; Sun, 26 Nov 2023 23:49:33 +0100 (CET)
Message-Id: <5329840e4be6dd8ae143d07cbfe61d8d2d106654.1701035944.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1701035944.git.balaton@eik.bme.hu>
References: <cover.1701035944.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 4/4] hw/audio/via-ac97: Route interrupts using
 via_isa_set_irq()
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
Date: Sun, 26 Nov 2023 23:49:33 +0100 (CET)
X-Virus-Scanned: ClamAV using ClamSMTP
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

This device is a function of VIA south bridge and should allow setting
interrupt routing within that chip. This is implemented in
via_isa_set_irq().

Fixes: eb604411a78b82c468e2b8d81a9401eb8b9c7658
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/audio/via-ac97.c | 8 ++++----
 hw/isa/vt82c686.c   | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 30095a4c7a..4c127a1def 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -211,14 +211,14 @@ static void out_cb(void *opaque, int avail)
                     AUD_set_active_out(s->vo, 0);
                 }
                 if (c->type & STAT_EOL) {
-                    pci_set_irq(&s->dev, 1);
+                    via_isa_set_irq(&s->dev, 0, 1);
                 }
             }
             if (CLEN_IS_FLAG(c)) {
                 c->stat |= STAT_FLAG;
                 c->stat |= STAT_PAUSED;
                 if (c->type & STAT_FLAG) {
-                    pci_set_irq(&s->dev, 1);
+                    via_isa_set_irq(&s->dev, 0, 1);
                 }
             }
             if (CLEN_IS_STOP(c)) {
@@ -305,13 +305,13 @@ static void sgd_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         if (val & STAT_EOL) {
             s->aur.stat &= ~(STAT_EOL | STAT_PAUSED);
             if (s->aur.type & STAT_EOL) {
-                pci_set_irq(&s->dev, 0);
+                via_isa_set_irq(&s->dev, 0, 0);
             }
         }
         if (val & STAT_FLAG) {
             s->aur.stat &= ~(STAT_FLAG | STAT_PAUSED);
             if (s->aur.type & STAT_FLAG) {
-                pci_set_irq(&s->dev, 0);
+                via_isa_set_irq(&s->dev, 0, 0);
             }
         }
         break;
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index a3eb6769fc..9c2333a277 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -622,6 +622,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
         break;
     case 2: /* USB ports 0-1 */
     case 3: /* USB ports 2-3 */
+    case 5: /* AC97 audio */
         max_irq = 14;
         break;
     }
-- 
2.30.9


