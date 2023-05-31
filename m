Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401BF7180B3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMl-0001kf-I9; Wed, 31 May 2023 08:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMY-0000ZG-Bw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMW-00078d-0p
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FMprZowndr7kUahNoSEMiRVqxp7njc3H0sADhEsWwvc=; b=VqM1Sfn4+wenqYlbMXaW/kRJ4u
 Whscmx18grFztN3TTO+N1dUA+ggMAsdpIyEj0v2EnzcEpxiFcEIZfsgO5o3B5G2v1RTn1oI1PzbHj
 z4OBjyd+PBHDrz76FrEXUv2VmUKG1MzwmkrLvH211JWFLiALFimmDrnhkRrJZNbn2HDPehLyP24j/
 G2UHBW42xjw6nyqJ4Nr72WZKiGN0cOne71eBo5QbeU2Df2X2BFA2NWfSwBNdipmwkoDahpTi9JeZI
 nhJ3044vVZ2M1Uxx50LIJ2EUBFCdVpSC0qgdX4k5WWHK0ibs0oXGLHn05aDp0vK0CEzY1mbkqKzNj
 YRuxJ2up6FKrLm+m5OcwY03thOsE6HCfisEJT6CMQflgoF4hi3tKDpjV+bl3O2+hDUi0REJ3WXgut
 1Req8vhJYRwhbCUfFUs9kMaHje0HkXYIOcE1iwZlZMMiH7+AradoSvIIh0Oc614AiAxhBtydtGgPH
 qFzFZNUAKoHRUzZDek7Gbi8H9RlVbFRxgWZD7zfVW+gkOAQLEQZC6fhmwmgJLNL6bo/IkK4vfpved
 yWozPaOJ55eRCZr+7t5sXlvbaN6y/tFUKfzRdukE2ffqFGX1qFxKbX4vRutj42lBN5K0Ma5eZu8yr
 DrCkLcSnoHqpsIxJPR2Y5yTzNoeElKTO6NRjpQTxE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMB-0008vd-5q; Wed, 31 May 2023 13:55:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:56 +0100
Message-Id: <20230531125400.288917-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
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

Also change the instantiation of the mac-nubus-bridge device to use
object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 5 ++++-
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index f85ccf83af..d02a1a7a1f 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -416,7 +416,10 @@ static void q800_machine_init(MachineState *machine)
 
     /* NuBus */
 
-    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
+    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
+                            &m->mac_nubus_bridge,
+                            TYPE_MAC_NUBUS_BRIDGE);
+    dev = DEVICE(&m->mac_nubus_bridge);
     qdev_prop_set_uint32(dev, "slot-available-mask",
                          Q800_NUBUS_SLOTS_AVAILABLE);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index ce8dbcd68f..3f3e87b3dc 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -30,6 +30,7 @@
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
 #include "hw/block/swim.h"
+#include "hw/nubus/mac-nubus-bridge.h"
 
 /*
  * The main Q800 machine
@@ -48,6 +49,7 @@ struct Q800MachineState {
     OrIRQState escc_orgate;
     SysBusESPState esp;
     Swim swim;
+    MacNubusBridge mac_nubus_bridge;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


