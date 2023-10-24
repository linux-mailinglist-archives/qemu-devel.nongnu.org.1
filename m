Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247A7D561E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJFO-0004JK-Tn; Tue, 24 Oct 2023 11:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJFG-0003ux-Pp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:03 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJF9-0003I3-Lw
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:01 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-581de3e691dso2662347eaf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698160974; x=1698765774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBR0uBSpgwOEwK7ZEmKJ/LcQGidZO3rz919DKoxrp88=;
 b=R2aJIqvFIng7NFh//Yj5YSbXhm9nVgsFWJdu29m3y7SMMdEnx6bsu9kLb4VZRE3UNc
 V4UQA/KEAKTkcGu2S2zC74zCVmzwcpcnjYtpkqEZw/kE3hQvDxoTQraRNIZ1BgGHQei6
 7MrH6DjJt8ztLEH7HTDeQq0qjZxlBmypRFW968Pc8mC95Am3UtepRoXLMoxVLQVDlyeT
 dEpeyeC0QMn3hlLLhSLC7Kc2Xb7laDrkucq80mgedowWCtBQix6hvmkutQct5yV5NnQR
 UgFBHBTmNtTHLnMUsmfHlRtccoTAW5825+xjYteXH1f5kGx8mEpWDVBx+GReg49MEsLX
 CWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698160974; x=1698765774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBR0uBSpgwOEwK7ZEmKJ/LcQGidZO3rz919DKoxrp88=;
 b=e9AskceFNzPmhZ1rEMlePfToY46loAfVQaW2HE62mB3S3JiSyddc4LBiZRZVZ4/6Io
 GWsxlF3GSYPgiss0CEkV8M+WXhwCYWJL9r+aypMUz7k0ofdEAe2eYmBnspOKR6X1V7tU
 xZura61EyfgYghhlcwNHNaHQnh281nBsifVTk3Oj190B4FBuCIwAOJ3XL6K1wjYQqsAZ
 oMAn2zHxRbTrYeNfUP03xJP3CFTPPqGLzFWhAXQLPQQZ9MDBBLoJddYwQHVgSKAo/wHy
 Kd9OtF5qfjsWyrkBS9MNvqG2b6XIYz08JmWYBUfQD7+0muOKsdrrHYivk1dAeuwfZGPq
 zaPw==
X-Gm-Message-State: AOJu0YyD0fEp3XU6OkzQTwY4eHwjDnNnpFJtN8BWJiL8+7+w/WDwaFoK
 n42TbzCeUde3f4//qWFva6r9Op9a8iqQaQ==
X-Google-Smtp-Source: AGHT+IHNDcR9BIDdTPguOyLxRx77UO80Vt2Z33EzYe5GiD53aBQB7Lzte9vyQXhsnE3ik0dDYnQRmA==
X-Received: by 2002:a05:6358:7295:b0:168:cdee:155e with SMTP id
 w21-20020a056358729500b00168cdee155emr9380966rwf.3.1698160974044; 
 Tue, 24 Oct 2023 08:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:647f:b391:99d7:635d])
 by smtp.googlemail.com with ESMTPSA id
 t29-20020a63445d000000b005ab46970aaasm7196180pgk.17.2023.10.24.08.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:22:52 -0700 (PDT)
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
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v9 1/5] i386/tcg: implement x2APIC registers MSR access
Date: Tue, 24 Oct 2023 22:21:01 +0700
Message-Id: <20231024152105.35942-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024152105.35942-1-minhquangbui99@gmail.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oo1-xc35.google.com
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
index 471e71dbc5..92d0cf528c 100644
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
index e1528b7f80..6fccdb3dca 100644
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
+        qemu_mutex_lock_iothread();
+        ret = apic_msr_write(index, val);
+        qemu_mutex_unlock_iothread();
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
+        qemu_mutex_lock_iothread();
+        ret = apic_msr_read(index, &val);
+        qemu_mutex_unlock_iothread();
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


