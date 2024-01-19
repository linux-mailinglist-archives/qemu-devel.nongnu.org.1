Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281C832FD7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 21:35:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQvYD-0001OV-TJ; Fri, 19 Jan 2024 15:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3h9yqZQwKCiAJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1rQvYB-0001FI-DJ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:33:15 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3h9yqZQwKCiAJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com>)
 id 1rQvY9-0003lj-1y
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 15:33:15 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc2470bc0bdso1734770276.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705696391; x=1706301191; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JKCynwXHyuTm7d/4womyVuSHa++vDMfEnlpPnpd3PDE=;
 b=ES657C3kjJ64P3lFJhTHQc8aXyXFWd4z0FbIT7MRx4aBVAJ4qSu+sh3Qn3wXgWXKrR
 KMaD4GFx3VsdPkTd4XSwV9uANhL40bEC5dkX+tSEonwSLvxyJx3BheFIcE9T1tbX7R2l
 6oLDjUfexqoLsqifbh7AV+ox+YQi+LJVPyCgCDsy96Q0KTx2l+Ftds1uj378+KtGHJUq
 zKvbvYaCC4jPFPUw+W12aZ6vnBmVZUdlF1TVHhRkkJlBYZRbjvHBRXuCmGftK+dcRg3R
 dRR9QVWZxc3Jw/iKJp6aR5znsPHN5newt4/M/AT6KPOOrAOKvr2aj6Ip2dEJ+JFhKa6q
 XmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705696391; x=1706301191;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JKCynwXHyuTm7d/4womyVuSHa++vDMfEnlpPnpd3PDE=;
 b=c2PE1j/E4KCJNB9CK5L+lxBoDgrxrT8mmx/0lRwerl8UEPO+iODUAVTBzXkcKBvToo
 1MtKz/V0/SFgzd2w00A6NTaGuCmmpFK7Afjy38Tp9/3HH51XotIq1/9PUPiVgq3d4F9Y
 KVznPRp4RpPrITwbSLfUOTwarrMh+VeDT5fn0lYvO1Vzy7FWtVSAUQAoos75p3ucVZXy
 Dqtece9dZaE/XJPlmTuI1ax5lGMc5M6aMFJlJUO+Vojw1Niu8k5nlZRaj2jD0le43L09
 2UwTZvRqRq8t/D6KW5fvkvchTYPTqAMAL4ORgSMWEN0XICLSVVcJgblzLNthjpW5FTva
 QMLA==
X-Gm-Message-State: AOJu0YxoH8WZ2CEADV9oPkB5Df/PaioT+4k2ngb5LfCslzzPnL9Q/1D4
 9CgclLsl+kPw51ShhuOp6SlOF/qM37mJ3OkR0KPSJxmJxCHBCkmkgMGWX5FAs1osnDp983nEzRE
 nZ9c0LfA2scASzOu4X0imqYZneQ==
X-Google-Smtp-Source: AGHT+IHN5o1fHAkGorYMUg4LHdk/w4W5v7GvK47kuq7WIOXo55S6pqQuiycYGlOXiQBDcuBsEaBZDy1/yLBkKlgRHpI=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1808:b0:dc2:3426:c9ee with
 SMTP id cf8-20020a056902180800b00dc23426c9eemr45198ybb.11.1705696391636; Fri,
 19 Jan 2024 12:33:11 -0800 (PST)
Date: Fri, 19 Jan 2024 20:32:56 +0000
In-Reply-To: <20240119203303.2230984-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240119203303.2230984-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240119203303.2230984-3-nabihestefan@google.com>
Subject: [PATCH v13 2/9] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3h9yqZQwKCiAJ67EDAOPAB6JCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

This patch wires the PCI mailbox module to Nuvoton SoC.

Change-Id: I14c42c628258804030f0583889882842bde0d972
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 docs/system/arm/nuvoton.rst |  2 ++
 hw/arm/npcm7xx.c            | 17 ++++++++++++++++-
 hw/misc/npcm7xx_pci_mbox.c  | 10 ++++++++--
 include/hw/arm/npcm7xx.h    |  2 ++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b0..e611099545 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -50,6 +50,8 @@ Supported devices
  * Ethernet controller (EMC)
  * Tachometer
  * Peripheral SPI controller (PSPI)
+ * BIOS POST code FIFO
+ * PCI Mailbox
 
 Missing devices
 ---------------
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d047..c9e87162cb 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -53,6 +53,9 @@
 /* ADC Module */
 #define NPCM7XX_ADC_BA          (0xf000c000)
 
+/* PCI Mailbox Module */
+#define NPCM7XX_PCI_MBOX_BA     (0xf0848000)
+
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
 #define NPCM7XX_RAM3_SZ         (4 * KiB)
@@ -83,6 +86,9 @@ enum NPCM7xxInterrupt {
     NPCM7XX_UART1_IRQ,
     NPCM7XX_UART2_IRQ,
     NPCM7XX_UART3_IRQ,
+    NPCM7XX_PCI_MBOX_IRQ        = 8,
+    NPCM7XX_KCS_HIB_IRQ         = 9,
+    NPCM7XX_GMAC1_IRQ           = 14,
     NPCM7XX_EMC1RX_IRQ          = 15,
     NPCM7XX_EMC1TX_IRQ,
     NPCM7XX_MMC_IRQ             = 26,
@@ -456,6 +462,8 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "pspi[*]", &s->pspi[i], TYPE_NPCM_PSPI);
     }
 
+    object_initialize_child(obj, "pci-mbox", &s->pci_mbox,
+                            TYPE_NPCM7XX_PCI_MBOX);
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
 }
 
@@ -706,6 +714,14 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* PCI Mailbox. Cannot fail */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pci_mbox), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 0, NPCM7XX_PCI_MBOX_BA);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox), 1,
+        NPCM7XX_PCI_MBOX_BA + NPCM7XX_PCI_MBOX_RAM_SIZE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pci_mbox), 0,
+                       npcm7xx_irq(s, NPCM7XX_PCI_MBOX_IRQ));
+
     /* RAM2 (SRAM) */
     memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
                            NPCM7XX_RAM2_SZ, &error_abort);
@@ -765,7 +781,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
     create_unimplemented_device("npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sd",           0xf0840000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
     create_unimplemented_device("npcm7xx.aes",          0xf0858000,   4 * KiB);
     create_unimplemented_device("npcm7xx.des",          0xf0859000,   4 * KiB);
     create_unimplemented_device("npcm7xx.sha",          0xf085a000,   4 * KiB);
diff --git a/hw/misc/npcm7xx_pci_mbox.c b/hw/misc/npcm7xx_pci_mbox.c
index dc56e2bd5a..0ac8391479 100644
--- a/hw/misc/npcm7xx_pci_mbox.c
+++ b/hw/misc/npcm7xx_pci_mbox.c
@@ -76,22 +76,28 @@ static void npcm7xx_pci_mbox_send_response(NPCM7xxPCIMBoxState *s, uint8_t code)
 
 static void npcm7xx_pci_mbox_handle_read(NPCM7xxPCIMBoxState *s)
 {
+    uint8_t offset_bytes[4];
     MemTxResult r = memory_region_dispatch_read(
         &s->ram, s->offset, &s->data, MO_LE | size_memop(s->size),
         MEMTXATTRS_UNSPECIFIED);
 
-    npcm7xx_pci_mbox_send_response(s, (uint8_t)r);
+    stl_le_p(offset_bytes, r);
+    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);
 }
 
 static void npcm7xx_pci_mbox_handle_write(NPCM7xxPCIMBoxState *s)
 {
+    uint8_t offset_bytes[4];
     MemTxResult r = memory_region_dispatch_write(
         &s->ram, s->offset, s->data, MO_LE | size_memop(s->size),
         MEMTXATTRS_UNSPECIFIED);
 
-    npcm7xx_pci_mbox_send_response(s, (uint8_t)r);
+    stl_le_p(offset_bytes, r);
+    npcm7xx_pci_mbox_send_response(s, offset_bytes[0]);
 }
 
+// The device is using a Little Endian Protocol.
+// If running into errors, please check what protocol is being expected.
 static void npcm7xx_pci_mbox_receive_char(NPCM7xxPCIMBoxState *s, uint8_t byte)
 {
     switch (s->state) {
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 72c7722096..cec3792a2e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -26,6 +26,7 @@
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
+#include "hw/misc/npcm7xx_pci_mbox.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
 #include "hw/net/npcm7xx_emc.h"
@@ -104,6 +105,7 @@ struct NPCM7xxState {
     OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
     NPCM7xxEMCState     emc[2];
+    NPCM7xxPCIMBoxState pci_mbox;
     NPCM7xxSDHCIState   mmc;
     NPCMPSPIState       pspi[2];
 };
-- 
2.43.0.429.g432eaa2c6b-goog


