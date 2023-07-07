Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDF74B022
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiH-0005QH-EQ; Fri, 07 Jul 2023 07:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiF-0005FA-Kz; Fri, 07 Jul 2023 07:33:23 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiC-0006tn-LU; Fri, 07 Jul 2023 07:33:23 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b5d5e6b086so1085724a34.1; 
 Fri, 07 Jul 2023 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729596; x=1691321596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xYK103zto2X3kxTu0f0Dnw6kJikTfBoxx+M1uk2xOY=;
 b=QqytbLtCK4+ohCFQDOnOwBFEGaTWmFAXx8gE0oAiEWP/3XQ5DdZ92h4qfXBmiluA7x
 VBcswW3S5ldZMs+zLC0dyogjmZtiORVWBcWkUN7FJx/6N2rEWQuO6Hz3JoAdWnzu8Z85
 5vJxeokjvzxQGluZ3P1hBclVWDEyhqRMdrExUc/+2auc5Pq/xGCfcD2k2lNy/fB5WVV8
 QB2WTQuAw4FMPenUGPwBnuacmOQLBYh5sJULqcXrIMzhOCh5edXn8AMGPEIxC0KpjO/A
 DsS0HOFWVdr/zt4jD31ylCWLXZYn9DYA/BmArYDa9axnTVxzvQNqfPBLWs+gGG1fThzf
 tiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729596; x=1691321596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xYK103zto2X3kxTu0f0Dnw6kJikTfBoxx+M1uk2xOY=;
 b=lbOeecINNrEsTTDsxIA2aPCq7iuxqEJp1aSqWQmovTfLnp+lzKBn2dqahQZh0dfsUR
 FYJOOmI9evd9NkJLjq+B2co9ti/TB601NCXdQ4KSaxCYCM6mAEma3jUiatnvpyMdij6e
 mH9ORn9Kt7ZgANVouGejWJeXgge/Xg3FTP3pbAgv0qeOfKhWAbY0+jd2ylqOH6T9ppbD
 SHutwEOdXoIqFTaL9p4yUpHZjC4WI7uG1tTfn9UKR2Hsl6uOJbsH93RppmNboOkblw0+
 1LWsDxCz18IurSXv8JxFFcc1Gu4AXB0LxQeTwiItOgFrIlaKY0so4RcDnsDQqSR2CxE6
 9t7Q==
X-Gm-Message-State: ABy/qLbZHL054htNpwLaW5EJf8t5GAaqXlU7VKA4t7/twA86jYuO9M9E
 +mdaVoznZ0AiARhBtWB+VQoOrXydLwg=
X-Google-Smtp-Source: APBJJlEdGf2CrnTPzPtIiq08/2A61d9ilavfmHNTTVVtE5rFp2mjf0NfyGby2GwBml3ilTnR+Q1/LQ==
X-Received: by 2002:a05:6830:370f:b0:6b8:6827:c24f with SMTP id
 bl15-20020a056830370f00b006b86827c24fmr4695018otb.1.1688729596258; 
 Fri, 07 Jul 2023 04:33:16 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:16 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/60] ppc440_pcix: Stop using system io region for PCI bus
Date: Fri,  7 Jul 2023 08:30:53 -0300
Message-ID: <20230707113108.7145-46-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x330.google.com
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

Reduce the iomem region to 64K and use it for the PCI io space and map
it directly from the board without an intermediate alias that is not
really needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <f4ad9af42197a92dd1d0b56c21316dbdad240ee4.1688641673.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_pcix.c | 9 ++++++---
 hw/ppc/sam460ex.c    | 6 +-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 899558b055..54286cfef4 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/units.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
@@ -491,10 +492,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     s = PPC440_PCIX_HOST_BRIDGE(dev);
 
     sysbus_init_irq(sbd, &s->irq);
-    memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
+    memory_region_init(&s->busmem, OBJECT(dev), "pci-mem", UINT64_MAX);
+    memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 64 * KiB);
     h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
-                         ppc440_pcix_map_irq, &s->irq, &s->busmem,
-                         get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
+                         ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
+                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
 
     s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
 
@@ -514,6 +516,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
     memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->regs);
     sysbus_init_mmio(sbd, &s->container);
+    sysbus_init_mmio(sbd, &s->iomem);
 }
 
 static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d446cfc37b..7da38bd58e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -269,7 +269,6 @@ static void main_cpu_reset(void *opaque)
 
 static void sam460ex_init(MachineState *machine)
 {
-    MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
     DeviceState *uic[4];
     int i;
@@ -441,12 +440,9 @@ static void sam460ex_init(MachineState *machine)
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
 
-    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io(),
-                             0, 0x10000);
-    memory_region_add_subregion(get_system_memory(), 0xc08000000, isa);
-
     /* PCI devices */
     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
     /* SoC has a single SATA port but we don't emulate that yet
-- 
2.41.0


