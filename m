Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E3737DF1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtcc-0003az-DQ; Wed, 21 Jun 2023 04:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcO-0003Np-6B
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcM-00050S-Lz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EOk9C1LephgeYrzHSr/Iao6dFyKhO8TARh1/pIHN4ps=; b=PPfkWZP8icUYAEp46hqieXviAa
 i9aWnJD5Q2oKhN1uoX750/PGxSg5KN4KgyqHYkrP9/YMeX9xV0GhOTViUjoRYTpGTT/RHT3frVUxG
 3ckWofU47fiM1VkDLmvHne7Wp4B2zXfEjBN3ICcYbL743hBV9L3W5HbaclKPYPqK5VGpHhNMJLNps
 hxumhnbpY43qbtuoiXDXqUFXY+ycBsMdV2DkXC4AkzLWcHe5Zb+BIt2UwPBubwZkGbqoz9DYJwJhe
 SGi7AzaR/IlHNVDBe9w9igMQwa5vFp8Jl17ptUTbAHFF8h9WHa5PoeVCDb7GLQApfp3HEHGZ0S4/U
 pPc1XMjmNQnas+2EpzZQtf1MtkoVnWIdMWSGEUDyk4krTJVUzSelTt/qQnmd6NYXGiCJFZK6Ssx9n
 F8m3/Bh80X7RD0GwuZeu3IU2tnPl4KtJSz884q53aNZGY+jWuYMNrsgUBa2s5HId0LtP+5cq7MFLf
 qI8jtmgntDkL4WcfgWMQU+NpILpqkcy5mrOxjpfaO7JpAxBEbcVg06skD5oJ0eVvjOZF4rbBGvy7T
 8a2RUL3sOd/nDFyAHqOkuxF1cY+KSqHsCxSyCsNV+TCACbEtRmgP8xSm5NscA6RBlz1LSwB2Jv73E
 vXjIeLTDoDWbIIDho7QikFj1jM4rG7iW/GJpYaoDw=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtc1-0001ZB-82; Wed, 21 Jun 2023 09:54:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:44 +0100
Message-Id: <20230621085353.113233-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 15/24] q800: move dp8393x device to Q800MachineState
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

Also change the instantiation of the dp8393x device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 988b4981b8..13806613fa 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -315,14 +315,16 @@ static void q800_machine_init(MachineState *machine)
     nd_table[0].macaddr.a[1] = 0x00;
     nd_table[0].macaddr.a[2] = 0x07;
 
-    dev = qdev_new("dp8393x");
+    object_initialize_child(OBJECT(machine), "dp8393x", &m->dp8393x,
+                            TYPE_DP8393X);
+    dev = DEVICE(&m->dp8393x);
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", true);
     object_property_set_link(OBJECT(dev), "dma_mr",
                              OBJECT(get_system_memory()), &error_abort);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SONIC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
     sysbus_connect_irq(sysbus, 0,
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 06c771635b..d11bc020ed 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -29,6 +29,7 @@
 #include "exec/memory.h"
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
+#include "hw/net/dp8393x.h"
 
 /*
  * The main Q800 machine
@@ -42,6 +43,7 @@ struct Q800MachineState {
     GLUEState glue;
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
+    dp8393xState dp8393x;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


