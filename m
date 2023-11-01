Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE57DE6DF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI5z-00038z-HN; Wed, 01 Nov 2023 16:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5n-0001w1-32
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5i-0001Rw-LJ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C4171756094;
 Wed,  1 Nov 2023 21:45:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A6A0A75608E; Wed,  1 Nov 2023 21:45:36 +0100 (CET)
Message-Id: <d077d4f90d19db731df78da6f05058db074cada1.1698871239.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698871239.git.balaton@eik.bme.hu>
References: <cover.1698871239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 1/4] ati-vga: Fix aperture sizes
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Date: Wed,  1 Nov 2023 21:45:36 +0100 (CET)
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

Apparently these should be half the memory region sizes confirmed at
least by Radeon FCocde ROM while Rage 128 Pro ROMs don't seem to use
these. Linux r100 DRM driver also checks for a bit in HOST_PATH_CNTL
so we also add that even though the FCode ROM does not seem to set it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 7 +++++--
 hw/display/ati_dbg.c  | 1 +
 hw/display/ati_regs.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c36282c343..ea7ab89a19 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -349,14 +349,17 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                       PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
         break;
     case CONFIG_APER_SIZE:
-        val = s->vga.vram_size;
+        val = s->vga.vram_size / 2;
         break;
     case CONFIG_REG_1_BASE:
         val = pci_default_read_config(&s->dev,
                                       PCI_BASE_ADDRESS_2, size) & 0xfffffff0;
         break;
     case CONFIG_REG_APER_SIZE:
-        val = memory_region_size(&s->mm);
+        val = memory_region_size(&s->mm) / 2;
+        break;
+    case HOST_PATH_CNTL:
+        val = BIT(23); /* Radeon HDP_APER_CNTL */
         break;
     case MC_STATUS:
         val = 5;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index bd0ecd48c7..4aec1c383a 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -38,6 +38,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"CONFIG_APER_SIZE", 0x0108},
     {"CONFIG_REG_1_BASE", 0x010c},
     {"CONFIG_REG_APER_SIZE", 0x0110},
+    {"HOST_PATH_CNTL", 0x0130},
     {"MEM_CNTL", 0x0140},
     {"MC_FB_LOCATION", 0x0148},
     {"MC_AGP_LOCATION", 0x014C},
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d6282b2ef2..c697b328da 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -56,6 +56,7 @@
 #define CONFIG_APER_SIZE                        0x0108
 #define CONFIG_REG_1_BASE                       0x010c
 #define CONFIG_REG_APER_SIZE                    0x0110
+#define HOST_PATH_CNTL                          0x0130
 #define MEM_CNTL                                0x0140
 #define MC_FB_LOCATION                          0x0148
 #define MC_AGP_LOCATION                         0x014C
-- 
2.30.9


