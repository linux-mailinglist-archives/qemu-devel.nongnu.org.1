Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26DD7BC79B
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aN-0002r1-Ix; Sat, 07 Oct 2023 08:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aG-0002qV-Kq
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aF-0002ki-3o
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so568488766b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682341; x=1697287141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIor4PWPOYVprjey1BkD9C4ZcGEtUpk7Abdk1U+gDog=;
 b=YxcRpmip7Io3+Q0fUt35ecnUFUPXpccVz43cVTdOUiJZHmvFS68L/HmMJppPAj4ChT
 vz23LqSBDj61ZhhpIY6+KCBHE1DMh7gOiaE9od4PNMvtNw4YT/5BCQtWHuKsT1zrdJAq
 AGb2+oZrmaneC1FeRoKVZP279M8yZjp2UjUbEQyytYsRX/YDvqrI53uZgPtuFMO8MVxu
 sGqL5zJwJffVmCtPyr8b5NvAzS+5YRuQlPEcJka2nZUSs6A1ZYX+/BcKRrpXLEkIjBro
 sc3AA25HKQ/UKwlyyap5SWIOrJND90FjUTgFwHOUDsBKJ6WTnnYtsXsqMQN8CfkNoMVy
 np1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682341; x=1697287141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIor4PWPOYVprjey1BkD9C4ZcGEtUpk7Abdk1U+gDog=;
 b=kVq14uNrdmCQjlL7rHcQh5FkrQxD25vzp4UmhBZJ1WWFfZn/PCGhvO6WdznlwrDyv6
 B02qs1XPt5gUOLXZ/5w6+gO39isDU2vapcKdIphvEu4Mmk7ZsATxMLWNyNAnkbiZiJYR
 I+FZVgQHM9h1JH4eZzHyAx4riTDSv9fh2QggUvzx0AbwJPKV6L4zBaYRs3dgXYYFWDK1
 /8cmY+N8uii67YuhE5BHBIMagVG1YM7zEwjWO/+Knjm78xp85hENJOtdNe2+7y5YuE5Y
 LxEJAG/Iy3C6hrAylnHhM8dgQIRPWgeue/rJX3F/R8hRUOci14pVGu5DNU20kRDmLa5F
 2mjw==
X-Gm-Message-State: AOJu0YwboDpDpS8jicnychjUu0E0JsWlzCaA4eZZ1w5keSohlVILqxcG
 9CP5GR5rgu2J52kd7mikmENahAIrsvA=
X-Google-Smtp-Source: AGHT+IEPa7km/rxtSQRcnA8ANLdGqC7sbXNwcfuzGHzr5zhwqnRW947genFcLtX7roQ9hHNHT0j+Jw==
X-Received: by 2002:a17:906:20d8:b0:9ad:e669:ff30 with SMTP id
 c24-20020a17090620d800b009ade669ff30mr9714660ejc.68.1696682341050; 
 Sat, 07 Oct 2023 05:39:01 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 08/29] hw/i386/pc_q35: Wire ICH9 LPC function's interrupts
 before its realize()
Date: Sat,  7 Oct 2023 14:38:16 +0200
Message-ID: <20231007123843.127151-9-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the board assigns the ISA IRQs after the device's realize(), internal
devices such as the RTC can't be wired in ich9_lpc_realize() since the qemu_irqs
are still NULL. Fix that by assigning the ISA interrupts before realize().

This change is necessary for PIIX consolidation because PIIX4 wires the RTC
interrupts in its realize() method, so PIIX3 needs to do so as well. Since the
PC and Q35 boards share RTC code, and since PIIX3 needs the change, ICH9 needs
to be adapted as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_q35.c  | 14 +++++++-------
 hw/isa/lpc_ich9.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a7386f2ca2..597943ff1b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -242,11 +242,18 @@ static void pc_q35_init(MachineState *machine)
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
     pcms->bus = host_bus;
 
+    /* irq lines */
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
     qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
+    lpc_dev = DEVICE(lpc);
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
+    }
     pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
@@ -273,13 +280,6 @@ static void pc_q35_init(MachineState *machine)
                                    "true", true);
     }
 
-    /* irq lines */
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
-    lpc_dev = DEVICE(lpc);
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
-    }
     isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3f59980aa0..3fcefc5a8a 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -675,6 +675,9 @@ static void ich9_lpc_initfn(Object *obj)
 
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
+    qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
+                             IOAPIC_NUM_PINS);
+
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
                                   &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
@@ -691,7 +694,6 @@ static void ich9_lpc_initfn(Object *obj)
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(d);
-    DeviceState *dev = DEVICE(d);
     PCIBus *pci_bus = pci_get_bus(d);
     ISABus *isa_bus;
 
@@ -734,8 +736,6 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
                                         ICH9_RST_CNT_IOPORT, &lpc->rst_cnt_mem,
                                         1);
 
-    qdev_init_gpio_out_named(dev, lpc->gsi, ICH9_GPIO_GSI, IOAPIC_NUM_PINS);
-
     isa_bus_register_input_irqs(isa_bus, lpc->gsi);
 
     i8257_dma_init(isa_bus, 0);
-- 
2.42.0


