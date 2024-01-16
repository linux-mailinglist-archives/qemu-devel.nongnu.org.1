Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2482EF5C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:04:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5i-0007IL-HQ; Tue, 16 Jan 2024 08:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5c-0007Hn-F9
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:48 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5a-0006g4-8s
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:47 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e86a76c11so2308455e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410164; x=1706014964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pIlUU+GsEiZomgAXvCovNK6rwXUq8Y5QhmXuYcBtvI=;
 b=XGkyK46AnOWdlCsrkul7bejn8hE5S2QmJ9CUFQVIO89yDoVoWCKQbkHGNAoGVIoshi
 Ie6qp1Ac3d9ht4RYUM4CCIIVZk1u8yhn9EH+IOaMZzLm5PHpJWr16Hgo3YlEI4Y9j6F1
 tQkH/wO/Fz4lXHVaktSi6OQiUQ+LYDG4sz1eeciyHklXwNX5aCcyvhzuYrgTjbrOihiX
 RdoHAoZu5uxyTE3JkZFvA1dIf6UnE/FmJbvHoaMF6N6IOLOP5N+ksYunBpMjmX9ma66I
 HGSrLe2U+PVQcUSthohQXf06Tv0aF8OrBPMYNMtHfIECA8qz8k5wtEOaIavWOukcjaFF
 qgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410164; x=1706014964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pIlUU+GsEiZomgAXvCovNK6rwXUq8Y5QhmXuYcBtvI=;
 b=LOZlXqApml45mVTi+USfFjjrPteEpf+oqZwCDhTGxjWbVUbgPZuGWZ5DAKjD1rBANB
 y7o59MrcQMThKAfHl34QKj42LGkv7Cwo6Tpaal35Xt6wWe6GA/QZcPwBenRf/OFI84x5
 FWbbc7GXJsBkPgtg1SR8SMZ/lFyzBamPAF7s8JpSKL1LpL+P0uniM6Ngorks/nBYHSs6
 SnFK/ibxLnHrpYyNB5JtdY0W1rX198tDSMMiLDuPa9LY1xueYpIQOmZQJ0Jt0vfOV2B1
 8enhxywBhArkfY1FcZH3BCDWBKoDYqUojyGgobsQFfIqI95O8RxnGvUhxlJ5V04E/0tF
 bY8w==
X-Gm-Message-State: AOJu0YzPIbxAY+z5zR4GM8e9/n4F/MgjWK1eOVB00fKOA5Qr89PKBAOr
 fsepf2eDPCCxWrIu9njLzTl1RaSKPaEpHP38LLThpy2G4w==
X-Google-Smtp-Source: AGHT+IFdipKyCkG5drRV5Hi0vnpwvVOEU8+YH7MwtZUVMneK6F3Q5DDy5MogfGw9rImUiXOO80jgAg==
X-Received: by 2002:a05:600c:4292:b0:40d:3b0a:6edb with SMTP id
 v18-20020a05600c429200b0040d3b0a6edbmr2612070wmc.183.1705410164285; 
 Tue, 16 Jan 2024 05:02:44 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:43 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v2 4/8] intc/grlib_irqmp: implements multicore irq
Date: Tue, 16 Jan 2024 14:02:09 +0100
Message-Id: <20240116130213.172358-5-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x333.google.com
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
index 8299ac183e..91237e6c44 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -70,7 +70,7 @@ struct IRQMP {
     unsigned int ncpus;
     IRQMPState *state;
     qemu_irq start_signal[IRQMP_MAX_CPU];
-    qemu_irq irq;
+    qemu_irq irq[IRQMP_MAX_CPU];
 };
 
 struct IRQMPState {
@@ -89,37 +89,37 @@ struct IRQMPState {
 
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
@@ -133,7 +133,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
 
     trace_grlib_irqmp_ack(intno);
 
-    grlib_irqmp_ack_mask(state, mask);
+    grlib_irqmp_ack_mask(state, cpu, mask);
 }
 
 static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -159,7 +159,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
             s->pending |= 1 << irq;
         }
         grlib_irqmp_check_irqs(s);
-
     }
 }
 
@@ -263,7 +262,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 
     case CLEAR_OFFSET:
         value &= ~1; /* clean up the value */
-        grlib_irqmp_ack_mask(state, value);
+        for (i = 0; i < irqmp->ncpus; i++) {
+            grlib_irqmp_ack_mask(state, i, value);
+        }
         return;
 
     case MP_STATUS_OFFSET:
@@ -367,7 +368,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
      */
     qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
                              IRQMP_MAX_CPU);
-    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    qdev_init_gpio_out_named(dev, irqmp->irq, "grlib-irq", irqmp->ncpus);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index b72761b959..7866f0a049 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -170,7 +170,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    grlib_irqmp_ack(env->irq_manager, intno);
+    /* No SMP support yet, only CPU #0 available so far.  */
+    grlib_irqmp_ack(env->irq_manager, 0, intno);
 }
 
 /*
diff --git a/include/hw/intc/grlib_irqmp.h b/include/hw/intc/grlib_irqmp.h
index c5a90cbb3e..b564a0009f 100644
--- a/include/hw/intc/grlib_irqmp.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -36,6 +36,6 @@
 /* IRQMP */
 #define TYPE_GRLIB_IRQMP "grlib-irqmp"
 
-void grlib_irqmp_ack(DeviceState *dev, int intno);
+void grlib_irqmp_ack(DeviceState *dev, int cpu, int intno);
 
 #endif /* GRLIB_IRQMP_H */
-- 
2.25.1


