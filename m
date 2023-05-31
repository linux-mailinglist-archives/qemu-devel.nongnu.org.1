Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90DE7180B7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMZ-0000ID-Gl; Wed, 31 May 2023 08:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMK-0008SQ-PI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMH-00076D-To
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtVHTHSgtDFcCIMGztK/pCz/cbU+mge1g7M3KyYoilo=; b=l1konDc5/FxM7vTodE5TbhrQVG
 4sNu1WKyqyQHS+RaMPETaqq7nuYciSmm5esOKUtNHMHLqA1cfTXiUFVl73JnON9rn+wYP0TezpIbZ
 30trzqYhb3wSP8ZhrJxDrwr3460NWPXcFSxx7vIxjkHS2vZfEHgKj+Mpcxev99HNVEcWsU4TGaqjR
 0ywCI0tXTgNX2cSahL34GqsqySeClBQ0JxBsbLlozlfNCBWxhBPI4Blp0G7Wsf1381XmWc+nv2NE/
 XhH9KSNTNqrhMr6F/q/QgBWK63wTO2x40BX5aorL52m2OO0G/9FyxPhFwXRuluf7vRJ+m8ll6ZPaC
 q9NJEDkKZSTUcojb3/ShMFqg40LNdFbWqs9U68aUii+OBpI5Fv+5Kv2+IxKwzeZK3L50whvjlu+2B
 Dzexsk40SvCiDGnA6lKq91WOoXm5h8Z61X5nS32wJBqTwLU7jjEU3EH0Xo1ia9/tOI1SVRXP3SyFu
 KznK4Zz2rVrMXP2wOPXTJbRDBq15WhU8TqNtfptHW9EKcOApNrbUT/+pBawK7JR+zpsF6thmOSAzQ
 xe3Qc3wDfHfmHhBh8IIJxbUm9M/Tu10ep+edaVVYPWlxfECRrtJk1ZpiS4SwvuHOZKDJTl2PNnlV0
 EMHN2fmthIRgj1A3AXQoqfUd+tHhH0WudMM1uP3Bs=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLy-0008vd-0P; Wed, 31 May 2023 13:55:06 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:52 +0100
Message-Id: <20230531125400.288917-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 15/23] q800: move ESCC device to Q800MachineState
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

Also change the instantiation of the ESCC device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index e25f6f1373..ac92daf190 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -347,7 +347,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCC */
 
-    dev = qdev_new(TYPE_ESCC);
+    object_initialize_child(OBJECT(machine), "escc", &m->escc,
+                            TYPE_ESCC);
+    dev = DEVICE(&m->escc);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -357,7 +359,7 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnBtype", 0);
     qdev_prop_set_uint32(dev, "chnAtype", 0);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
 
     /* Logically OR both its IRQs together */
     escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 82964cfea1..d03603fe02 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -26,6 +26,7 @@
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
+#include "hw/char/escc.h"
 
 /*
  * The main Q800 machine
@@ -40,6 +41,7 @@ struct Q800MachineState {
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
     dp8393xState dp8393x;
+    ESCCState escc;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


