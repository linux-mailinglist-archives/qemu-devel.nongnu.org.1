Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBD827872
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 20:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMvAq-000769-1d; Mon, 08 Jan 2024 14:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvAo-00072m-3B
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 14:20:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvAm-0002vv-Gd
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 14:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CWD1RWZn0JyYjmI8Ws09PfuEYZ6K711mm6AOuu5s5gE=; b=AvIl4xBcocQz3ftZ4dnlRu6h4C
 HiVVf3KiV+vljX05ZBf6SFrOSFkViiW03h/7jSiN7q0yoHXxBlPhQoPYw40jLBFZL+JmXTktuBU50
 ONKcRRkPWgsyCLN58r3KkWwz2OPXYexay+lap+9Y0ReZClSZneP8CXrGgCgRBe0aHcjhjK0Ng990o
 qZ3JPenjquZe+iIHVYCoIivDxoJhKIb4GIdomu4Mtv9lmdcnof2T2XJHdFlV/XHCduscww2Mgu70f
 +e04QyWeLiht8JluCZC7AWp7zKlKetxJzmXqs/M6k22s2S9oTEVovpkmOj349K7p5zhq3dGsv4Nnl
 ilUIlHluc3wcolqPKrZLy1HAkyZHdZsrLRUo1r8Mm7LT8TTBmqKsCZlXkd3hiGQDc9GurV8+ilKEk
 LhpAPpIWcDZAiOYAv7WxfzFdZ6WNrmPLlOJ0e67SWF0EpDCeLIFDB1oSpKaW68nTr4KZnljUUfplb
 ToQK0eqKVPomm1Ic1aVNxXkkcMvoVzunuW1ZY9/StDpKTz6wHARvCvEaH6Xnw5A1DdqpChFRRcyKY
 AlYM/NOL5Vxu7PKTSVnZUw1fT+DM4wIxKX2259X4Lwhnn+C7xdBBf2JenVYHCmN8wRMMO1TCUou3w
 BZAhT51hIhKLbLHiRb4KEb5q5spCX0bdykwihAV/Q=;
Received: from [2a00:23c4:8bb1:9800:102b:b374:b08c:8889]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvAC-0000nV-2i; Mon, 08 Jan 2024 19:20:00 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Mon,  8 Jan 2024 19:20:12 +0000
Message-Id: <20240108192013.272112-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
References: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:102b:b374:b08c:8889
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 1/2] nubus-device: round Declaration ROM memory region
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


