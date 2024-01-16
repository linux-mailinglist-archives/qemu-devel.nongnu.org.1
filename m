Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F482F130
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:15:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7M-0006gv-DY; Tue, 16 Jan 2024 10:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7H-0006e5-B8
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:39 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7D-0005qG-J0
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso7807639f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417954; x=1706022754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MS9BJCM/6ZfBrVXFAU4JmkVVTzP3UXti1ik4wQ5ClH8=;
 b=uyxlm/3r1UKXCluDdhE+Vuet2O0334nE2Y6DeMkn4JlawXyHjMPldUsrOUPYg11z+1
 h1xipuuAgHCRLrlacN8hpNV99g59tTVujmBrsSvlAFCQ4a6tB8Fi0pRbVV8+rg49rMyI
 HStgDvanNRiHxn6vKDdXKpocYcEjpH4ACgK7haE3TT5gFcVEIoe8Wk8jSMeD1oYdqpp5
 2ANTtQlHU7Gj8BTDMn/fo6c0MnL45qtl0wpJIy//zu1xllnfqjzqqZdO7ulmCb4X/BZ7
 2H85cGTkn0nedlh46pA9zH0VJAtwCGN8OVSu6SVFsIC+K2YMcU2HVfNR/2aV1hfwmgAM
 6NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417954; x=1706022754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MS9BJCM/6ZfBrVXFAU4JmkVVTzP3UXti1ik4wQ5ClH8=;
 b=jR8fewtmbpYZ7atos998leYqEzqD3psQSxmpGHT2V6iIMIjQUEPiY+fc7mgCKL/p2T
 AOVoQlhKj6Oqs6FN5cg0+VNnNBUsqXv3TugVGB8Nf0n3s51DLObLdxp7B0BuoJBDgCTf
 y0BkOYkEFpSEw3f1wQfk0lQqUztlfCPLyQVud1Ze/fVHQrtpbE20axjBm8oF0czEa+n7
 dDu0fhi7Dw43XWKBMMlNGB1pUa+szcnCFTRWQy/ScvJynspWvwjfOpmZvZQJTCi+03sW
 QA2b681jwsjgzcXz3lUUqGVAjwrBS4fPFJ72fFqGJyeCwabTj50gZ5eHmOn3aE7088ef
 92+w==
X-Gm-Message-State: AOJu0YyVXrqbkcPJ08tlO/CcqkA8M8POqYvsMkiTYjDB4xcGZtUTFYjL
 wLhjzV1rVCu8Mivw8eayWjf8k99dGNTckE9j4Zw6QT9aXPU=
X-Google-Smtp-Source: AGHT+IFRSyr7UrkoD5KsaXnad15XNtVW12a13150ebQS5S0JqL5HmW47sg3k7PVw3aejG5Ryp+rZ5w==
X-Received: by 2002:a5d:6549:0:b0:337:bfbd:80c5 with SMTP id
 z9-20020a5d6549000000b00337bfbd80c5mr129981wrv.34.1705417953889; 
 Tue, 16 Jan 2024 07:12:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] hw/arm: Add PCI mailbox module to Nuvoton SoC
Date: Tue, 16 Jan 2024 15:12:18 +0000
Message-Id: <20240116151228.2430754-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch wires the PCI mailbox module to Nuvoton SoC.

Change-Id: I14c42c628258804030f0583889882842bde0d972
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Message-id: 20240110234232.4116804-3-nabihestefan@google.com
[PMM: moved some changes incorrectly in previous patch into this one]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst |  2 ++
 include/hw/arm/npcm7xx.h    |  2 ++
 hw/arm/npcm7xx.c            | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 0424cae4b01..e6110995455 100644
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
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 72c77220964..cec3792a2e8 100644
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
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d0472..c9e87162cbe 100644
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
-- 
2.34.1


