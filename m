Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D160D7CF153
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNWv-0001n6-Qq; Thu, 19 Oct 2023 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNWt-0001m1-Hz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:33:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNWr-00016Y-Ss
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:33:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso2470445e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697700792; x=1698305592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gim8yQHzdFdkBLZz5G1JCT1nr/eNaSSdRTGu6q5RTFM=;
 b=VyTb0HUWBfslGKPuAchbidjogx1z6a8oQRD26fAtEDFRrVsYX43VhfV7LkF60Lg/eM
 FRPYkK1hJPQJupKN6fbHCmK6IBFPRsb39LHY+Dc0UNx4VMcftkWNNUirvSn77JYfync+
 OZ7S0H7MvkEJt2PZ2kwT5p/Bkqp7RiQLZLaflHFMo3uhf/+Rf/58CToUGsepovuOk3ei
 yYRbmqAxh/6jnf6kDpBqeB6i/cjSZWc13P8r0VCySu7AHpCLPRnoYrHzeYVKmeHe8cFB
 PQmyn7UL6QM6+O7aV6FCWlFqUmBxqGQBhHKu9/ph40reNWPZY9IjciLLjXyO+b5C/NtQ
 D3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697700792; x=1698305592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gim8yQHzdFdkBLZz5G1JCT1nr/eNaSSdRTGu6q5RTFM=;
 b=UZwc4ZcpXVTxL3j+7nYGkp88M68MAy0ZOt6Uggcnfbnu45m08Aym9lLVU/TdCqC0ib
 Jc0muT6LRVcFD8SOdvE89zjzmx5SsXTFVk7R2DNCZbJ+pdmLlS6RDBVhcPIO0oyxhYni
 ebBgNCmbUDStefovoSokl37h8RetqA08B+6+FxSyRZ6TwnoGEmoimIgmbHQ9dJB2kMhV
 1euUNhxMbCAIQ0tjzTTcnwH8Kleoslytom4h4zHS40Zzh5uLgiaT5cTBTpUMbqPZO0iC
 aIZ7rTjBQvq1Uva+cAYmDJtBv/S2nAOuClAVmjkEWVFi/nbwN7ATX1Kw5w0iYLo1Pbq1
 MVRQ==
X-Gm-Message-State: AOJu0YxIyphYxGSHjn49NGZcK9us7H7g0qWD2qy015VI2rVJW1LeKPwH
 CPrHc9VYbZ2ygw0UGsk1gWl2+OHBkl98KNu4Q6V2/Q==
X-Google-Smtp-Source: AGHT+IF5bgyzyTJuCkLlllYdbrSry7X7ERJS2TKfzWVf8yUalG3knPURWujWb25WW3mBQUu9VWZPSQ==
X-Received: by 2002:a05:600c:602a:b0:407:4126:f71c with SMTP id
 az42-20020a05600c602a00b004074126f71cmr980635wmb.6.1697700791983; 
 Thu, 19 Oct 2023 00:33:11 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm3687599wmo.16.2023.10.19.00.33.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:33:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2] hw/audio/pcspk: Inline pcspk_init()
Date: Thu, 19 Oct 2023 09:33:07 +0200
Message-ID: <20231019073307.99608-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

pcspk_init() is a legacy init function, inline and remove it.

Since the device is realized using &error_fatal, use the same
error for setting the "pit" link.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/pcspk.h | 10 ----------
 hw/i386/pc.c             |  4 +++-
 hw/isa/i82378.c          |  5 ++++-
 hw/mips/jazz.c           |  5 ++++-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 9506179587..6be75a6b86 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -25,16 +25,6 @@
 #ifndef HW_PCSPK_H
 #define HW_PCSPK_H
 
-#include "hw/isa/isa.h"
-#include "hw/qdev-properties.h"
-#include "qapi/error.h"
-
 #define TYPE_PC_SPEAKER "isa-pcspk"
 
-static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
-{
-    object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-}
-
 #endif /* HW_PCSPK_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb3854d1d0..f7ee638bec 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1283,7 +1283,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(pcms->pcspk, isa_bus, pit);
+        object_property_set_link(OBJECT(pcms->pcspk), "pit",
+                                 OBJECT(pit), &error_fatal);
+        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
 
     /* Super I/O */
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 63e0857208..79ffbb52a0 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     uint8_t *pci_conf;
     ISABus *isabus;
     ISADevice *pit;
+    ISADevice *pcspk;
 
     pci_conf = pci->config;
     pci_set_word(pci_conf + PCI_COMMAND,
@@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     pit = i8254_pit_init(isabus, 0x40, 0, NULL);
 
     /* speaker */
-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
+    pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
+    isa_realize_and_unref(pcspk, isabus, &error_fatal);
 
     /* 2 82C37 (dma) */
     isa_create_simple(isabus, "i82374");
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c32d2b0b0a..cdc37126c2 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -177,6 +177,7 @@ static void mips_jazz_init(MachineState *machine,
     SysBusDevice *sysbus;
     ISABus *isa_bus;
     ISADevice *pit;
+    ISADevice *pcspk;
     DriveInfo *fds[MAX_FD];
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
@@ -279,7 +280,9 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
+    pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
+    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
 
     /* Video card */
     switch (jazz_model) {
-- 
2.41.0


