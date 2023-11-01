Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E577DE6E9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:46:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI5u-0002PG-4l; Wed, 01 Nov 2023 16:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5n-0001vr-26
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:35 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5j-0001SV-9V
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E587E7560A3;
 Wed,  1 Nov 2023 21:45:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B6A4D75608E; Wed,  1 Nov 2023 21:45:37 +0100 (CET)
Message-Id: <dff6ce16ccabdfd54ffda348bf57c6d8b810cd98.1698871239.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698871239.git.balaton@eik.bme.hu>
References: <cover.1698871239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/4] ati-vga: Support unaligned access to GPIO DDC registers
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Date: Wed,  1 Nov 2023 21:45:37 +0100 (CET)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, PP_MIME_FAKE_ASCII_TEXT=0.001,
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

The GPIO_VGA_DDC and GPIO_DVI_DDC registers are used on Radeon for DDC
access. Some drivers like the PPC Mac FCode ROM uses unaligned writes
to these registers so implement this the same way as already done for
GPIO_MONID which is used the same way for the Rage 128 Pro.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ati.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ea7ab89a19..b56dabaccb 100644
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
@@ -629,29 +631,34 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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


