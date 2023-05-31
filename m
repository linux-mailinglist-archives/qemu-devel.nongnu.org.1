Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52317180A8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LMT-00005A-Vr; Wed, 31 May 2023 08:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMF-0008K2-7c
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LMD-00074y-P3
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I7+MVlTkJXakDklkM2S3YmcF1psrLaKEFGlADiKA7OE=; b=X0Spm4IM64c1KRpDtpDDlrRFK9
 kwBJxyxb15xeAnD5XlmJwpHx0ogZjnqmrYMc5rwY9EkVHm2MAEEK6AVYRXJRSr0p9hIx612JS+/bE
 9l596qRcdoi8rQ9OrM68QiKV7tqabdpU3QcAYwgZtRcru2lk3GGMGacUILUdNo9/PL5vg/ljlnK9S
 B049YJX8fYVaMH+E3c4PKFZ0NCkQX61okyAaPk6byQC6Ig94I66qjkeNwBthq1++cyvyrRqeu6ZKZ
 lsiRPMBlEiGqbnw/6mNMzF7SqQBLkIBdiUE1oB4cMScNArCbWb6PQWMamH9vb7GotJm3vxbdfz4FO
 JGhhSAGNYNayvbQh822ukjrBWj2QlvkdZpnIJWeuZElOZn+sWdLoRar1Stkt1Eyfyml+43Il3qeKN
 7p+zmvadPrPSczgaRJrczOpO3g71WwBrnjfOT85NOc97PX5Q9XdOGjKvUG27i+Ze3zc9CTfXPRoH2
 BuS6P5qGyVfyfQXqrMqQdAcLstnKUU5JVb7P2KvJ67F6tEx9T8OnEePmyMal5Snc1gFZsGkRkxURr
 tsP8GaRx5FTHTcpJxbAaMXm84TDoBBU5RqFq073ki5VUi5kwo70hhvNrZu9FmmE4DJpsMj3r/a3P6
 psMzE3nDyQkqUIckv5Eu7Qk2vZS173CYiWI/LZbJ4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLw-0008vd-38; Wed, 31 May 2023 13:55:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 13:53:51 +0100
Message-Id: <20230531125400.288917-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/23] q800: move dp8393x device to Q800MachineState
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
---
 hw/m68k/q800.c         | 6 ++++--
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 53d6308a7a..e25f6f1373 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -316,14 +316,16 @@ static void q800_machine_init(MachineState *machine)
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
index ba3aa45513..82964cfea1 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -25,6 +25,7 @@
 
 #include "hw/m68k/q800-glue.h"
 #include "hw/misc/mac_via.h"
+#include "hw/net/dp8393x.h"
 
 /*
  * The main Q800 machine
@@ -38,6 +39,7 @@ struct Q800MachineState {
     GLUEState glue;
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
+    dp8393xState dp8393x;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


