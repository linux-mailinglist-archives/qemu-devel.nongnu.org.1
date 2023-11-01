Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E632D7DE6ED
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:46:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI61-0003Jl-7r; Wed, 01 Nov 2023 16:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5n-0001yQ-DU
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5j-0001TS-Lr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E66177560AC;
 Wed,  1 Nov 2023 21:45:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C322575608E; Wed,  1 Nov 2023 21:45:38 +0100 (CET)
Message-Id: <9fa19eec95d1563cc65853cf26912f230c702b32.1698871239.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698871239.git.balaton@eik.bme.hu>
References: <cover.1698871239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 3/4] ati-vga: Add 30 bit palette access register
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Date: Wed,  1 Nov 2023 21:45:38 +0100 (CET)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Radeon cards have a 30 bit DAC and corresponding palette register to
access it. We only use 8 bits but let the guests use 10 bit color
values for those that access it through this register.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 9 +++++++++
 hw/display/ati_dbg.c  | 1 +
 hw/display/ati_int.h  | 1 +
 hw/display/ati_regs.h | 1 +
 4 files changed, 12 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index b56dabaccb..5e38d2c3de 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -339,6 +339,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case PALETTE_DATA:
         val = vga_ioport_read(&s->vga, VGA_PEL_D);
         break;
+    case PALETTE_30_DATA:
+        val = s->regs.palette[vga_ioport_read(&s->vga, VGA_PEL_IR)];
+        break;
     case CNFG_CNTL:
         val = s->regs.config_cntl;
         break;
@@ -687,6 +690,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         data >>= 8;
         vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
         break;
+    case PALETTE_30_DATA:
+        s->regs.palette[vga_ioport_read(&s->vga, VGA_PEL_IW)] = data;
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 22) & 0xff);
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 12) & 0xff);
+        vga_ioport_write(&s->vga, VGA_PEL_D, (data >> 2) & 0xff);
+        break;
     case CNFG_CNTL:
         s->regs.config_cntl = data;
         break;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 4aec1c383a..3ffa7f35df 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -30,6 +30,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"AMCGPIO_EN_MIR", 0x00a8},
     {"PALETTE_INDEX", 0x00b0},
     {"PALETTE_DATA", 0x00b4},
+    {"PALETTE_30_DATA", 0x00b8},
     {"CNFG_CNTL", 0x00e0},
     {"GEN_RESET_CNTL", 0x00f0},
     {"CNFG_MEMSIZE", 0x00f8},
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index e8d3c7af75..8abb873f01 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -44,6 +44,7 @@ typedef struct ATIVGARegs {
     uint32_t gpio_dvi_ddc;
     uint32_t gpio_monid;
     uint32_t config_cntl;
+    uint32_t palette[256];
     uint32_t crtc_h_total_disp;
     uint32_t crtc_h_sync_strt_wid;
     uint32_t crtc_v_total_disp;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index c697b328da..d7127748ff 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -48,6 +48,7 @@
 #define AMCGPIO_EN_MIR                          0x00a8
 #define PALETTE_INDEX                           0x00b0
 #define PALETTE_DATA                            0x00b4
+#define PALETTE_30_DATA                         0x00b8
 #define CNFG_CNTL                               0x00e0
 #define GEN_RESET_CNTL                          0x00f0
 #define CNFG_MEMSIZE                            0x00f8
-- 
2.30.9


