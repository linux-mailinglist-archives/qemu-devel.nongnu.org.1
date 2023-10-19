Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B007CFB4E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCd-0002yH-C1; Thu, 19 Oct 2023 09:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBp-0001ra-9g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBi-0001DY-Fb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32dcd3e5f3fso1461633f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722544; x=1698327344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdZbt+1sSHwtsO7gY0q3tnj/BPqK0sWsSu3jh1jJfxY=;
 b=qz557kmhm3LAcCaHejKCS/8GX/1Nemq/Thk0+LQ3NB19ZNU6LraBt6eLJe+KIMYsSj
 7/EWzo5Pm6A6l0Vst98pM5uUUWadF23vlMOTwF4zhwMbTPKiHXy8C/80jMsYca72mbKL
 rRPQrWr1g5swwpHO01mfM8Qog9YuWqwP1gzdns+vHLdHmLrDPDXzk1btEekExwvLmoTw
 xi/zp3fRV0VrZZGSJB02JVnzpuLSESIxQ+02q2Rm8Solcq01wqsdC5j3iRIw/wqsEM+f
 YjG0D3/TkaDWUwlGjuwm7lVhZvIp1OwfVGWxboAyiaj14UtXY8YUrcJpZbItVoCQN3NX
 UibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722544; x=1698327344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdZbt+1sSHwtsO7gY0q3tnj/BPqK0sWsSu3jh1jJfxY=;
 b=XfQX0OX+Jjs2X/kHKQF1NYA4FpShvPH3npyiF34xPiW25qsV2ioTxtfw8+H/4HV23D
 tsJfCgj8TOOvf6XLLYAuh1tAiPHZGUEzkQf9jGdp4DRCUcDSsQDqurXAQCTOtrSgImiB
 s+hcMQ/q/gBbZFtaemdE7F4fkhoULNDytgDONu0EbcEpBboerQG2iHSqlslBG4u5Sipy
 RaDtOb7ZoQJ5Ehf8Qy2SHvBI9N2MbwRUtQt2+UDfpoY49k7RAS7zzKnRJmpIVulJ+Pys
 F8e1yZnOeRPGkM73qvxE6aWdOA+zi6+DB9I7cQTPrawP5/+WxpqFQoHJJmwrDJvmIHfq
 W8Qw==
X-Gm-Message-State: AOJu0YxdDxE+/8FIb4TsD+KpG54Qs64ytZYXcPdWjaWQ7Z20SP4epPYI
 G3MA5NxiPdwDyau6ep2wwrFvEKEQ5gVwqYod7ZQ=
X-Google-Smtp-Source: AGHT+IHIszz8xnUhWVV/9FCino+v9gi7P5fNRNJgCDpqah3hDGuaoHWHBKXbye7ztMFyoeT20G/CkQ==
X-Received: by 2002:a5d:5b1f:0:b0:32d:a2a0:bd6c with SMTP id
 bx31-20020a5d5b1f000000b0032da2a0bd6cmr2040420wrb.34.1697722544387; 
 Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/24] hw/arm/sbsa-ref: use bsa.h for PPI definitions
Date: Thu, 19 Oct 2023 14:35:25 +0100
Message-Id: <20231019133537.2114929-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Leif Lindholm <quic_llindhol@quicinc.com>

Use the private peripheral interrupt definitions from bsa.h instead of
defining them locally. Refactor to use the INTIDs defined there instead
of the PPI# used previously.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
Message-id: 20230919090229.188092-4-quic_llindhol@quicinc.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 3c7dfcd6dc5..e8a82618f0a 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -2,6 +2,7 @@
  * ARM SBSA Reference Platform emulation
  *
  * Copyright (c) 2018 Linaro Limited
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -30,6 +31,7 @@
 #include "exec/hwaddr.h"
 #include "kvm_arm.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
@@ -55,14 +57,6 @@
 #define NUM_SMMU_IRQS   4
 #define NUM_SATA_PORTS  6
 
-#define VIRTUAL_PMU_IRQ        7
-#define ARCH_GIC_MAINT_IRQ     9
-#define ARCH_TIMER_VIRT_IRQ    11
-#define ARCH_TIMER_S_EL1_IRQ   13
-#define ARCH_TIMER_NS_EL1_IRQ  14
-#define ARCH_TIMER_NS_EL2_IRQ  10
-#define ARCH_TIMER_NS_EL2_VIRT_IRQ  12
-
 enum {
     SBSA_FLASH,
     SBSA_MEM,
@@ -479,7 +473,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
         int irq;
         /*
          * Mapping from the output timer irq lines from the CPU to the
@@ -496,14 +490,17 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(sms->gic,
-                                                   ppibase + timer_irq[irq]));
+                                                   intidbase + timer_irq[irq]));
         }
 
         qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
-                                    qdev_get_gpio_in(sms->gic, ppibase
+                                    qdev_get_gpio_in(sms->gic,
+                                                     intidbase
                                                      + ARCH_GIC_MAINT_IRQ));
+
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(sms->gic, ppibase
+                                    qdev_get_gpio_in(sms->gic,
+                                                     intidbase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-- 
2.34.1


