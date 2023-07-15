Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032817549BF
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 17:23:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKh6f-0007ou-5V; Sat, 15 Jul 2023 11:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKh6d-0007oi-J6
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 11:22:47 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKh6b-0006qu-HZ
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 11:22:47 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2657d405ad5so2002971a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689434564; x=1692026564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVxiV+HfosOzg8/U+wL0JzZKbEPKyV+77++xvpIROvc=;
 b=Tlu/gElOoiG9PkM6WxnBGUgKUcs4bX+IH8htb6J81WqTf0DoqZA4nMcqWDZ4owC2YU
 cpluMBqoy4DN83b1W80LTGTYWNI3z8OO8ZDGZa5UsrLRM+Xm70fqwutam9XxWWd2rU42
 NDVSK0a4selIlgpunO2c8fAFxsiwd2JHmgyF8WSwSzeGaVfegsInum3Rw+LgYRnMjwmZ
 rSj0F/jlTvXPi+i4Fp0u3X+nLq9yA59DzEhv5gLkVuRjucsoNoAiHn/QTOf0PNDqI9ij
 ZrOCcUclrAS/sWlszFHuxEIUHTnZkybBl7vd3x7DiwMO3XgtzMDGTrt4ou1uJpgiSb+m
 gCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689434564; x=1692026564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVxiV+HfosOzg8/U+wL0JzZKbEPKyV+77++xvpIROvc=;
 b=jvtvoyGmrmPYDP5Mt93q9fvWcTiP1QuGyyyUDZm2HYZiHgPCnLvYtjB/xU+Sz5DttJ
 /P9aiU+6K3rZKEJsh5F+xDuzKH0nO/C8eCFBk3+yrDi7LapZnBt/WR5QqVhKSiYVt9zI
 Cvn5tHVBf8PdkLRuIb/koVYq4/MKD4qEvbgmCLFdid+r9RlgiLyTIYbuv1MUWnMJ2bhw
 vg5wyO3fwiPckp0HxDvGwp29mik90X8JiVviMQpfZhLvvrH/d1Pxxd/zxN5vGP/9vKNY
 VPCk+tRVo9USA8JA3LPG86ostzM4+76dljWzez/bRxmT3Zq8ucGJv1FzbB2WwDh6HGRz
 xxvw==
X-Gm-Message-State: ABy/qLbDp4HmUfnW4ICgeKwzHIIrApHZEJ4kTxXgv/wkxJygbA8/kHnF
 6FKCMjD9jXxh9vysvk5U8ysa8RXPrdip9A==
X-Google-Smtp-Source: APBJJlEuXCFbcll8wsf80sgX/LWYV01qjyyMphLvRUYnN3yuolXpk9Zk/TgvHV7OM7/hh6bOeKMpig==
X-Received: by 2002:a17:90a:d3c5:b0:25e:886b:c6b with SMTP id
 d5-20020a17090ad3c500b0025e886b0c6bmr6264734pjw.48.1689434563755; 
 Sat, 15 Jul 2023 08:22:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:7c3c:1099:10bd:2e8b])
 by smtp.googlemail.com with ESMTPSA id
 fv14-20020a17090b0e8e00b00256a4d59bfasm2638721pjb.23.2023.07.15.08.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 08:22:43 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 1/5] i386/tcg: implement x2APIC registers MSR access
Date: Sat, 15 Jul 2023 22:22:20 +0700
Message-Id: <20230715152224.54757-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230715152224.54757-1-minhquangbui99@gmail.com>
References: <20230715152224.54757-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x102e.google.com
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

This commit refactors apic_mem_read/write to support both MMIO access in
xAPIC and MSR access in x2APIC.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/intc/apic.c                       | 79 ++++++++++++++++++----------
 hw/intc/trace-events                 |  4 +-
 include/hw/i386/apic.h               |  3 ++
 target/i386/cpu.h                    |  3 ++
 target/i386/tcg/sysemu/misc_helper.c | 27 ++++++++++
 5 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ac3d47d231..cb8c20de93 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -288,6 +288,13 @@ void apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode,
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
 }
 
+bool is_x2apic_mode(DeviceState *dev)
+{
+    APICCommonState *s = APIC(dev);
+
+    return s->apicbase & MSR_IA32_APICBASE_EXTD;
+}
+
 static void apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = (val & 0xfffff000) |
@@ -636,16 +643,11 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+uint64_t apic_register_read(int index)
 {
     DeviceState *dev;
     APICCommonState *s;
-    uint32_t val;
-    int index;
-
-    if (size < 4) {
-        return 0;
-    }
+    uint64_t val;
 
     dev = cpu_get_current_apic();
     if (!dev) {
@@ -653,7 +655,6 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     }
     s = APIC(dev);
 
-    index = (addr >> 4) & 0xff;
     switch(index) {
     case 0x02: /* id */
         val = s->id << 24;
@@ -720,7 +721,23 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
         val = 0;
         break;
     }
-    trace_apic_mem_readl(addr, val);
+
+    trace_apic_register_read(index, val);
+    return val;
+}
+
+static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val;
+    int index;
+
+    if (size < 4) {
+        return 0;
+    }
+
+    index = (addr >> 4) & 0xff;
+    val = (uint32_t)apic_register_read(index);
+
     return val;
 }
 
@@ -737,27 +754,10 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
-                           unsigned size)
+void apic_register_write(int index, uint64_t val)
 {
     DeviceState *dev;
     APICCommonState *s;
-    int index = (addr >> 4) & 0xff;
-
-    if (size < 4) {
-        return;
-    }
-
-    if (addr > 0xfff || !index) {
-        /* MSI and MMIO APIC are at the same memory location,
-         * but actually not on the global bus: MSI is on PCI bus
-         * APIC is connected directly to the CPU.
-         * Mapping them on the global bus happens to work because
-         * MSI registers are reserved in APIC MMIO and vice versa. */
-        MSIMessage msi = { .address = addr, .data = val };
-        apic_send_msi(&msi);
-        return;
-    }
 
     dev = cpu_get_current_apic();
     if (!dev) {
@@ -765,7 +765,7 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     }
     s = APIC(dev);
 
-    trace_apic_mem_writel(addr, val);
+    trace_apic_register_write(index, val);
 
     switch(index) {
     case 0x02:
@@ -843,6 +843,29 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
+static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
+{
+    int index = (addr >> 4) & 0xff;
+
+    if (size < 4) {
+        return;
+    }
+
+    if (addr > 0xfff || !index) {
+        /* MSI and MMIO APIC are at the same memory location,
+         * but actually not on the global bus: MSI is on PCI bus
+         * APIC is connected directly to the CPU.
+         * Mapping them on the global bus happens to work because
+         * MSI registers are reserved in APIC MMIO and vice versa. */
+        MSIMessage msi = { .address = addr, .data = val };
+        apic_send_msi(&msi);
+        return;
+    }
+
+    apic_register_write(index, val);
+}
+
 static void apic_pre_save(APICCommonState *s)
 {
     apic_sync_vapic(s, SYNC_FROM_VAPIC);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 36ff71f947..1ef29d0256 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -14,8 +14,8 @@ cpu_get_apic_base(uint64_t val) "0x%016"PRIx64
 # apic.c
 apic_local_deliver(int vector, uint32_t lvt) "vector %d delivery mode %d"
 apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode, uint8_t vector_num, uint8_t trigger_mode) "dest %d dest_mode %d delivery_mode %d vector %d trigger_mode %d"
-apic_mem_readl(uint64_t addr, uint32_t val)  "0x%"PRIx64" = 0x%08x"
-apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
+apic_register_read(uint8_t reg, uint64_t val) "register 0x%02x = 0x%"PRIx64
+apic_register_write(uint8_t reg, uint64_t val) "register 0x%02x = 0x%"PRIx64
 
 # ioapic.c
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index bdc15a7a73..2cebeb4faf 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -18,6 +18,9 @@ void apic_sipi(DeviceState *s);
 void apic_poll_irq(DeviceState *d);
 void apic_designate_bsp(DeviceState *d, bool bsp);
 int apic_get_highest_priority_irr(DeviceState *dev);
+uint64_t apic_register_read(int index);
+void apic_register_write(int index, uint64_t val);
+bool is_x2apic_mode(DeviceState *d);
 
 /* pc.c */
 DeviceState *cpu_get_current_apic(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..7252a5cdeb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -545,6 +545,9 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 
+#define MSR_APIC_START                  0x00000800
+#define MSR_APIC_END                    0x000008ff
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index e1528b7f80..1fce2076a3 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
+#include "hw/i386/apic.h"
 
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
 {
@@ -289,6 +290,19 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        if (!is_x2apic_mode(env_archcpu(env)->apic_state)) {
+            goto error;
+        }
+
+        qemu_mutex_lock_iothread();
+        apic_register_write(index, val);
+        qemu_mutex_unlock_iothread();
+
+        break;
+    }
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
@@ -455,6 +469,19 @@ void helper_rdmsr(CPUX86State *env)
         val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
         break;
     }
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        if (!is_x2apic_mode(env_archcpu(env)->apic_state)) {
+            raise_exception_ra(env, EXCP0D_GPF, GETPC());
+        }
+
+        qemu_mutex_lock_iothread();
+        val = apic_register_read(index);
+        qemu_mutex_unlock_iothread();
+
+        break;
+    }
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-- 
2.25.1


