Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575CB9EE563
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 12:48:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfO-0007K6-BE; Thu, 12 Dec 2024 06:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfC-00075T-97
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfA-0007GR-5Q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bNvGcY25rKhWUjcuPJmEwWIwlwW6hH/adt+Cp83oGI0=; b=Kcc6OJoMK2Z4B38cOI4ZT1s8lR
 0qBke3+dkexpUXhAjj9HkCxRU6bm6ImuZaejH2EJrvGmQD8GGfBDGw+cK3/tI0tjRbNLj6HYaIBxv
 nZva6tsASXB3YaVqe8GkjENM/Pq8LFwYNRlhB01wM3JgE1uRXzQ3w/ECI14dcblubF+28WFu3qFlq
 srYo8UUp7CNWH+nYHFMf9+MVDDTqSlRFa4AKmWh5CthlBHKPO0AJ/BgNTaGTI7KYTK1091n/wx0WE
 crd9/ZY6VR4YTt59w19GW93v28F8RbRLSVFdrgvmp/+CJmwSlmA71l9nRn6hHMe/ShG3LKhjWbhXD
 Tbso3VA1rj2DcaT2tKtizEnBj7nMK59lm38XoIvc1Yeus67ypcez/lMzDJXWsrms4MrFBejlg+MX6
 Elop2sXJL6TtXbEr5cwBSAeEdQQJefxyNfVJw7vMXyvMoAEYgraRORUC9xwAC9i+luvwGCm3eU3jB
 M0yKXFuhodcPL43nna0bFDOYxvnZ2cDyXzoGiEH6OHgepOhh7kHixUrWpiV7Ezz/HaSFwG77DVc8x
 jGgrHTTNLfSxpvdlGx/7pPtlEbLEv5TPrVqi+9hzuMbj1yaBpEtcY4bwVqdoOZpkDallJv9DyXSyh
 1nEoVU8RFxAjTu4TnGI2zb8CNeS43p6ZGHX2kvTZ8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheQ-00070a-5Z; Thu, 12 Dec 2024 11:46:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:00 +0000
Message-Id: <20241212114620.549285-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/34] next-cube: add empty slots for unknown accesses to
 next.scr memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The next.scr memory is now effectively unused, however there are 3 separate region
accesses still logged that occur when booting a NeXTStep disk image. Use the
empty_slot device to capture and ignore memory accesses to these 3 memory regions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/Kconfig     | 1 +
 hw/m68k/next-cube.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 0092cda4e9..aff769b30f 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -18,6 +18,7 @@ config NEXTCUBE
     depends on M68K
     select FRAMEBUFFER
     select ESCC
+    select EMPTY_SLOT
 
 config Q800
     bool
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 76ecf86ed0..95d01030cd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -22,6 +22,7 @@
 #include "qom/object.h"
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
+#include "hw/misc/empty_slot.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -1239,6 +1240,13 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* unknown: Brightness control register? */
+    empty_slot_init("next.unknown", 0x02110000, 0x10);
+    /* unknown: Magneto-Optical drive controller? */
+    empty_slot_init("next.unknown", 0x02112000, 0x10);
+    /* unknown: Serial clock configuration register? */
+    empty_slot_init("next.unknown", 0x02118004, 0x10);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.39.5


