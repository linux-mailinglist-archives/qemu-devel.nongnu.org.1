Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E482B206
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:45:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxEW-0007tx-Rw; Thu, 11 Jan 2024 10:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxER-0007sh-9z
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEO-0007cj-G1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:44:34 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9b2c8e2a4so4671654b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704987870; x=1705592670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4wjzR6CDSS1lRo9YVp8mBAMsaQ9VbgECamnXFmZiy8=;
 b=ZOOO/OjiNEZMI15S0H0a9XVejOzlyQSag6ApBVKMBJ9Qb6R7TlXKXw9Sm/4UFqmgpR
 gDOoePkwcGO947MUga6YY0GO5kJG8h3ZdQgdrjTSpLBbFNQNC5Ss5IDDNVwlw5qquqGD
 pQwnnXhKZdiwHLHzlZpaW0QNMQCZ8KME9z7zco7h7ddAA6E2s5dGRacdySWSOJkseTUI
 n3JYBGm1iwhrwhtyuJNCSv2h0TQ4CmNUWobq/ZzpGVL0um0mibeteI4pNmZibxzQPIKI
 IsSIZO6am5skmMKpaeqmTLvRLVJ51YPhpLCUFKP38sKDWfenW+RUSzT5dOoyaft6OAt/
 JgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987870; x=1705592670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4wjzR6CDSS1lRo9YVp8mBAMsaQ9VbgECamnXFmZiy8=;
 b=ajJWt1IzATmIZcG9bH10YTUolPN0v5yrtyln8AGoh4A38moLqcsK4cQOvFoy4fORYm
 fqHXrqkAyOuj0YpjHl9hJ+viSflV5MKM3HmqJncHMBylYdCKwYBihT0fBWznhh9Xc8fZ
 rrd/s3BackwGmv1ifzmQVjqNFr6+CS7vV/WpB98Ahl7AwwKWd5iQfgLNLIFCSQzfvNh6
 JD56JYsC8WtxfkqV2jGw0JH4XIPfDOFnAzkuAmTcJQepE4q4Cd8+IpgLefmf/uLsY6oY
 Yr0tbdOzHBBlhHq5STVAaIcHcKqNdeS0mqpFFJasARC3KjbOQbJz766tajH8BtHjvgK8
 GteA==
X-Gm-Message-State: AOJu0Yy/KiluJ0tul84Welb6DiFOPfbZ5hzXAQCgQHZvGHihbgdioFgq
 NKwtdnSyRCRLxL4Ngjj/Remp8CDqoNIDi4e1
X-Google-Smtp-Source: AGHT+IFtRWczFwv1zpaZ2sCeDLmupMMhlmbfIDv9SAbx6lzko6TEvGkMYKeMCyU4L8cSlXJgVh2d2g==
X-Received: by 2002:a05:6a21:33a6:b0:199:427d:c208 with SMTP id
 yy38-20020a056a2133a600b00199427dc208mr43883pzb.14.1704987870276; 
 Thu, 11 Jan 2024 07:44:30 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:e868:3e48:c113:4a7f])
 by smtp.googlemail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm1317887pfb.126.2024.01.11.07.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:44:29 -0800 (PST)
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
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v12 1/7] i386/tcg: implement x2APIC registers MSR access
Date: Thu, 11 Jan 2024 22:43:58 +0700
Message-Id: <20240111154404.5333-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111154404.5333-1-minhquangbui99@gmail.com>
References: <20240111154404.5333-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x433.google.com
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

This commit creates apic_register_read/write which are used by both
apic_mem_read/write for MMIO access and apic_msr_read/write for MSR access.

The apic_msr_read/write returns -1 on error, accelerator can use this to
raise the appropriate exception.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/intc/apic.c                       | 122 ++++++++++++++++++++-------
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   3 +
 target/i386/cpu.h                    |   3 +
 target/i386/tcg/sysemu/misc_helper.c |  27 ++++++
 5 files changed, 127 insertions(+), 32 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ac3d47d231..7a349c0723 100644
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
@@ -636,24 +643,19 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+static int apic_register_read(int index, uint64_t *value)
 {
     DeviceState *dev;
     APICCommonState *s;
     uint32_t val;
-    int index;
-
-    if (size < 4) {
-        return 0;
-    }
+    int ret = 0;
 
     dev = cpu_get_current_apic();
     if (!dev) {
-        return 0;
+        return -1;
     }
     s = APIC(dev);
 
-    index = (addr >> 4) & 0xff;
     switch(index) {
     case 0x02: /* id */
         val = s->id << 24;
@@ -718,12 +720,46 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     default:
         s->esr |= APIC_ESR_ILLEGAL_ADDRESS;
         val = 0;
+        ret = -1;
         break;
     }
-    trace_apic_mem_readl(addr, val);
+
+    trace_apic_register_read(index, val);
+    *value = val;
+    return ret;
+}
+
+static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+    int index;
+
+    if (size < 4) {
+        return 0;
+    }
+
+    index = (addr >> 4) & 0xff;
+    apic_register_read(index, &val);
+
     return val;
 }
 
+int apic_msr_read(int index, uint64_t *val)
+{
+    DeviceState *dev;
+
+    dev = cpu_get_current_apic();
+    if (!dev) {
+        return -1;
+    }
+
+    if (!is_x2apic_mode(dev)) {
+        return -1;
+    }
+
+    return apic_register_read(index, val);
+}
+
 static void apic_send_msi(MSIMessage *msi)
 {
     uint64_t addr = msi->address;
@@ -737,35 +773,18 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
-                           unsigned size)
+static int apic_register_write(int index, uint64_t val)
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
-        return;
+        return -1;
     }
     s = APIC(dev);
 
-    trace_apic_mem_writel(addr, val);
+    trace_apic_register_write(index, val);
 
     switch(index) {
     case 0x02:
@@ -839,8 +858,51 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         break;
     default:
         s->esr |= APIC_ESR_ILLEGAL_ADDRESS;
-        break;
+        return -1;
     }
+
+    return 0;
+}
+
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
+        /*
+         * MSI and MMIO APIC are at the same memory location,
+         * but actually not on the global bus: MSI is on PCI bus
+         * APIC is connected directly to the CPU.
+         * Mapping them on the global bus happens to work because
+         * MSI registers are reserved in APIC MMIO and vice versa.
+         */
+        MSIMessage msi = { .address = addr, .data = val };
+        apic_send_msi(&msi);
+        return;
+    }
+
+    apic_register_write(index, val);
+}
+
+int apic_msr_write(int index, uint64_t val)
+{
+    DeviceState *dev;
+
+    dev = cpu_get_current_apic();
+    if (!dev) {
+        return -1;
+    }
+
+    if (!is_x2apic_mode(dev)) {
+        return -1;
+    }
+
+    return apic_register_write(index, val);
 }
 
 static void apic_pre_save(APICCommonState *s)
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
index bdc15a7a73..ddea4213db 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -18,6 +18,9 @@ void apic_sipi(DeviceState *s);
 void apic_poll_irq(DeviceState *d);
 void apic_designate_bsp(DeviceState *d, bool bsp);
 int apic_get_highest_priority_irr(DeviceState *dev);
+int apic_msr_read(int index, uint64_t *val);
+int apic_msr_write(int index, uint64_t val);
+bool is_x2apic_mode(DeviceState *d);
 
 /* pc.c */
 DeviceState *cpu_get_current_apic(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..5138dd9ff2 100644
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
index 1ddfc9fe09..1c43a9f4f7 100644
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
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        bql_lock();
+        ret = apic_msr_write(index, val);
+        bql_unlock();
+        if (ret < 0) {
+            goto error;
+        }
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
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        bql_lock();
+        ret = apic_msr_read(index, &val);
+        bql_unlock();
+        if (ret < 0) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+
+        break;
+    }
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-- 
2.25.1


