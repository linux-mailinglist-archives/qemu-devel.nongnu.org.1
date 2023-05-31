Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D87180C8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMl-0001kx-IA; Wed, 31 May 2023 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMb-0000rQ-3d
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMZ-00079T-LX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FLgk3x1zkkh+bFdaen4SKpw14JiJMofGQ5nOc7X9/gQ=; b=GG4cUlszWUcqKlOiZPUt4k+4O4
 vHmr6o8F0SzcLZa+Jk/jzK3I0fL1pwqQopzn+Heg6wr0Dbpr7xzEObjxZvtTYuIoJD4GuP9OCaHIc
 bi/0NQCIKCEN6EZPjwiYLgW008vGZGhuGkqnEU8z+5FY5eLe0KKfLp2VzkdWv+Qc1CDOsYOsFSZJJ
 1l32n9TUTv555iEmLJmH/W7T2ztbsofN3YYyG9CeULAQUBZjOdQnPStlw1AvpRzrdOz22NHcsXVeG
 wod0Wvqg8uw4scP0/rm2r/5ccOHCkz7lZ0GetV35MI0cgR66BQ0SeF7jdNZF+pvBoRwMNcuVurYXx
 8oijBm9E68HJ4K/gyZZP8w+ovZsMSVLjYWu46FOWfUWvBMYScNplmmMGRkmOtSbKr9zHMn75d/bfA
 vMv8bxTU83oBKZMyn8+k+TDITesoOQvUYEo9e9emQHUmwUtOG3mDak7+We2TKnKyFPsePgkbhHCsQ
 9gXjpRqQClN6zTFeRZYutX777rdnjsVZ2s85xkSicn5K38zVgjLu+N8k7B6KNTQ4kp+tj1MZCc9AH
 2CNW0kHZICO2su9FNdQ67cidc88t9ubcXW5Szh4ACucltUnGjrPxGstFZZCSDjaGPzkka96HEHbWo
 XDS9R97R7BM+2ltec1DeG2LKLs9A4hf3qDgDCus5o=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMF-0008vd-Of; Wed, 31 May 2023 13:55:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:58 +0100
Message-Id: <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 21/23] q800: move macfb device to Q800MachineState
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

Also change the instantiation of the macfb device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 946cb09e30..0e7451e77a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -449,7 +449,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* framebuffer in nubus slot #9 */
 
-    dev = qdev_new(TYPE_NUBUS_MACFB);
+    object_initialize_child(OBJECT(machine), "macfb", &m->macfb,
+                            TYPE_NUBUS_MACFB);
+    dev = DEVICE(&m->macfb);
     qdev_prop_set_uint32(dev, "slot", 9);
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
@@ -459,7 +461,7 @@ static void q800_machine_init(MachineState *machine)
     } else {
         qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
     }
-    qdev_realize_and_unref(dev, BUS(nubus), &error_fatal);
+    qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 3f3e87b3dc..48d2443d74 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -31,6 +31,7 @@
 #include "hw/scsi/esp.h"
 #include "hw/block/swim.h"
 #include "hw/nubus/mac-nubus-bridge.h"
+#include "hw/display/macfb.h"
 
 /*
  * The main Q800 machine
@@ -50,6 +51,7 @@ struct Q800MachineState {
     SysBusESPState esp;
     Swim swim;
     MacNubusBridge mac_nubus_bridge;
+    MacfbNubusState macfb;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


