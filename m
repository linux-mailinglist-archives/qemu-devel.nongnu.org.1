Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14D74B023
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiD-0004ly-F5; Fri, 07 Jul 2023 07:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji6-0004Pv-4x; Fri, 07 Jul 2023 07:33:14 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji2-0006qg-LG; Fri, 07 Jul 2023 07:33:13 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b7474b0501so1632282a34.1; 
 Fri, 07 Jul 2023 04:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729587; x=1691321587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpB6ZGkVhPQCZ3fnLSAyzmXkzRSjvG2TUmxE50LGkm4=;
 b=dCr7G6Wpu/NupL+btz/oVHKG0iYxRiqAKQ1nAcIz7fttj2KfrK+Orn0J2RjibA4S/y
 ZpMcDuFR05kLGIX9j2714utxGOY7hPKcm7yOEONBMRwEHKYZEGlM82gUuNRi1GZeT/9Z
 Downjlm6tC9qJdD66e15g2IHhtw+wIKMAPwF8q336gh3gm2oI58rS9OABUcvBID/CLCr
 TaGHN4wBEjW/cuzB6sh5dAJ34qJYYL3GhbO01r2fqe9CQ+HHY9rbXUuzwAPJBJDx7pLC
 CAme45SOHZfnOywxJZAdXNRU50j8CmEC5exSsS9SlUIf099dwqlZe967gPY09eEnLJ1d
 jYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729587; x=1691321587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpB6ZGkVhPQCZ3fnLSAyzmXkzRSjvG2TUmxE50LGkm4=;
 b=bKcKMiU36yGEejrBhz+38e8JP/XgZ1QmTH72elmX8i9aM4tv5JZRiE09Xid6LDdGX8
 UyXRSdBmfxZ2nJeNkaRDfYDYiq5y8EFoZcOtvofH2rp8d2jLCipZOxFl5z7HL/nOk6Yl
 TEnailVjH311shjNBaZeVr+Z+GgBN3wGA6QyLpL8NZLeyvaDRitvKc/G2mKi3m/J5gFz
 M2TiHIDmYLNhXhfsLCVW58IYJUHa2wwmI+4EaMFtpdbXhsAhbAREcDeMlsOQ0PhFv/gs
 SYKGWC4udX376vuH+JHoVDZKtwVke1gIFsEND5jyVsAd8RttbmmCYMjeYBbdz8AGE0Bt
 FU6w==
X-Gm-Message-State: ABy/qLZp/TYllRAjHgw+aB0GEuQAbWfqb424iQEIQl8lSd1yTQzvTaZr
 7l3H0poPzxeO+O5jZx8cSHVQ2r235BQ=
X-Google-Smtp-Source: APBJJlGocxCHKfxPkMvcghrwNAGBDaR0rCehgWdIfJfEWoAOeVyE4o5sZPqR8jCmeoTEhdSKIarfXQ==
X-Received: by 2002:a05:6830:1bcc:b0:6b7:4f35:c68e with SMTP id
 v12-20020a0568301bcc00b006b74f35c68emr4896057ota.34.1688729587079; 
 Fri, 07 Jul 2023 04:33:07 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:06 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/60] ppc440: Add busnum property to PCIe controller model
Date: Fri,  7 Jul 2023 08:30:49 -0300
Message-ID: <20230707113108.7145-42-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
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

Instead of guessing controller number from dcrn_base add a property so
the device does not need knowledge about where it is used.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <fdb84344025e00fadf74d0be95665fcb0ac1e039.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 663abf3449..b74b2212fa 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -779,6 +779,7 @@ struct PPC460EXPCIEState {
     MemoryRegion busmem;
     MemoryRegion iomem;
     qemu_irq irq[4];
+    int32_t num;
     int32_t dcrn_base;
     PowerPCCPU *cpu;
 
@@ -1039,32 +1040,25 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 {
     PPC460EXPCIEState *s = PPC460EX_PCIE_HOST(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
-    int i, id;
-    char buf[16];
+    int i;
+    char buf[20];
 
     if (!s->cpu) {
         error_setg(errp, "cpu link property must be set");
         return;
     }
-    switch (s->dcrn_base) {
-    case DCRN_PCIE0_BASE:
-        id = 0;
-        break;
-    case DCRN_PCIE1_BASE:
-        id = 1;
-        break;
-    default:
-        error_setg(errp, "invalid PCIe DCRN base");
+    if (s->num < 0 || s->dcrn_base < 0) {
+        error_setg(errp, "busnum and dcrn-base properties must be set");
         return;
     }
-    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
+    snprintf(buf, sizeof(buf), "pcie%d-mem", s->num);
     memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
-    snprintf(buf, sizeof(buf), "pcie%d-io", id);
+    snprintf(buf, sizeof(buf), "pcie%d-io", s->num);
     memory_region_init(&s->iomem, OBJECT(s), buf, 64 * KiB);
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
-    snprintf(buf, sizeof(buf), "pcie.%d", id);
+    snprintf(buf, sizeof(buf), "pcie.%d", s->num);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->busmem,
                                 &s->iomem, 0, 4, TYPE_PCIE_BUS);
@@ -1072,6 +1066,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 }
 
 static Property ppc460ex_pcie_props[] = {
+    DEFINE_PROP_INT32("busnum", PPC460EXPCIEState, num, -1),
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
     DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
                      PowerPCCPU *),
@@ -1107,11 +1102,13 @@ void ppc460ex_pcie_init(PowerPCCPU *cpu)
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 0);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
+    qdev_prop_set_int32(dev, "busnum", 1);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
     object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.41.0


