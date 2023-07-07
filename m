Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B9374AFFF
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhw-0003Yx-53; Fri, 07 Jul 2023 07:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhp-0003OM-De; Fri, 07 Jul 2023 07:32:57 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhm-0006oh-J7; Fri, 07 Jul 2023 07:32:57 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b72c4038b6so1632892a34.0; 
 Fri, 07 Jul 2023 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729572; x=1691321572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxHUJP19vs3SHivnjWffL5x3eI6sdELVD8/aW9X8H70=;
 b=Vak/LgXxMxsFXQB3BztiEWjchNi8TmYt1enSaAzs5pBcDBBoXhNSkIL/trG/lR/SwF
 N9ZkwjvEsujqAX1cWTX8Uid2ruEMkUsQZRY8vKK88iu0myx8GVsy7XlI9DlmCCI6kQkv
 HqBMKPnkkwb0tvyEbQoR4XfT2gONT81R2fwFIko7rsusvSYcq0+VtMpiOLA5pMdZ7Zw3
 L2jZzbWSnBfeEHgy+nFS6aVYqrYjCaWtakIipM/MYb27ZuruvZKwMg/l0BG1tQYWQp+o
 Pbo33v83LLmvv4VoOLcmMf5DQM6B+XfpnoDZUG9/lo+A/aB3tOHT2DfbgrqdnTbpXEt4
 XjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729572; x=1691321572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxHUJP19vs3SHivnjWffL5x3eI6sdELVD8/aW9X8H70=;
 b=U8ZkT84uLdHVcXjyPmG69mE87jIjlvs9mQ7pM1JlhMJ7V4cHbuZMcv7XbViiGeI6Y8
 aU63AD82iDmfpg+JIx40ibgZkSUQT3ORSbsESjKHoBE2WyCTx0Lisb1HKTq11ulSIRe3
 T1XL/aMmAoOnptBKPx4RavUR+nqNieNrXp8o+5xGBGF0qb8wja58JkELqqQWm2uzRx7C
 JiyA00LYcBPmQGxnuLSUiLhQTRU2qKfvUsV0qy4NK02toK98r8vhx6mjMQSwxkP1fFMX
 6+4wyd3jYadrRILEqmreCNXyfYlu0W6q32pEADAL77duao7CsnaUC2ndGzZoACUBmX3D
 RdYA==
X-Gm-Message-State: ABy/qLalim0TiuAo2oyW1P6kZM0J/p1IdgjUX6hheLALqMIlkryfxZAq
 apQeKG1TkoTNrroY5TJU/kZg1Lu6Kc0=
X-Google-Smtp-Source: APBJJlEEPqCVkceqhzIaJkPzT/v9v1yk3raYkfOgf8fHz/cvMavgFCZMiw17Z4U+0/ctYJvukd2O4A==
X-Received: by 2002:a9d:73c4:0:b0:6b8:7576:e695 with SMTP id
 m4-20020a9d73c4000000b006b87576e695mr5157985otk.4.1688729572598; 
 Fri, 07 Jul 2023 04:32:52 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:52 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/60] ppc440: Change ppc460ex_pcie_init() parameter type
Date: Fri,  7 Jul 2023 08:30:43 -0300
Message-ID: <20230707113108.7145-36-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x333.google.com
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

Change parameter of ppc460ex_pcie_init() from env to cpu to allow
further refactoring.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <1695d7cc1a9f1070ab498c078916e2389d6e9469.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440.h    | 2 +-
 hw/ppc/ppc440_uc.c | 7 ++++---
 hw/ppc/sam460ex.c  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index 7c24db8504..ae42bcf0c8 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -18,6 +18,6 @@ void ppc4xx_cpr_init(CPUPPCState *env);
 void ppc4xx_sdr_init(CPUPPCState *env);
 void ppc4xx_ahb_init(CPUPPCState *env);
 void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
-void ppc460ex_pcie_init(CPUPPCState *env);
+void ppc460ex_pcie_init(PowerPCCPU *cpu);
 
 #endif /* PPC440_H */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 651263926e..8eb985d714 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/reset.h"
+#include "cpu.h"
 #include "ppc440.h"
 
 /*****************************************************************************/
@@ -1108,17 +1109,17 @@ static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s, CPUPPCState *env)
                      &dcr_read_pcie, &dcr_write_pcie);
 }
 
-void ppc460ex_pcie_init(CPUPPCState *env)
+void ppc460ex_pcie_init(PowerPCCPU *cpu)
 {
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index cf065aae0e..aaa8d2f4a5 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -422,7 +422,7 @@ static void sam460ex_init(MachineState *machine)
     usb_create_simple(usb_bus_find(-1), "usb-mouse");
 
     /* PCI bus */
-    ppc460ex_pcie_init(env);
+    ppc460ex_pcie_init(cpu);
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
-- 
2.41.0


