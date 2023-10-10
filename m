Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D37BFCB2
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCO3-0006zD-W8; Tue, 10 Oct 2023 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNQ-0006lw-2d
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNN-0006qn-By
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 59ADD75723D;
 Tue, 10 Oct 2023 15:01:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 365A8757234; Tue, 10 Oct 2023 15:01:20 +0200 (CEST)
Message-Id: <fc668399935df877fe7f140d97c5e955dbe2574f.1696942148.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1696942148.git.balaton@eik.bme.hu>
References: <cover.1696942148.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/3] ati-vga: Support unaligned access to GPIO DDC registers
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2023 15:01:20 +0200 (CEST)
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

The GPIO_VGA_DDC and GPIO_DVI_DDC registers are used on Radeon for DDC
access. Some drivers like the PPC Mac FCode ROM uses unaligned writes
to these registers so implement this the same way as already done for
GPIO_MONID which is used the same way for the Rage 128 Pro.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f0bf1d7493..ce63935ead 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -319,11 +319,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DAC_CNTL:
         val = s->regs.dac_cntl;
         break;
-    case GPIO_VGA_DDC:
-        val = s->regs.gpio_vga_ddc;
+    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
+        val = ati_reg_read_offs(s->regs.gpio_vga_ddc,
+                                addr - GPIO_VGA_DDC, size);
         break;
-    case GPIO_DVI_DDC:
-        val = s->regs.gpio_dvi_ddc;
+    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
+        val = ati_reg_read_offs(s->regs.gpio_dvi_ddc,
+                                addr - GPIO_DVI_DDC, size);
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
         val = ati_reg_read_offs(s->regs.gpio_monid,
@@ -626,29 +628,34 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dac_cntl = data & 0xffffe3ff;
         s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
         break;
-    case GPIO_VGA_DDC:
+    /*
+     * GPIO regs for DDC access. Because some drivers access these via
+     * multiple byte writes we have to be careful when we send bits to
+     * avoid spurious changes in bitbang_i2c state. Only do it when either
+     * the enable bits are changed or output bits changed while enabled.
+     */
+    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
         if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
             /* FIXME: Maybe add a property to select VGA or DVI port? */
         }
         break;
-    case GPIO_DVI_DDC:
+    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
         if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c, data, 0);
+            ati_reg_write_offs(&s->regs.gpio_dvi_ddc,
+                               addr - GPIO_DVI_DDC, data, size);
+            if ((addr <= GPIO_DVI_DDC + 2 && addr + size > GPIO_DVI_DDC + 2) ||
+                (addr == GPIO_DVI_DDC && (s->regs.gpio_dvi_ddc & 0x30000))) {
+                s->regs.gpio_dvi_ddc = ati_i2c(&s->bbi2c,
+                                               s->regs.gpio_dvi_ddc, 0);
+            }
         }
         break;
     case GPIO_MONID ... GPIO_MONID + 3:
         /* FIXME What does Radeon have here? */
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            /* Rage128p accesses DDC via MONID(1-2) with additional mask bit */
             ati_reg_write_offs(&s->regs.gpio_monid,
                                addr - GPIO_MONID, data, size);
-            /*
-             * Rage128p accesses DDC used to get EDID via these bits.
-             * Because some drivers access this via multiple byte writes
-             * we have to be careful when we send bits to avoid spurious
-             * changes in bitbang_i2c state. So only do it when mask is set
-             * and either the enable bits are changed or output bits changed
-             * while enabled.
-             */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 ((addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) ||
                  (addr == GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
-- 
2.30.9


