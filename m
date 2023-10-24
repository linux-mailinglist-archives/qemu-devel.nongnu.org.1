Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6853D7D5624
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJFk-0006CE-1J; Tue, 24 Oct 2023 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJFi-000665-Gp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJFc-0003Ne-Jp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:23:30 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso4437189b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698161003; x=1698765803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKExUEszD7FBKquwk81w9bOjC+YMIl83j5RRiD5clJc=;
 b=IM5ABBfQOEW7NfSi4x3pd125tGu1xIH11yoLGGwllu031vepeQnOemJtXmuq0f/1Z3
 kpWi9OIyqxNZDFcwm1Z3lmwDvk6QIaBcpRuGj9iitrZ7Cdh3AVUAYsz1yCs0woscKrR7
 76zE2jB2DV0ZHfMHB61UJpIqy/m5Llp+AgcBvKBHB/KVph3WldB7qruhF6LkWXbXPMY+
 YpNMt9HA9c7GxLlW+XEsHPFYetYCwou4E/CMoQXGEkJKKJpuVGVL/C4BQxm4bSii89aR
 ke2JPLEW32sYh7cWnNbuNi5xpwLtFZzbDzQwILMCWzqpjElakwecSRRwcLKFLniofoTS
 Gb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698161003; x=1698765803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKExUEszD7FBKquwk81w9bOjC+YMIl83j5RRiD5clJc=;
 b=RgiOogkr4E+a+FVNjz0h+AlLQH86GHMd2oXZ2Ucr657XBiwJae2T3X7xaw53o8MgwW
 uaeyxtLfqnDIcZlhFEHG6dPZ+QlkGxoZosalm/32p/KNDcsvv6Gw9SXNZHg4yUq3kKEK
 3HWpBV3uWN9O179R2rLOkPuil1g1b59NLIHDGTJPAe6AGHo4gXIp//J9/gqH3aAvuhlF
 xoV6gD/zh2IJrPDbxzzf3LUYOuHTTr8eO+FZwDps6iduH/xVEkb5oVzk68TKmmTUB6xK
 vQ18pcCodC4rLxpGZdYqSU7ozUvQEl3ekgk+6CzBjzmE23KmCqUfRUb4qBsRUzFdAvfU
 7KGQ==
X-Gm-Message-State: AOJu0Yz4WedIui4ziSRP8TYF2lkSs6S+0ORWBFvs5QF3NqJqI8H17Upn
 bTkaE7ReMJo61qoVpG70eT67pCHpMapLZA==
X-Google-Smtp-Source: AGHT+IEJJF2eBDojMduaTFQLkPjYDazPXm+8P/cy/pm66Sq5tj6nwq4Zr0wbMSNdm/AVdU0Idz34+w==
X-Received: by 2002:a05:6a00:24d1:b0:6be:2720:16a5 with SMTP id
 d17-20020a056a0024d100b006be272016a5mr15979796pfv.33.1698161002693; 
 Tue, 24 Oct 2023 08:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:647f:b391:99d7:635d])
 by smtp.googlemail.com with ESMTPSA id
 t29-20020a63445d000000b005ab46970aaasm7196180pgk.17.2023.10.24.08.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:23:22 -0700 (PDT)
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
Subject: [PATCH v9 3/5] apic, i386/tcg: add x2apic transitions
Date: Tue, 24 Oct 2023 22:21:03 +0700
Message-Id: <20231024152105.35942-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024152105.35942-1-minhquangbui99@gmail.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42f.google.com
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

This commit adds support for x2APIC transitions when writing to
MSR_IA32_APICBASE register and finally adds CPUID_EXT_X2APIC to
TCG_EXT_FEATURES.

The set_base in APICCommonClass now returns an integer to indicate error in
execution. apic_set_base return -1 on invalid APIC state transition,
accelerator can use this to raise appropriate exception.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/kvm/apic.c                   |  3 +-
 hw/i386/xen/xen_apic.c               |  3 +-
 hw/intc/apic.c                       | 62 +++++++++++++++++++++++++++-
 hw/intc/apic_common.c                | 13 +++---
 include/hw/i386/apic.h               |  2 +-
 include/hw/i386/apic_internal.h      |  2 +-
 target/i386/cpu.c                    |  9 ++--
 target/i386/cpu.h                    |  4 ++
 target/i386/tcg/sysemu/misc_helper.c | 14 ++++++-
 target/i386/whpx/whpx-apic.c         |  3 +-
 10 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1e89ca0899..a72c28e8a7 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -95,9 +95,10 @@ void kvm_get_apic_state(DeviceState *dev, struct kvm_lapic_state *kapic)
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static void kvm_apic_set_base(APICCommonState *s, uint64_t val)
+static int kvm_apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = val;
+    return 0;
 }
 
 static void kvm_apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 7c7a60b166..101e16a766 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -49,8 +49,9 @@ static void xen_apic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static void xen_apic_set_base(APICCommonState *s, uint64_t val)
+static int xen_apic_set_base(APICCommonState *s, uint64_t val)
 {
+    return 0;
 }
 
 static void xen_apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 84d428a875..f9e54d92b3 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -308,8 +308,49 @@ bool is_x2apic_mode(DeviceState *dev)
     return s->apicbase & MSR_IA32_APICBASE_EXTD;
 }
 
-static void apic_set_base(APICCommonState *s, uint64_t val)
+static int apic_set_base_check(APICCommonState *s, uint64_t val)
 {
+    /* Enable x2apic when x2apic is not supported by CPU */
+    if (!cpu_has_x2apic_feature(&s->cpu->env) &&
+        val & MSR_IA32_APICBASE_EXTD) {
+        return -1;
+    }
+
+    /*
+     * Transition into invalid state
+     * (s->apicbase & MSR_IA32_APICBASE_ENABLE == 0) &&
+     * (s->apicbase & MSR_IA32_APICBASE_EXTD) == 1
+     */
+    if (!(val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from disabled mode to x2APIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from x2APIC to xAPIC */
+    if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        !(val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int apic_set_base(APICCommonState *s, uint64_t val)
+{
+    if (apic_set_base_check(s, val) < 0) {
+        return -1;
+    }
+
     s->apicbase = (val & 0xfffff000) |
         (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
     /* if disabled, cannot be enabled again */
@@ -318,6 +359,25 @@ static void apic_set_base(APICCommonState *s, uint64_t val)
         cpu_clear_apic_feature(&s->cpu->env);
         s->spurious_vec &= ~APIC_SV_ENABLE;
     }
+
+    /* Transition from disabled mode to xAPIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase |= MSR_IA32_APICBASE_ENABLE;
+        cpu_set_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from xAPIC to x2APIC */
+    if (cpu_has_x2apic_feature(&s->cpu->env) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        s->apicbase |= MSR_IA32_APICBASE_EXTD;
+
+        s->log_dest = ((s->initial_apic_id & 0xffff0) << 16) |
+                      (1 << (s->initial_apic_id & 0xf));
+    }
+
+    return 0;
 }
 
 static void apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 4bc3d2f149..b13a7b0457 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -35,20 +35,19 @@
 
 bool apic_report_tpr_access;
 
-void cpu_set_apic_base(DeviceState *dev, uint64_t val)
+int cpu_set_apic_base(DeviceState *dev, uint64_t val)
 {
     trace_cpu_set_apic_base(val);
 
     if (dev) {
         APICCommonState *s = APIC_COMMON(dev);
         APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-        /* switching to x2APIC, reset possibly modified xAPIC ID */
-        if (!(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
-            (val & MSR_IA32_APICBASE_EXTD)) {
-            s->id = s->initial_apic_id;
-        }
-        info->set_base(s, val);
+        /* Reset possibly modified xAPIC ID */
+        s->id = s->initial_apic_id;
+        return info->set_base(s, val);
     }
+
+    return 0;
 }
 
 uint64_t cpu_get_apic_base(DeviceState *dev)
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index c8ca41ab44..f6e7489f2d 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -8,7 +8,7 @@ int apic_accept_pic_intr(DeviceState *s);
 void apic_deliver_pic_intr(DeviceState *s, int level);
 void apic_deliver_nmi(DeviceState *d);
 int apic_get_interrupt(DeviceState *s);
-void cpu_set_apic_base(DeviceState *s, uint64_t val);
+int cpu_set_apic_base(DeviceState *s, uint64_t val);
 uint64_t cpu_get_apic_base(DeviceState *s);
 void cpu_set_apic_tpr(DeviceState *s, uint8_t val);
 uint8_t cpu_get_apic_tpr(DeviceState *s);
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index e796e6cae3..d6e85833da 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -137,7 +137,7 @@ struct APICCommonClass {
 
     DeviceRealize realize;
     DeviceUnrealize unrealize;
-    void (*set_base)(APICCommonState *s, uint64_t val);
+    int (*set_base)(APICCommonState *s, uint64_t val);
     void (*set_tpr)(APICCommonState *s, uint8_t val);
     uint8_t (*get_tpr)(APICCommonState *s);
     void (*enable_tpr_reporting)(APICCommonState *s, bool enable);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bdca901dfa..ee78186550 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -631,8 +631,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
  * in CPL=3; remove them if they are ever implemented for system emulation.
  */
 #if defined CONFIG_USER_ONLY
-#define CPUID_EXT_KERNEL_FEATURES (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER | \
-                                 CPUID_EXT_X2APIC)
+#define CPUID_EXT_KERNEL_FEATURES \
+          (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER)
 #else
 #define CPUID_EXT_KERNEL_FEATURES 0
 #endif
@@ -642,12 +642,13 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
           CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
           CPUID_EXT_RDRAND | CPUID_EXT_AVX | CPUID_EXT_F16C | \
-          CPUID_EXT_FMA | CPUID_EXT_KERNEL_FEATURES)
+          CPUID_EXT_FMA | CPUID_EXT_X2APIC | CPUID_EXT_KERNEL_FEATURES)
           /* missing:
           CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
           CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID,
           CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
-          CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
+          CPUID_EXT_TSC_DEADLINE_TIMER
+          */
 
 #ifdef TARGET_X86_64
 #define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 32a16453d0..9f0d690bfc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -379,6 +379,10 @@ typedef enum X86Seg {
 #define MSR_IA32_APICBASE_ENABLE        (1<<11)
 #define MSR_IA32_APICBASE_EXTD          (1 << 10)
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
+#define MSR_IA32_APICBASE_RESERVED \
+        (~(uint64_t)(MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE \
+                     | MSR_IA32_APICBASE_EXTD | MSR_IA32_APICBASE_BASE))
+
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 6fccdb3dca..29260d657d 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -158,9 +158,19 @@ void helper_wrmsr(CPUX86State *env)
     case MSR_IA32_SYSENTER_EIP:
         env->sysenter_eip = val;
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(env_archcpu(env)->apic_state, val);
+    case MSR_IA32_APICBASE: {
+        int ret;
+
+        if (val & MSR_IA32_APICBASE_RESERVED) {
+            goto error;
+        }
+
+        ret = cpu_set_apic_base(env_archcpu(env)->apic_state, val);
+        if (ret < 0) {
+            goto error;
+        }
         break;
+    }
     case MSR_EFER:
         {
             uint64_t update_mask;
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 8710e37567..7e14ded978 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -90,9 +90,10 @@ static void whpx_get_apic_state(APICCommonState *s,
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static void whpx_apic_set_base(APICCommonState *s, uint64_t val)
+static int whpx_apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = val;
+    return 0;
 }
 
 static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
-- 
2.25.1


