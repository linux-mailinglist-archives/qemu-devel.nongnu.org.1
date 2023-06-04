Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A8721754
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5naz-0005wh-SR; Sun, 04 Jun 2023 09:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naJ-0005Cl-0l
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naH-0003N6-A6
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8Ws36/ibzHqa/LjGs7DfgC8ToUC3HAMQijXnOBRy44=; b=v0WjkVWML8vIyp1YUAKwnjCpnP
 dhgzv8o7vQ0cQmT+YYV0UBoFogjZ+CwZ45jEkvCbD29NVD/ycULc8EBPLKfw0PGwD7jmmWZ/zmzg5
 mhyattYAI2iW3s7Q6nukTkAA0fMB/lSamJ8qDv0aX9N2MDeWrybUx9081eSK4D5+y1hrJcscNZuVE
 GEdQzGjbU4f8oR0BPvww28Fu9MDl3AYgNJgCMjV5TAH3MzeLPLbx5ErTSxcroKWkw77lLkmCXmDwo
 LNFkmvp//0RwDMc0fXNiu5mes+ISDma5zZfsq1JXspSD3X0ozemenvNqXNvcdTt5TDpaSDk6MQ3mJ
 MzcwA4xlLg4aohCdW+D2nQV5NimZ1VLGhhN31N6OObE6R+BadY7CICW1H+DEBdSd2oulgfUuTmdqC
 1ipmVGFk3BisE3XKGj0crQRHlsYKgyatwPTAL4/3DyzopY9kxnkgV+MsncTcBN2iHtn1Ze6BQ7AJR
 7Z2RMteqhvD5zDjJixvH6myuxxQ2wSPIFp3Nnp5aRtsiQGzo/euDRDundnAqACOtRiyZfjdIM5V89
 oLnrgzwhNc2Xsof7G6MGZhfrp88/z4AeTh3QGyCzjRbCdw8RcylS+VLhdJZ7daVGPV5voqB7yl8eE
 Ze1XDyhodZxfwMNl8iz6AKlAaVYs1FM84meSM9hm4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5na5-0005pb-DF; Sun, 04 Jun 2023 14:15:41 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:41 +0100
Message-Id: <20230604131450.428797-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 14/23] q800: move dp8393x device to Q800MachineState
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
index c2e937a929..05194a06a0 100644
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


