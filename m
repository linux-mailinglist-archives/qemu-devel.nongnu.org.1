Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B763718099
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMh-0000fS-FC; Wed, 31 May 2023 08:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMP-000054-Ab
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMN-00076o-E6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZVui88XC36ScTHqtypcT+aeEWA2HSaHw2DB9kGzNYB0=; b=RGHqLba6FVHkY9jFK0IJAbUqKV
 0A/rwtIUJ6LV6+tEfBSwuDArcSPdrwnmTQday9sw/flE9PMyBYcep0QAeVX+bKXJ7DFL1iZyBYiUs
 99qaYihGomRj57NaFZFxxr3nRSwyW/g6Ep80Avf/2jPlp6Mu0Sb1qw08qVf+53Fd2elIE7gk6iuY9
 R+bLq4ogpXolZLSqiG6llHQnEOfvA7lkT828hrBrIyxdvoSNtAUa7rZbcEk+3mm1XHLHXyAh/t9k5
 nsv7j2BZIW3U48lce/fUDb4nlMCB1ZAP9iTpSiP30+0VOTaoO2a6YCXZoW7UpRG0Oe1ZPGNYhG+hY
 JKRvvoXGvGDvhfuu6SIXSiIQVsamWwond27NP1TiFwr9h4DAzXxNRjnwUu4i+1c1rfro13SjlZr19
 D0ihwGn15/Mmou67e22mUZRkZShA2VYRGqK/Fzt99TVUkE+7LY9z3MgkcZAz2tUf/b2gISpebkffb
 o9rXRNzfqhWR5oUN7tn7VR+j7lsORQDbtiRtVXFfOTG2XsnMRmxdsyCpiOXsw5LS6ya+EBPCTxRsG
 /8JRSl5CXtV6VvrFgs+/2SypIUR/UfiA/pETTJIGGhe3aaFJD5kOQ6Uy7YjMfi1oKATWBSJX4Qwaj
 qqrW0tpfIbCkw+ZlwzzQY22qKBxt5Ul+ESYxsP8Rk=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM2-0008vd-NG; Wed, 31 May 2023 13:55:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:54 +0100
Message-Id: <20230531125400.288917-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 17/23] q800: move ESP device to Q800MachineState
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

Also change the instantiation of the ESP device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 9 +++++----
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 6f54677e5f..befef5f822 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -377,8 +377,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCSI */
 
-    dev = qdev_new(TYPE_SYSBUS_ESP);
-    sysbus_esp = SYSBUS_ESP(dev);
+    object_initialize_child(OBJECT(machine), "esp", &m->esp,
+                            TYPE_SYSBUS_ESP);
+    sysbus_esp = SYSBUS_ESP(&m->esp);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = NULL;
     esp->dma_memory_write = NULL;
@@ -386,8 +387,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus_esp->it_shift = 4;
     esp->dma_enabled = 1;
 
-    sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus = SYS_BUS_DEVICE(&m->esp);
+    sysbus_realize(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
     sysbus_connect_irq(sysbus, 0,
                        qemu_irq_invert(
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index f9af314ee1..ba76aa37f2 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -28,6 +28,7 @@
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
+#include "hw/scsi/esp.h"
 
 /*
  * The main Q800 machine
@@ -44,6 +45,7 @@ struct Q800MachineState {
     dp8393xState dp8393x;
     ESCCState escc;
     OrIRQState escc_orgate;
+    SysBusESPState esp;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


