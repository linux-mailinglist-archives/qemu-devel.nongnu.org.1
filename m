Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398787398B9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAn-0004FJ-Jc; Thu, 22 Jun 2023 03:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00042i-QF
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAa-0002tM-EN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MofLl-1pjAp91EAT-00p3r5; Thu, 22
 Jun 2023 09:55:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/24] q800: move ESCC device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:36 +0200
Message-Id: <20230622075544.210899-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+9Z7l2cpk3VirFoUWI2Ac+rwZ3uJHXimiOlZnGV0HKwJC5kZ47J
 tqz3snW8/kNhGTiU1tStb4gwl8PlqQcwm0wt7ehNzWXWv6rjcqxecTBEP6QTxK9qKxDLhvB
 LW7pqEASCecyGTgmVfOuEykSnKjk2j9obXSB7WOhMpx7VogYx2tOyIN6OI9ksgXVzQyPh9H
 ldSie+owyYj7vStv9cKIw==
UI-OutboundReport: notjunk:1;M01:P0:dZnF26nBPnI=;BShbyPGpeg/t32Jv+iQ4o1oYPPO
 E0AjhwkgadvpWwHc1ZBvoAXeLGPQmhc/zkM60B8gcbtPDo0aiiK+U/iH5Hm59IEu8Vo+VqDck
 TOTue7ZsA0D9rDbccWc2xs3kRk4Q4bGZJZFOWTK+aF22AHMqUFCmKS53vZiu+vzKvqXiv2jt9
 Z3yRXMqRGv+tHIn2HRp61lR9IBlzLDi15u05yV/krP0voXc/IK99aXpTE0OM4UR0eahFiauBz
 Aw0LpiWO6UIhcpbYsE9Q5nBSO7tHNh9/414wxBA7HfQ/+A+dZxH0mIc3uFF0IEqEJNcwkcYs8
 8vqhAYTfiTI4/ezv0s/+iddu82dDxkNOWjljBFXBe5nVamEHeJtQBXlWVQw4X+7/EIoA8lL7R
 Z/Rsf2ngQoHgIvaNv2t5m4Fl/MauS7k+14W5t8UGgU8RIoCrxBBhDny1hUrGw6foVkVhQJ7s3
 lKyFUojBrYvEj8J3DHUxhN3JT6yOuEuYltPGqIxLXQBI1TX4PsBIhQsLjM8Diym26wI5NCM3I
 5wNwtPNL0iwtpEmWHMl/9XD3FVVapD6VlARG3gb+OIvp9EgYq1ZVdVS6eLHhSEmpWxRkwCd7A
 rsMbC6+qVGY+Oe3TxzU+Z02HyNlQjFio9uD7cqvscn9KXgeoIxMG4CRs0JxgBRBPOqklT/Sai
 l9xAcUjIBpHdxnOAz5VP1gYnINg1pgzAKtFpM4maCA==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also change the instantiation of the ESCC device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-17-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 2 ++
 hw/m68k/q800.c         | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d11bc020ed98..9e76a3fe7c0c 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -30,6 +30,7 @@
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
+#include "hw/char/escc.h"
 
 /*
  * The main Q800 machine
@@ -44,6 +45,7 @@ struct Q800MachineState {
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
+    ESCCState escc;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 13806613fa36..8bf94b2511c1 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -346,7 +346,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCC */
 
-    dev = qdev_new(TYPE_ESCC);
+    object_initialize_child(OBJECT(machine), "escc", &m->escc,
+                            TYPE_ESCC);
+    dev = DEVICE(&m->escc);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -356,7 +358,7 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnBtype", 0);
     qdev_prop_set_uint32(dev, "chnAtype", 0);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
 
     /* Logically OR both its IRQs together */
     escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
-- 
2.40.1


