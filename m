Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDD7180A4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMi-0000hA-0a; Wed, 31 May 2023 08:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMK-0008SP-PI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMI-00076K-By
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1dcwIj33r7Gnsw4UH1am16T8UAiCxUApnnLxiJNQjdk=; b=11BlxfzjUgDb/UqmbXuR5O9z+a
 U95cpJzFeN/3BpbX2XiTaIQT3juCxGrCVQIC0jelA/6fCll39aQfUA3LH/lMBcJVh+Q8kCeVLajfp
 4vU3HjJW+Hml7yNaRJOJFcVfJ6VUetGSl1viFVmCV1EWrnmV7r5o7btkxhNIUMH4laxY+cGShpPGc
 5rVmPI0iH3WKe1rDn+MSCCxzDvYZJaHRU+4IKS9oerDsVDp8JBx8xAsqZOiqG97QUu38MQwjj9caP
 Xb74/5wH2Zm/3E7fM+M5YyS0stNMuwRVE/Umw7WjQGclB6qeuYhvnHOwEFdN0nW9GwTbLb2mrT2mC
 7bWW2a7wDpddv2Yzvq4FAYexBax26rKVXEl1rhN53JJj7dvD3B0TtVxtzTNc8Rrj3clbTRlpKNaBv
 WbEDmleLIDeMMSTNzolRxENgsUw6Bm+Gu1SigM+IG5DLLPvwNMyLyLMRxZL1gTGuV9FEokotZLHxr
 Lo1ihdRPWzTxXI8ZDBiwP4L7JniBI7EOu3KfpEyH90nlDKxAr+JyYS5Sm/3iQHSn74dgDjTGFYWBZ
 C3CKakt0nIqUTSsjP+WlUT0VY83S1PUmi5s0obDEpZBg8D/FG3+2H+4gwqbQT94/ZyQ123uzu+aOh
 QGoeiGOceV2f4ZSzRQos3nBNpV15jEcALmiPwXNZU=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM2-0008vd-8D; Wed, 31 May 2023 13:55:06 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:53 +0100
Message-Id: <20230531125400.288917-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/23] q800: move escc_orgate device to Q800MachineState
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

Also change the instantiation of the escc_orgate device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 16 +++++++++-------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ac92daf190..6f54677e5f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
-    DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
     SysBusDevice *sysbus;
@@ -362,12 +361,15 @@ static void q800_machine_init(MachineState *machine)
     sysbus_realize(sysbus, &error_fatal);
 
     /* Logically OR both its IRQs together */
-    escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
-    object_property_set_int(OBJECT(escc_orgate), "num-lines", 2, &error_fatal);
-    qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
-    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
-    qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
+    object_initialize_child(OBJECT(machine), "escc_orgate", &m->escc_orgate,
+                            TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&m->escc_orgate), "num-lines", 2,
+                            &error_fatal);
+    dev = DEVICE(&m->escc_orgate);
+    qdev_realize(dev, NULL, &error_fatal);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(dev, 0));
+    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(dev, 1));
+    qdev_connect_gpio_out(dev, 0,
                           qdev_get_gpio_in(DEVICE(&m->glue),
                                            GLUE_IRQ_IN_ESCC));
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d03603fe02..f9af314ee1 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -27,6 +27,7 @@
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
+#include "hw/or-irq.h"
 
 /*
  * The main Q800 machine
@@ -42,6 +43,7 @@ struct Q800MachineState {
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
     ESCCState escc;
+    OrIRQState escc_orgate;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


