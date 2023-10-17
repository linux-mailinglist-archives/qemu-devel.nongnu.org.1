Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B285C7CC52E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskTT-0008AS-Lr; Tue, 17 Oct 2023 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskTR-00086h-8b
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:51:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskTP-00069L-N8
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:51:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9bda758748eso638228866b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697550662; x=1698155462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x6BbhRUo6m3TQ2lMD7BvRrsDFT46E9vfn3DPv2BsTQc=;
 b=YggtuLYvaRgPLGFjzUHurwi01LXnnfP2P9xbEQJhnuUajkv3gokQ6NVKLLwcO5tjgp
 YjdR0IfY7nM8VEmEEj+OzbX3gvNJUToJ7bESIVFHgtNa7E05y6UImB/MIKvFMEO4nAiw
 eZPrLiIfh33RbbdBV5LFjHGqrnM6KKn8dD4625xsGMWMlKSLNeHV42Ufrnt9ewTpo3Mw
 m759L9uyx7KlOHOth0KdD9+fjj+inij1VzO4hT5Pj+RW8jR79z6FIwfGBNZ8KpEdaqg5
 pby6tt4Fz6ftJ6bIAh6H++dCKvq2pSgvlNSMnx6pL4TSF7cs/ymwHUH0UxuE9D+79zC1
 P5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550662; x=1698155462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6BbhRUo6m3TQ2lMD7BvRrsDFT46E9vfn3DPv2BsTQc=;
 b=p7+Gl7ZqxRy5SSR8eIDluI8RzUqY4IKxIO212bf9fDbvcvlZWOdXTUscA9SnsGszZd
 DNaEqOWFyT3V5Xsz3Yfpmi3REjvfRBcteQ1CGKwSRTij+J5DbBjNbaGcU50etCGiyEwz
 E7gD+auN7PC/n3xyD1FrQztCSUs9uFcO3BeIrfxWR8rbNfm455LBHPohCcG3aI8VXK1S
 9mLsWF5jZbkbDdb5/HJbs+SnUU6UcSfIU51ZaIZK/d/A0jO3Q9ygLvp4sMRg3n9ysj4R
 q9IxyFyl5g1SbkGREG2IpF3prhpJ/ji34zDl2tyPan6BDS+28WoXjpnaM65q1hPmkrcl
 BSOA==
X-Gm-Message-State: AOJu0Yw2h/S3p3cpXoOqYGWFv96lWXFhb5dk99p3NkmDw7S86RLnQujM
 ALul4DR2FOYpD8szBrlNzQ2cbtnUziIKBn5t5pw4JA==
X-Google-Smtp-Source: AGHT+IFda4n7CrozwLy1EoIGp8o0B0aK1xJAVTVV5hTUgtGB1g8GE7cyds0r2jSRD+yM+qlSS9G0uA==
X-Received: by 2002:a17:907:3f1c:b0:9b8:8bcf:8732 with SMTP id
 hq28-20020a1709073f1c00b009b88bcf8732mr1912838ejc.43.1697550661887; 
 Tue, 17 Oct 2023 06:51:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 jl6-20020a17090775c600b009b29553b648sm1271255ejc.206.2023.10.17.06.50.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 06:51:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] hw/audio/pcspk: Inline pcspk_init()
Date: Tue, 17 Oct 2023 15:50:58 +0200
Message-ID: <20231017135058.44247-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/pcspk.h | 10 ----------
 hw/i386/pc.c             |  3 ++-
 hw/isa/i82378.c          |  5 ++++-
 hw/mips/jazz.c           |  5 ++++-
 4 files changed, 10 insertions(+), 13 deletions(-)

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
index bb3854d1d0..3d0b53a583 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1283,7 +1283,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(pcms->pcspk, isa_bus, pit);
+        object_property_set_link(OBJECT(pcms->pcspk), "pit", OBJECT(pit), NULL);
+        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
 
     /* Super I/O */
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 63e0857208..9474bf994c 100644
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
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), NULL);
+    isa_realize_and_unref(pcspk, isabus, &error_fatal);
 
     /* 2 82C37 (dma) */
     isa_create_simple(isabus, "i82374");
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index c32d2b0b0a..aac851747c 100644
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
+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), NULL);
+    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
 
     /* Video card */
     switch (jazz_model) {
-- 
2.41.0


