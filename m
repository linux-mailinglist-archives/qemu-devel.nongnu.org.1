Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811A74AFFB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHji3-000418-SQ; Fri, 07 Jul 2023 07:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji1-0003pe-BS; Fri, 07 Jul 2023 07:33:09 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjho-0006oz-Dp; Fri, 07 Jul 2023 07:32:58 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b72c4038b6so1632923a34.0; 
 Fri, 07 Jul 2023 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729575; x=1691321575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFO7Y1HmFXTaq7XKJ3Bg16iAlPuGYGgGp7kxqN+zgMw=;
 b=rct+VkdHoM+Pya6Y+avm9RP8MlEzYt9ZXjc37+EW+G0CcG0hSPDKwdypqkGWzKuKY3
 ucZWomSwuZKVzV93MZIaWaXVRUQmhK6QqYbBwoXWRqiprb+k1+Bq04ADvB1M7usFhumB
 u7ntDdG0CHKpfvCUmd4BCiO/CapA0PTDfMN2PYNaZK/ipodN80JKp6cvjBBtvU/j3S3m
 YaCBNRH4+0KHhgYVW/H9DbG+sGfK7wNad1Pu3pbfeRFgY53Uu91XRP4cPoOdzlKyw+01
 JipQh+QnHGiwd3cBCi81SexomiDgxDh8cwlyxnQK/rlW7dLD9PquEOTqRZd3rVkPDHRM
 wspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729575; x=1691321575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFO7Y1HmFXTaq7XKJ3Bg16iAlPuGYGgGp7kxqN+zgMw=;
 b=XFWhYlVL041nAUE0EapqQT87YZxpeKkmWZq0Z3fPn9INHbIIRYHwz3cqR/BbmEgrHn
 vkhM3TxlvjiLYxoDctSxM1+OEKhOFJcVt3Q8Nq2UvPCYWsSl5BLRp6EGU/eLF7Q+jagQ
 95x5Le5kzZB0gOGjCQ7atqT68P19CBClMrwGwB/772XF6ZZ7hKsee6G4Slw4zBz8yNbK
 N9uwpSPhbe5l75V25t2rJVCAE0sFfKdYWSbQLyNi7Vy67hUjqP1v6CH/Z0Jl9SFL0E0C
 TO+lvjizKXVFVZT02b5yfas73n3p5m9Lox544vQ4O0YbVXJ82eAUZnlGDoq/Ufh4QyTK
 gXYQ==
X-Gm-Message-State: ABy/qLZl6FPK48tw1T9cyrj0lRnBqhafRykSKLFqlsvQlsTXCU5yrIXw
 IzaMz0gfnr8LA1pahOT8pS4qDTTmOs8=
X-Google-Smtp-Source: APBJJlElPm9HrVNkOuUuagVBmzBRABlTtJGHJLrUAKmvlYW0lH7APxsveZdXIrYcB1HMdgN0WwWaTg==
X-Received: by 2002:a05:6830:1d42:b0:6b5:ddf4:cb59 with SMTP id
 p2-20020a0568301d4200b006b5ddf4cb59mr4801107oth.28.1688729574894; 
 Fri, 07 Jul 2023 04:32:54 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:54 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/60] ppc440: Add cpu link property to PCIe controller model
Date: Fri,  7 Jul 2023 08:30:44 -0300
Message-ID: <20230707113108.7145-37-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
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

The PCIe controller model uses PPC DCRs but cannot be modeled with
TYPE_PPC4xx_DCR_DEVICE as it derives from TYPE_PCIE_HOST_BRIDGE. Add a
cpu link property to it similar to other DCR devices to allow
registering DCRs from the device model.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <a79796654deaa81a6a1c71efc874e4d88c4cafd4.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 114 ++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 8eb985d714..b26c0cee1b 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -779,6 +779,7 @@ struct PPC460EXPCIEState {
     MemoryRegion iomem;
     qemu_irq irq[4];
     int32_t dcrn_base;
+    PowerPCCPU *cpu;
 
     uint64_t cfg_base;
     uint32_t cfg_mask;
@@ -1001,6 +1002,58 @@ static void ppc460ex_set_irq(void *opaque, int irq_num, int level)
        qemu_set_irq(s->irq[irq_num], level);
 }
 
+static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s)
+{
+    CPUPPCState *env = &s->cpu->env;
+
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+}
+
 static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 {
     PPC460EXPCIEState *s = PPC460EX_PCIE_HOST(dev);
@@ -1008,6 +1061,10 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     int i, id;
     char buf[16];
 
+    if (!s->cpu) {
+        error_setg(errp, "cpu link property must be set");
+        return;
+    }
     switch (s->dcrn_base) {
     case DCRN_PCIE0_BASE:
         id = 0;
@@ -1028,10 +1085,13 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->iomem,
                                 get_system_io(), 0, 4, TYPE_PCIE_BUS);
+    ppc460ex_pcie_register_dcrs(s);
 }
 
 static Property ppc460ex_pcie_props[] = {
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
+    DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
+                     PowerPCCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1059,67 +1119,17 @@ static void ppc460ex_pcie_register(void)
 
 type_init(ppc460ex_pcie_register)
 
-static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s, CPUPPCState *env)
-{
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-}
-
 void ppc460ex_pcie_init(PowerPCCPU *cpu)
 {
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 }
-- 
2.41.0


