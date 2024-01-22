Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC2836DC2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:38:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyEm-0000CO-HD; Mon, 22 Jan 2024 12:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yqeuZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rRyEb-00006n-Kh
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:22 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yqeuZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rRyEY-0003xC-4U
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:20 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5e617562a65so58037467b3.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705945034; x=1706549834; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KoiWmLUy9Z2jBMpt3vIL/wDyZVSYZMg7YR9ZIbTZHJE=;
 b=xg6UibqV7kLhCIBMmU3WwXkKpBbW5ozaVAOBBn3GqYfaPzOg3WZPAzgS5JmpfLHC7w
 YtzWgYOkgm9V2J4ASQivgcgg1AGaDteAqMOp1uluZ5i+5uh/ftv/jca+eL3haUfrGFvJ
 34/FBKBnYht80QLEZEbED4ZSBm98Fn0dZ24hNRDeUf5g17pBPFPlob/G8XDHNsxZ37y4
 hZ6LKp9BdICJ4fxf6Gg/PY4bUwrYbrtAZg+Fxtusdk9174Z/aS74yQGO18sweZS1bq2Q
 LO3hce/qxL/1VnD2hVhQtiEUukjhq2Tvc7ILTyklOoNF5DyGZCSUXnPHGvPex0KXG6IK
 jYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945034; x=1706549834;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoiWmLUy9Z2jBMpt3vIL/wDyZVSYZMg7YR9ZIbTZHJE=;
 b=mNiWbOJeryQ5qDuL0qZD8SZ4bQL2uWmPOJtoA6gHdcWKMkJM69Vg4HagWzI5u12bem
 7ASOFEHYYM3n2hjip5mtSpcF/jQHbUSBdBa6u94GZ+XKCa2hc3DH2PekyA5lNDoOhbUK
 HoCOxzeQ4acKnCNGt89rYfS9kGAYoqbo6HJ4L8LAEW0MSxFAUq+Yqg8U3PdLZeA/KiJX
 xLueNKjrGjx3iylIZWsunwCiX+nLCAY/0ytEe8+w2GEOHwfpBcc8+TX3Aq+4mF2+2ia2
 uvsn4r0iTFnieopGEGN1O6iD8z4kcLFp8UiVHIUNsy1RBqdKQfHYbD0RYlXSeXlhFpoN
 WUMA==
X-Gm-Message-State: AOJu0YyldCg4wQTPoOpF7xkSZkn2MY9nZ//jpsmLKd06/URCDPhPX9I8
 /ZGtucr9e4egWekDEGbzvmbKLodZcEVTmw9mTdoPMN/U0Qga6N4h3X55/usF9JtIR44eJZyA0cn
 ccy10unix7m82zqa4up7w2QxO8Q==
X-Google-Smtp-Source: AGHT+IFr29LDFDtOTMusDfZ+tG4QLga9yifBx6sasVysay2amrqrmgPXVM0I1J4n/YswhVzCOJwjmq2YfE/+m19Me2E=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:2705:b0:dc2:65e7:451b with
 SMTP id dz5-20020a056902270500b00dc265e7451bmr2213263ybb.12.1705945034435;
 Mon, 22 Jan 2024 09:37:14 -0800 (PST)
Date: Mon, 22 Jan 2024 17:36:59 +0000
In-Reply-To: <20240122173706.4019545-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240122173706.4019545-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122173706.4019545-3-nabihestefan@google.com>
Subject: [PATCH v14 2/9] hw/arm: Add PCI mailbox module to Nuvoton SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3yqeuZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
 include/hw/arm/npcm7xx.h    |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

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


