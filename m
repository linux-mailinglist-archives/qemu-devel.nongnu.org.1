Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDE7398C4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBK-0004vn-QP; Thu, 22 Jun 2023 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAi-00047W-BX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAe-0002tn-QZ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mbzdn-1pfMvO3VwV-00dT0z; Thu, 22
 Jun 2023 09:55:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/24] q800: move dp8393x device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:35 +0200
Message-Id: <20230622075544.210899-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2taqKoVcWGVKtvT0RmLBtESlQMUlPQJx7yknWlVIseRjheTOGDM
 XKeL1illQ/NBeJyy+Cf2OwAgeYYo2RoaZYZ/r9R4f99nM4XGL1xMa+0kuJRugh1eKs+GPxa
 ZWbbeep5HFrsZRgSbiXzjEU693SI84gZPzbXmdOUtkySf/ymzk0skGl8eaNVcijAN5OWGnt
 Vp4by1uKDRM0k/fXcL5Ww==
UI-OutboundReport: notjunk:1;M01:P0:mX2vNQ0bHxA=;ld6clkCgxOdlfJyol+E/GW7rXh0
 U+Q/bhUDlKn71fDbrXt0JZYLG8VcmDZpW3yu/qJY4YclZXNVcyln1EM/r9FcqMP/y2ScNPiub
 ZaAgF2u9EyPGjjQy2mBCvvjX69SBLp8Xy2R1N+tdPtjxqeValDWcp3avKbzOeS8zI8uRSRFTm
 ovjF5wlrtDxedj6FruVxelswekY2cWnt4sc3yktu3xmhLfs7FpDgJPXkguw9kzhUrqVgkiDO7
 LCjxCIaBzWY8S5SEsVhk6iz41loN+tjQHtlCgMzoREIXDpdKip9bIYjEfTWP2RfCYf8wPkwCw
 PpI098M3aLQSQCd9f/YHADaKnC6+WgLq88uyNGrbXawTVgZVFMMbLZW6JjhHh90SReW6qyYUw
 s0HdFT0Vx21BMEyWYa9oMm32jjbdph3j+MzrtAJbBOrBkW08+9unnfJ7AxQXt+gcPPek10h0r
 o8XsSlPSwpMo+xy+AS3I4LD+7hyE+qwac7X8EvNMjkKIC3znkBA2CwvZ9XxvYOxyQJV2PTzsE
 fRIlw0Ubq769s4E6CzLQNrwExvMmsG9vKuL1Y+B1B4Khl7HCfQwUh+lbTXAMXL4tqjDz0v/dI
 T4uI6Vb2ZL+ukcDx1mTLCvU8by1Zs9Q33MmjBisaweUYgAu7FVxUyVviuZPkn9TqTREmLJsfb
 Ic525eRkMs4rFv/RbGyNW6BN5KtwxAVNDXRiqzSskw==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
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

Also change the instantiation of the dp8393x device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 2 ++
 hw/m68k/q800.c         | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 06c771635b3f..d11bc020ed98 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 988b4981b830..13806613fa36 100644
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
-- 
2.40.1


