Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6587AF048
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAbW-0001om-I1; Tue, 26 Sep 2023 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbS-0001oT-GX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbO-0001b2-JS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-690d25b1dbdso8086949b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695744476; x=1696349276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBH0tVPhZbmbOybV8egcgofMCCNouLOijsIjx2LZIEQ=;
 b=GTY0gVxKagy3Y05QrP3kYgSrm5bJ69kW+X6ySlY3woDU6O9rXTqdHR2lq1LhL1aAz8
 9uJ24WsDxt+mL/OufLkxpvGrVAiQgcoxcLp6lnE3f+rBvKYTYNoCZJ4J+0QYCvDB9tcL
 gCBtY3OcAQUG2p/baCHmVy0CWC3LzXzVVA7VFPotu8y1K4VMH6ybblIWsPf61VZw5Mj9
 odqlPLutkVzkgIRa4yJtpDwjqsgPlNls84sKTuqz8Bh+quCTGOf8VpAl64I0Qr/8oLRY
 t6y5zv3RgiXBftKSUJiNoyY6uwhgc2JEOdPC/zygQIG0F/AscAxLsMJFx9lMKY6xJcvu
 3g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744476; x=1696349276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBH0tVPhZbmbOybV8egcgofMCCNouLOijsIjx2LZIEQ=;
 b=VuQFwM/J8toeR8BQexddI+ImGBxTv8D3qEq9TLdtJ83MAN/jl41h/kOG8e00nstFhp
 q1ixGl+l80K7ua5C+gJKjF7FoWLR8QLVPCcdZS0zj73VWWAuZTYjGBqVGWXJIfCBrY6n
 9XuOHquX1th6GJaKwlPsOXLFly7MEyDcOx8auseV4U7R2CvoJqM+5oZ5tdB/3aMio9wd
 JxH6s+PQsoBA/lUd8WmAxoI/PksZuTNVAEsH0b8vBdyC+pCOtg2q1TG8osjSTOgVyRt7
 gXP4EQifndnnaRsR/BDszu6rqy9pgtsF5jrQnJNDbUUhPxpwpTQnglpQPJu8YUfeaKtb
 /FnQ==
X-Gm-Message-State: AOJu0YzwYpJgVM9+aswp24LA/nTM5yMzrDToFz9OHNJunRAPwIklSKD0
 QqMHofALhdaAU+N3cVNigGYlOPbfXWhPDg==
X-Google-Smtp-Source: AGHT+IHApYcLAViPWsiejGLal8Za0hDpX4zQkffzMjpIqJfcxhmD8kGC3dh8ANwxG/gUNuUSGbySvQ==
X-Received: by 2002:a17:90a:890a:b0:267:fb26:32bd with SMTP id
 u10-20020a17090a890a00b00267fb2632bdmr8550255pjn.7.1695744475759; 
 Tue, 26 Sep 2023 09:07:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:2173:954b:298f:df36])
 by smtp.googlemail.com with ESMTPSA id
 9-20020a17090a190900b0026fa1931f66sm11158410pjg.9.2023.09.26.09.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:07:55 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v8 1/5] i386/tcg: implement x2APIC registers MSR access
Date: Tue, 26 Sep 2023 23:06:33 +0700
Message-Id: <20230926160637.27995-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926160637.27995-1-minhquangbui99@gmail.com>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
index d3f377d48a..78489378ad 100644
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


