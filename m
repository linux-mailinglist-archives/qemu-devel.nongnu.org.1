Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B774B02A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiD-0004mX-Fm; Fri, 07 Jul 2023 07:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji6-0004UP-Jt; Fri, 07 Jul 2023 07:33:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji2-0006rM-Tj; Fri, 07 Jul 2023 07:33:14 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b73a2d622dso1096881a34.0; 
 Fri, 07 Jul 2023 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729589; x=1691321589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cx8JFPxOy2hy6ZQuOV0IfKUEylcD9zTc1xxTvy0yrw=;
 b=IeYvHb8z/3Eg9F++2eXL8vwPY/75XjFCn4M0xrTReQzMrVT6Tbv/RXA1T7Usn5v819
 cl8tVAUiUStXgySVyQnIhXjsDg4VR0gRAPSM+BkVYYD1Mc3kfYOU8l56hLzISDZ7Qs7+
 M+YmnFSaA4tA4fJZR8D6ib4x5vlZ2lO1/L5fi2E3bDZpWTwEmJYIO2jTQ9wWz2SEVgxB
 WrCHa7Mjgr3TwmoHADaJG5x2YtSYBk49VWFO8nhPns8RY/KasljM9YHw7qmH4+8y4XKs
 rcqyz6r/cTSjkU7rjL44s4Z2M/D0scSFog9wbA42qXXqO/1DPcw+HMdvQdblCo3e2/n6
 AJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729589; x=1691321589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cx8JFPxOy2hy6ZQuOV0IfKUEylcD9zTc1xxTvy0yrw=;
 b=XVedDEwkppgLfTmVqNOYTS9eKZUK0fR10ClLaQ8f0YQ9yWY04wuB/Ghg8D4ejmLvE4
 ONpbRNnlzr0nOU9lhZVD1fLe1MRnyShiCIZwGfIjGJyzpzBQjSN8RsjBW5aUQ41zSsUP
 wUmNs7s9AXVo0bLCKUNrQiFVFQi8FqH6AL60FLplkbloeLKoa+mC+EW0hnFrRM/w9oi0
 ZyJJnvE91ThkL8K92iZwW24AjBxMo5JUQ2WKk3xOvCNgmUu0YckDSMXQcPA4C25EROe2
 C5TyCSz+v+qjXcjUObNGYQzXwuXBFyKIZ0lhwsyFwCP1VGQzTrcLEBQI5o2mL70X/9CK
 Da+A==
X-Gm-Message-State: ABy/qLaWx844ty/OJuMqlqoG5D+Dhjqh30clb0g2j335dtuQuy7xSfi2
 TQdd9E29tr6Da/gKdG1+kVH4nOWlohE=
X-Google-Smtp-Source: APBJJlEEsWExbNriceaH0XgFhUymjuUJOaY1811dLs0wy6Do/hrR+Vqp/47xy5T5Qw8369JwBzaDGg==
X-Received: by 2002:a05:6830:381a:b0:6b8:6bd1:d0d3 with SMTP id
 bh26-20020a056830381a00b006b86bd1d0d3mr4214554otb.5.1688729589413; 
 Fri, 07 Jul 2023 04:33:09 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:09 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/60] ppc440: Remove ppc460ex_pcie_init legacy init function
Date: Fri,  7 Jul 2023 08:30:50 -0300
Message-ID: <20230707113108.7145-43-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

After previous changes we can now remove the legacy init function and
move the device creation to board code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <29aafeea9f1c871c739600a7b093c5456e8a1dc8.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440.h         |  1 -
 hw/ppc/ppc440_uc.c      | 21 ---------------------
 hw/ppc/sam460ex.c       | 17 ++++++++++++++++-
 include/hw/ppc/ppc4xx.h |  1 +
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index ae42bcf0c8..909373fb38 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -18,6 +18,5 @@ void ppc4xx_cpr_init(CPUPPCState *env);
 void ppc4xx_sdr_init(CPUPPCState *env);
 void ppc4xx_ahb_init(CPUPPCState *env);
 void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
-void ppc460ex_pcie_init(PowerPCCPU *cpu);
 
 #endif /* PPC440_H */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b74b2212fa..4181c843a8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -770,7 +770,6 @@ void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
  */
 #include "hw/pci/pcie_host.h"
 
-#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 
 struct PPC460EXPCIEState {
@@ -799,9 +798,6 @@ struct PPC460EXPCIEState {
     uint32_t cfg;
 };
 
-#define DCRN_PCIE0_BASE 0x100
-#define DCRN_PCIE1_BASE 0x120
-
 enum {
     PEGPL_CFGBAH = 0x0,
     PEGPL_CFGBAL,
@@ -1096,20 +1092,3 @@ static void ppc460ex_pcie_register(void)
 }
 
 type_init(ppc460ex_pcie_register)
-
-void ppc460ex_pcie_init(PowerPCCPU *cpu)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-    qdev_prop_set_int32(dev, "busnum", 0);
-    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
-    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
-    qdev_prop_set_int32(dev, "busnum", 1);
-    qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
-    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-}
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index aaa8d2f4a5..1bb23bb18b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -45,6 +45,9 @@
 /* dd bs=1 skip=$(($(stat -c '%s' updater/updater-460) - 0x80000)) \
      if=updater/updater-460 of=u-boot-sam460-20100605.bin */
 
+#define PCIE0_DCRN_BASE 0x100
+#define PCIE1_DCRN_BASE 0x120
+
 /* from Sam460 U-Boot include/configs/Sam460ex.h */
 #define FLASH_BASE             0xfff00000
 #define FLASH_BASE_H           0x4
@@ -421,8 +424,20 @@ static void sam460ex_init(MachineState *machine)
     usb_create_simple(usb_bus_find(-1), "usb-kbd");
     usb_create_simple(usb_bus_find(-1), "usb-mouse");
 
+    /* PCIe buses */
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 0);
+    qdev_prop_set_int32(dev, "dcrn-base", PCIE0_DCRN_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 1);
+    qdev_prop_set_int32(dev, "dcrn-base", PCIE1_DCRN_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     /* PCI bus */
-    ppc460ex_pcie_init(cpu);
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index f8c86e09ec..39ca602442 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 
 #define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
  * Generic DCR device
-- 
2.41.0


