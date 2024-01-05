Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F458251E5
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:26:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNd-0007lT-PA; Fri, 05 Jan 2024 05:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNb-0007l3-MQ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNZ-0004Le-U3
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d76fefd6bso12383195e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450280; x=1705055080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REnTJhdFUEh9ogw8XoBpqYK4Nd8U+IE3k2q6fPhQ764=;
 b=HQ1Bklr4kB/Oke94GsQXZz6i5zCxuainb+0bGSb58kypbKgUTGyKdEkiiTHKmdL+h/
 UKhDYSXXzc7PV8E6Ei5K5srNYoSVDv8l8isCVd5WBC4oOp8JZN3HthBuHIsbxiROVhH5
 Eaa4MVThuJMkLPu59nK+XcuHKDqzNo6PcjhSXuaZ+A5YPwX4ug6+Z1it5aytvlXi0KJW
 QYxQ9jszBP20/mBA25L3AV7L97FIA0vDHjt4NYVzRiHS6dgNNe9k9jvwpP4wUFbgXx0s
 JwIVxUOrSl/ZfYKeGuWaGQPUeBRGinNEuaIsLurMRkCH11W0EubQhv7oAzN/XTuSoCry
 1Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450280; x=1705055080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REnTJhdFUEh9ogw8XoBpqYK4Nd8U+IE3k2q6fPhQ764=;
 b=SBDEvqcRuuNF94cQQlarHF8lxJ6Fkk6KUS/kCVeHI5kEJCFTFyhONk0TgzyhdXrvRM
 nrg1c1sF0MmFfxTyhbHo9LNKLL13DEky5Had372iTvbdWTNDBXKF1E0ySpXazhp5vApo
 0CYtNgcLyIOxxsdfP7D9fd0L0gjL9dkHNyIUiftgFc8WQCmq0AnrEq1iM5ueR9dy4KJW
 Swo+jmc7ZJYu2zEjAs+O0tgf4GfYz/LeSX96DPptsbUprp2ZodJz9stadB10wfvBAH6C
 Qsq2mhFhqZICVvRcZ/WJGe6y6z8ezn+ut/PWt1re8OCapdXcjza1KWBSyhpVSVa0/XRJ
 1UdA==
X-Gm-Message-State: AOJu0YyXtjJNX7KZRUD10O5szIWsWRlODbKdccAWf/YfkwA5f0TF2Cv3
 eeh9ZLnixlH9g44LdDcqrfrq4vBaxAiKtIudFCcRictHpA==
X-Google-Smtp-Source: AGHT+IHYP3ho2Cg6MLPsSfS4EMsRRvnifsAnWQn8QIcxvrJnjTbG6dlWNrJtU/v83TVHJHMhXAdf7Q==
X-Received: by 2002:a05:600c:3b90:b0:40e:34d3:8ef5 with SMTP id
 n16-20020a05600c3b9000b0040e34d38ef5mr507203wms.147.1704450279958; 
 Fri, 05 Jan 2024 02:24:39 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:39 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 4/9] intc/grlib_irqmp: implements multicore irq
Date: Fri,  5 Jan 2024 11:24:16 +0100
Message-Id: <20240105102421.163554-5-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Now there is an ncpus property, use it in order to deliver the IRQ to
multiple CPU.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/intc/grlib_irqmp.c         | 43 ++++++++++++++++++-----------------
 hw/sparc/leon3.c              |  3 ++-
 include/hw/intc/grlib_irqmp.h |  2 +-
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index be0e840181..4df0293064 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -64,7 +64,7 @@ struct IRQMP {
     unsigned int ncpus;
     IRQMPState *state;
     qemu_irq start_signal[IRQMP_MAX_CPU];
-    qemu_irq irq;
+    qemu_irq irq[IRQMP_MAX_CPU];
 };
 
 struct IRQMPState {
@@ -83,37 +83,37 @@ struct IRQMPState {
 
 static void grlib_irqmp_check_irqs(IRQMPState *state)
 {
-    uint32_t      pend   = 0;
-    uint32_t      level0 = 0;
-    uint32_t      level1 = 0;
+    uint32_t pend = 0;
+    uint32_t level0 = 0;
+    uint32_t level1 = 0;
+    int i;
 
     assert(state != NULL);
     assert(state->parent != NULL);
 
-    /* IRQ for CPU 0 (no SMP support) */
-    pend = (state->pending | state->force[0])
-        & state->mask[0];
-
-    level0 = pend & ~state->level;
-    level1 = pend &  state->level;
+    for (i = 0; i < state->parent->ncpus; i++) {
+        pend = (state->pending | state->force[i]) & state->mask[i];
+        level0 = pend & ~state->level;
+        level1 = pend &  state->level;
 
-    trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
-                                 state->mask[0], level1, level0);
+        trace_grlib_irqmp_check_irqs(state->pending, state->force[i],
+                                     state->mask[i], level1, level0);
 
-    /* Trigger level1 interrupt first and level0 if there is no level1 */
-    qemu_set_irq(state->parent->irq, level1 ?: level0);
+        /* Trigger level1 interrupt first and level0 if there is no level1 */
+        qemu_set_irq(state->parent->irq[i], level1 ?: level0);
+    }
 }
 
-static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
+static void grlib_irqmp_ack_mask(IRQMPState *state, int cpu, uint32_t mask)
 {
     /* Clear registers */
     state->pending  &= ~mask;
-    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
+    state->force[cpu] &= ~mask;
 
     grlib_irqmp_check_irqs(state);
 }
 
-void grlib_irqmp_ack(DeviceState *dev, int intno)
+void grlib_irqmp_ack(DeviceState *dev, int cpu, int intno)
 {
     IRQMP        *irqmp = GRLIB_IRQMP(dev);
     IRQMPState   *state;
@@ -127,7 +127,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
 
     trace_grlib_irqmp_ack(intno);
 
-    grlib_irqmp_ack_mask(state, mask);
+    grlib_irqmp_ack_mask(state, cpu, mask);
 }
 
 static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -153,7 +153,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
             s->pending |= 1 << irq;
         }
         grlib_irqmp_check_irqs(s);
-
     }
 }
 
@@ -257,7 +256,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 
     case CLEAR_OFFSET:
         value &= ~1; /* clean up the value */
-        grlib_irqmp_ack_mask(state, value);
+        for (i = 0; i < irqmp->ncpus; i++) {
+            grlib_irqmp_ack_mask(state, i, value);
+        }
         return;
 
     case MP_STATUS_OFFSET:
@@ -352,7 +353,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     /* Transitionning from 0 to 1 starts the CPUs.  */
     qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
                              IRQMP_MAX_CPU);
-    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    qdev_init_gpio_out_named(dev, irqmp->irq, "grlib-irq", irqmp->ncpus);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 7b9809b81f..94d8ec94b0 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -168,7 +168,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(void *irq_manager, int intno)
 {
-    grlib_irqmp_ack((DeviceState *)irq_manager, intno);
+    /* No SMP support yet.  */
+    grlib_irqmp_ack((DeviceState *)irq_manager, 0, intno);
 }
 
 /*
diff --git a/include/hw/intc/grlib_irqmp.h b/include/hw/intc/grlib_irqmp.h
index b9cc584168..776a2508e1 100644
--- a/include/hw/intc/grlib_irqmp.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -34,6 +34,6 @@
 /* IRQMP */
 #define TYPE_GRLIB_IRQMP "grlib-irqmp"
 
-void grlib_irqmp_ack(DeviceState *dev, int intno);
+void grlib_irqmp_ack(DeviceState *dev, int cpu, int intno);
 
 #endif /* GRLIB_IRQMP_H */
-- 
2.25.1


