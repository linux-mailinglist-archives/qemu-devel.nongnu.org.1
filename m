Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C289718081
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMZ-0000Kd-He; Wed, 31 May 2023 08:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMT-00007h-3h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMR-000786-9L
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YfVQ40A0FC/1EME5C1PnA14rj7TzYJJbdBuzdYqpX4w=; b=i79MfBIH+tlu2hetAaioKP2jyt
 vPA5vCwGpALWKWd0yvCzWmmpORd4wuDqzh/GnFaAkqIwtC/pxjpdFFy92jOqYfVze9TqpnuC46TkY
 FmzcqxMNd40+VEpu+BYiuZ45dGdDVp+F8WsYViq8FiAJELhaEKCWxKKn6USbN095Ww3NfKrpKOwcd
 J1YIIxAvmqW555HCMNuq2tPNY5JKS1TjmL+h7sVLtbLfDiCnjE16PztltBNd25DmlSOm9+I+TvT+x
 /XhM4oX385Ap5/wWr7qMSQkkx25Qwpwiuk1AM8y4LqcWCy8nsnvuFQ7P4frg26SYqx5t5aO6sx7E2
 hLCHPTQTjw+kWAelWHZfaHweCMHoWUg1cQifahSOfThxOJPKwZlpYLFL9FUVoLJWqJ0+GWoFyuhYF
 cEh3Gei5VO/Hvx09LyGYaKWHE4cay8POODIWTCde/EvnZT/zOmMurP7fpD0/jszwe/toYCx1ruLwv
 NLnHN5MzmX0HA/Gh1VYowwNxjdFKwSLBGR8LzU8dytMBev7I9S25FDERh+6MxrTCPWy/uJjt1b/BT
 2xzdWDrop7nRCZFbmQgKI9SUikEVlYiBarNG5mfn1muJrb2W1i6QrK7o1Y/mPLxslSQg9YyzBH26u
 chWQj4ZztxJJsv9GlMcg6pNox1y5OvbgPDvAR0yKs=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM6-0008vd-UO; Wed, 31 May 2023 13:55:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:55 +0100
Message-Id: <20230531125400.288917-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/23] q800: move SWIM device to Q800MachineState
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

Also change the instantiation of the SWIM device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 8 +++++---
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index befef5f822..f85ccf83af 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -407,10 +407,12 @@ static void q800_machine_init(MachineState *machine)
 
     /* SWIM floppy controller */
 
-    dev = qdev_new(TYPE_SWIM);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_initialize_child(OBJECT(machine), "swim", &m->swim,
+                            TYPE_SWIM);
+    sysbus = SYS_BUS_DEVICE(&m->swim);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+                                sysbus_mmio_get_region(sysbus, 0));
 
     /* NuBus */
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index ba76aa37f2..ce8dbcd68f 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -29,6 +29,7 @@
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
+#include "hw/block/swim.h"
 
 /*
  * The main Q800 machine
@@ -46,6 +47,7 @@ struct Q800MachineState {
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
+    Swim swim;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


