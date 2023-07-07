Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037274B032
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiK-0005ks-40; Fri, 07 Jul 2023 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiI-0005el-CY; Fri, 07 Jul 2023 07:33:26 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiG-0006v8-LZ; Fri, 07 Jul 2023 07:33:26 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b8a6ca994eso1612107a34.1; 
 Fri, 07 Jul 2023 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729603; x=1691321603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVs/BjaU7Ny9Ee6xPsB0T49xiCynSpyTUpwRi2hXH2g=;
 b=IzeUjmal+M4Urmdj0Yc/IFBEoKmS2pm1cajQOyfC2nnfrN6XNuEJZRMbccRYS4i52G
 qzdahLwHuHIQd4RV2vGhzuw5DZvLQ3EBAgHWX1SkFt9vu+JKyCQdxWCwXZzGRVhQU43o
 K/L0jAwu5ZTTSebdal13AiwgCLBBsjSjofI867zXgVVxpkpCiTDLu8EV67n1KGuZpTcQ
 QfH7OdOyaZtpY4rS1zbnyVFZlTIBY5QjqGFQLt62T47T+b2OdhBJcicVpa/ax9RRXqjc
 FNukMLZINsB2CY+SiZMRPtS/67iE+jo4pHlF8H8aSb/fLnZsCVDa8P3OwMnbCYNIfMoV
 iTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729603; x=1691321603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVs/BjaU7Ny9Ee6xPsB0T49xiCynSpyTUpwRi2hXH2g=;
 b=RoqGaReUW0J/oNmVHGGA2KmSJ1aJtBnlHgVAO00LKldzmFqrASldmMK7QQQ/ePf22J
 CGtojtNy3RuKevRH1FJOMfQjgV2br303QZ/sh+55qw2tCqFUqeAvLlQbhYezKr8RLUe3
 az8M8SBNzdOsaJr3PejhEDTWIFphBoWtkibDwlyuAm30RJrgt4RQw0OJ9n+L6RDvPmWc
 YRanKtA9hGQsZD2c+ikw0cpAoEqoFLefZsoArw1q5as4BCfE5SACF+LD5BA2/iVBWH84
 xBiYLuPJpLWGBYjcb0ufAZX1jYP2YV+ZXV+6EZ2x9n87k8Az9hXZhdmgWTApOGfpz/gA
 05dQ==
X-Gm-Message-State: ABy/qLY2aqb8kR6GZw8+64z5md60FdW0yxYECkACl9Y5r4WStQhyO0mi
 hg8oi/Kk9zTWgwR61j5BHZZCFTzKIis=
X-Google-Smtp-Source: APBJJlH7icavj7KYT+NRxUTXvyxJs0BJfWxq2dOFyqh9yN0ggZIKXVNLkpVOhlIkw1AoLNyOWYPC0g==
X-Received: by 2002:a9d:6289:0:b0:6b8:81a3:9060 with SMTP id
 x9-20020a9d6289000000b006b881a39060mr4653150otk.6.1688729603151; 
 Fri, 07 Jul 2023 04:33:23 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 48/60] ppc440_pcix: Rename QOM type define abd move it to
 common header
Date: Fri,  7 Jul 2023 08:30:56 -0300
Message-ID: <20230707113108.7145-49-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
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

Rename TYPE_PPC440_PCIX_HOST_BRIDGE to better match its string value,
move it to common header and use it also in sam460ex to replace hard
coded type name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <1a1c3fe4b120f345d1005ad7ceca4500783691f7.1688641673.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_pcix.c    | 9 ++++-----
 hw/ppc/sam460ex.c       | 2 +-
 include/hw/ppc/ppc4xx.h | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 9321ca0abd..672090de94 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -45,8 +45,7 @@ struct PLBInMap {
     MemoryRegion mr;
 };
 
-#define TYPE_PPC440_PCIX_HOST_BRIDGE "ppc440-pcix-host"
-OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
 
 #define PPC440_PCIX_NR_POMS 3
 #define PPC440_PCIX_NR_PIMS 3
@@ -399,7 +398,7 @@ static const MemoryRegionOps pci_reg_ops = {
 
 static void ppc440_pcix_reset(DeviceState *dev)
 {
-    struct PPC440PCIXState *s = PPC440_PCIX_HOST_BRIDGE(dev);
+    struct PPC440PCIXState *s = PPC440_PCIX_HOST(dev);
     int i;
 
     for (i = 0; i < PPC440_PCIX_NR_POMS; i++) {
@@ -489,7 +488,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
     PCIHostState *h;
 
     h = PCI_HOST_BRIDGE(dev);
-    s = PPC440_PCIX_HOST_BRIDGE(dev);
+    s = PPC440_PCIX_HOST(dev);
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init(&s->busmem, OBJECT(dev), "pci-mem", UINT64_MAX);
@@ -529,7 +528,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc440_pcix_info = {
-    .name          = TYPE_PPC440_PCIX_HOST_BRIDGE,
+    .name          = TYPE_PPC440_PCIX_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC440PCIXState),
     .class_init    = ppc440_pcix_class_init,
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7da38bd58e..1e615b8d35 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -438,7 +438,7 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
-    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
+    dev = sysbus_create_simple(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 766d575e86..ea7740239b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -31,6 +31,7 @@
 
 #define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
 #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
+#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
-- 
2.41.0


