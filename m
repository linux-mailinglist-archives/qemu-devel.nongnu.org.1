Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496482AC05
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:31:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsKE-0005cT-KC; Thu, 11 Jan 2024 05:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsKB-0005c3-Gz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:11 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsK9-00043H-Pq
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zM1v7/V+l90O/AZcVwimG76xJS8QgGJG3VkLRWtJzkk=; b=MDaYyCp6lzPFFn/MrFY4PVsfmD
 Ijvo1nuzPUHDxyrh5h+kAiBRygg5/ZN4vkrFHNPVsoLzvsJVGmllrebs05FILq71prwjQdz0FDvNB
 SMcYURbeewAlWIw1r0d8RQyHyJOhkHLRL2OoL5TokUE/8eUcqefc8eCUx8k/MneflB30dZ+bA6awE
 3Y/hJ8wWEBwi0UHck3M4QUiUbuxlATGjpHmbB8cykGvWm8hxo8dFXx+I/9x1rFN2guJueZ5lPLPme
 k+31MgVGFqWgv+iigVurH+i0lqtlOmgTDS/qSFapwb6ZW7VHql/tKrEsKAr7UXmsMg1Esm6xTDJ8i
 aFtS2xKrkHf5/0SB5YLxUiyKou/dqwDpSSbnUC5+guL3tEEow2zsXnBy3FJH4/3t3v2h1EfheBvf4
 KrnICSXnwB2KvYnxhqQ9Cd9EvKzfgJ3oA1qbrA9yERI7a8I/2ihrJNVaTUFuOmkI24C8mAXdatkgU
 cuQ7lEQqvIAGc3UgiDNUlaeeKdHxOx+EGv1XJkioN+YqnzyiRBCssBzTOpwgXS7cujxjOUwXl/jue
 o7U2VnjWcECGBbRZaSOGDn1TFalCl/mnr7/OLV4sM0lHfj/Ka/PQTbGDzsBZrY8GO6bGMOLMMWLkt
 ZhrE9h2c6HSJldBsgN2VeAjLSbzUkjk3TR/YwDGHs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsJa-000CMC-Q7; Thu, 11 Jan 2024 10:29:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Thu, 11 Jan 2024 10:29:52 +0000
Message-Id: <20240111102954.449462-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 1/3] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
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
and adjust the offset at which the Declaration ROM image is loaded, since Nubus
ROM images are unusual in that they are aligned to the end of the slot address
space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nubus/nubus-device.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 49008e4938..be4cb24696 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "exec/target_page.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/nubus/nubus.h"
@@ -30,7 +31,8 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     NubusDevice *nd = NUBUS_DEVICE(dev);
     char *name, *path;
     hwaddr slot_offset;
-    int64_t size;
+    int64_t size, align_size;
+    uint8_t *rom_ptr;
     int ret;
 
     /* Super */
@@ -76,16 +78,24 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
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
+        rom_ptr = memory_region_get_ram_ptr(&nd->decl_rom);
+        ret = load_image_size(path, rom_ptr + (uintptr_t)(align_size - size),
+                              size);
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


