Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DBB826614
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 22:27:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMaeX-0003Hv-Az; Sun, 07 Jan 2024 16:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeU-0003GX-I0
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeS-0004CA-Qg
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eZeFnb3Oh4rG2aeme4hdysTC/iaojickaP+hb4fTWLA=; b=YsG1DtVsYUzCsd8XxxgwhGeW7f
 s+i0sOWL8Xfmj8YDP39kY+1ufcjP3jgJpJ4hvsQ/o/BuRV6/GsB3sGH5ALppVVI6FQQNPYZryyJOO
 1nfTUHDPHCTc70JK/TlBFquehQtsO5gpnLX6Ia9XVas9TTy8AlzOyN7iOfafQ6unFX3jv2wHViTFe
 4R/rdsVKVT2N3lbv+LWqSkeET2s7b7h05UwBwqJHgBa3Pt1yAhqwpg4nArzSBBb41Mevbih735RVZ
 dSmGClTze/HuzGECj+80+IjQUwLOhSqYCEL+sIgXdXSnKWlDBN0KmAp8/KUJ7Xra0H6ftMRE+DLEB
 vlLTV4geEL55zLuwsB7WnroKXE1VxKGed2CHumq1tTy784xxkR/rm8WQn5tqiw5LdQaHbQoBw0vDo
 nV20I/91Kj1iy9gEMdLjkteJZU7qs9oGBDoCSPUfjNFOGBc2zhUd4XesbyU7Xk9vhlvvrtU8JdJVO
 94GouXJjekTyoiTXTOk9AFxIzVPoZn/+es9vNI5CLLpGs344qBIJZFTEi9Nh6fEth1XlVjGAcYTeS
 Mg/YTiv1Dd7yq6taNmd7UZZXsO6BnjRohh6+ixLoI0iUcdHzO66NjgOX9ELMLldqVG2PC9l0hP9hA
 I+Q/NqxlQk16kTTJS3c24NCb/OajAGZvQmBUGp7j0=;
Received: from [2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMadx-0006OD-3m; Sun, 07 Jan 2024 21:25:17 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Sun,  7 Jan 2024 21:25:37 +0000
Message-Id: <20240107212538.227627-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
References: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/2] nubus-device: round Declaration ROM memory region address
 to qemu_target_page_size()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Declaration ROM binary images can be any arbitrary size, however if a host ROM
memory region is not aligned to qemu_target_page_size() then we fail the
"assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().

Ensure that the host ROM memory region is aligned to qemu_target_page_size()
and adjust the offset at which the Declaration ROM image is loaded so that the
image is still aligned to the end of the Nubus slot.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nubus/nubus-device.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 49008e4938..e4f824d58b 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "exec/target_page.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/nubus/nubus.h"
@@ -30,7 +31,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     NubusDevice *nd = NUBUS_DEVICE(dev);
     char *name, *path;
     hwaddr slot_offset;
-    int64_t size;
+    int64_t size, align_size;
     int ret;
 
     /* Super */
@@ -76,16 +77,23 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
         }
 
         name = g_strdup_printf("nubus-slot-%x-declaration-rom", nd->slot);
-        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, size,
+
+        /*
+         * Ensure ROM memory region is aligned to target page size regardless
+         * of the size of the Declaration ROM image
+         */
+        align_size = ROUND_UP(size, qemu_target_page_size());
+        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, align_size,
                                &error_abort);
-        ret = load_image_mr(path, &nd->decl_rom);
+        ret = load_image_size(path, memory_region_get_ram_ptr(&nd->decl_rom) +
+                                    (uintptr_t)align_size - size, size);
         g_free(path);
         g_free(name);
         if (ret < 0) {
             error_setg(errp, "could not load romfile \"%s\"", nd->romfile);
             return;
         }
-        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - size,
+        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - align_size,
                                     &nd->decl_rom);
     }
 }
-- 
2.39.2


