Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822A7BFCB5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCOD-0007ds-W9; Tue, 10 Oct 2023 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNQ-0006mF-Rj
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNN-0006qv-Et
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:20 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6CAAA757249;
 Tue, 10 Oct 2023 15:01:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4BE1E757234; Tue, 10 Oct 2023 15:01:21 +0200 (CEST)
Message-Id: <64b829c3b9e3a9081b5dacc4801e03f817c3d736.1696942148.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1696942148.git.balaton@eik.bme.hu>
References: <cover.1696942148.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/3] ati-vga: Add 30 bit palette access register
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2023 15:01:21 +0200 (CEST)
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
index ce63935ead..684fdbf4e2 100644
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
@@ -684,6 +687,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
index bd0ecd48c7..84f48a83ea 100644
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
index d6282b2ef2..881469e6d6 100644
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


