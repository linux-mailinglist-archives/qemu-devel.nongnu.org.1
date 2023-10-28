Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B77DAA38
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 01:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwtAK-0007cX-Ib; Sat, 28 Oct 2023 19:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAJ-0007bZ-49
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAH-0006Jo-LC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 57AD07560AF;
 Sun, 29 Oct 2023 01:56:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 38760756082; Sun, 29 Oct 2023 01:56:26 +0200 (CEST)
Message-Id: <94c8fd2a10450a3c8418d84f75a937ecae497c2f.1698536342.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698536342.git.balaton@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/4] hw/audio/via-ac97: Route interrupts using
 via_isa_set_irq()
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Date: Sun, 29 Oct 2023 01:56:26 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
index 18cc2f653d..830aac7670 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -621,6 +621,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
         break;
     case 2: /* USB ports 0-1 */
     case 3: /* USB ports 2-3 */
+    case 5: /* AC97 audio */
         max_irq = 14;
         break;
     }
-- 
2.30.9


