Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96E70C386
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q18TQ-0008DQ-5i; Mon, 22 May 2023 12:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18TB-000885-RI
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:33:15 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18T9-0007AH-Ja
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:33:13 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-534696e4e0aso3511432a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684773189; x=1687365189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVTOrBxISbqEa0WbSAV+Kw/4P+ObiCwxXoia+9qg46U=;
 b=OLjZMh83o2cTz0aMxDFLfqQA4Ib0TaRCwhg82G2et5O+7UYEBqABBi+CK5hVaF3p4L
 ygQrFP7gfw2L1gr3Rc7kUOLqra5hHLYpN4uPVII5kn9jo7k/SLz94KXi9e/OP5QEGbxI
 qxrj+GpTyU7wmdbRWvjnz9I52i6xQg19bX1navo9NXDadcuviFroRdQW6qxrpga5NYjQ
 9ZDbyGeKJxMqELI/sOHiJXz0U5PyVKTzE2igUx9vkdvT81tumTBch/boaVCIQI0q3Ogd
 0As1lR58wPYHk4kJDuOpDvPj9RxqLtwdGA5EPvCFQSezhWleP7puZj20CrRDtH8dCDhd
 45JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684773189; x=1687365189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVTOrBxISbqEa0WbSAV+Kw/4P+ObiCwxXoia+9qg46U=;
 b=GzPnKsJrA8mHd3JrECxp5lJYBhSFj1JaE6FNHeu7VkWzaAjHMZhRgfh1pCSmeHgSaH
 wmn7hNdoBnL4VQLtzwhD8PJhRCwjNXNjme0VRRn0V8Vc7IVRjGfPERKjs8k4rnsXxysy
 uFWw/1Jlo8kdbmlhmnC0p6xwhGr7WbZ1D84nH6c0vuWNZUwlCw2KJo0KGizIjSFzGpCA
 Yc+Jve9ANBXhGDseo5QkEQck/geYyvI2/1yr1873Bg9xhWLQGoxnMEUVLrN/U7crOlei
 97mIi2UunLB+/O2I/pmJ5yyLDf6RMS6f4PpD/SvYoXVXHdb5dX17JjHaYVGrACtZsadM
 Rt8w==
X-Gm-Message-State: AC+VfDx6tNb2B6IUW8hWjgLVotGwxJcEzr0jjL7U2+qpNZ7z7GZqnCik
 eOtPfa/p08Djq9Ax0IEkrpSV6mUir9oSKg==
X-Google-Smtp-Source: ACHHUZ4pDE418hUj5ZfBEtop9Qz6vD1AJQKhgLFcniLkcvFWtM7ahalJpHPyo8euiagQFmL1lkr5xg==
X-Received: by 2002:a17:90b:3b4a:b0:24d:fcae:d455 with SMTP id
 ot10-20020a17090b3b4a00b0024dfcaed455mr10637414pjb.41.1684773188599; 
 Mon, 22 May 2023 09:33:08 -0700 (PDT)
Received: from localhost.localdomain ([113.173.119.15])
 by smtp.googlemail.com with ESMTPSA id
 s5-20020a17090a2f0500b0025393752cd5sm12293253pjd.1.2023.05.22.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 09:33:08 -0700 (PDT)
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
Subject: [PATCH v4 3/5] apic, i386/tcg: add x2apic transitions
Date: Mon, 22 May 2023 23:31:55 +0700
Message-Id: <20230522163157.9754-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522163157.9754-1-minhquangbui99@gmail.com>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pg1-x529.google.com
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

This commit adds support for x2APIC transitions when writing to
MSR_IA32_APICBASE register and finally adds CPUID_EXT_X2APIC to
TCG_EXT_FEATURES.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/intc/apic.c                       | 50 ++++++++++++++++++++++++++++
 hw/intc/apic_common.c                |  7 ++--
 target/i386/cpu-sysemu.c             | 10 ++++++
 target/i386/cpu.c                    |  5 +--
 target/i386/cpu.h                    |  6 ++++
 target/i386/tcg/sysemu/misc_helper.c |  4 +++
 6 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 9f741794a7..b8f56836a6 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -309,8 +309,41 @@ bool is_x2apic_mode(DeviceState *dev)
     return s->apicbase & MSR_IA32_APICBASE_EXTD;
 }
 
+static void apic_set_base_check(APICCommonState *s, uint64_t val)
+{
+    /* Enable x2apic when x2apic is not supported by CPU */
+    if (!cpu_has_x2apic_feature(&s->cpu->env) &&
+        val & MSR_IA32_APICBASE_EXTD)
+        raise_exception_ra(&s->cpu->env, EXCP0D_GPF, GETPC());
+
+    /*
+     * Transition into invalid state
+     * (s->apicbase & MSR_IA32_APICBASE_ENABLE == 0) &&
+     * (s->apicbase & MSR_IA32_APICBASE_EXTD) == 1
+     */
+    if (!(val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD))
+        raise_exception_ra(&s->cpu->env, EXCP0D_GPF, GETPC());
+
+    /* Invalid transition from disabled mode to x2APIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD))
+        raise_exception_ra(&s->cpu->env, EXCP0D_GPF, GETPC());
+
+    /* Invalid transition from x2APIC to xAPIC */
+    if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        !(val & MSR_IA32_APICBASE_EXTD))
+        raise_exception_ra(&s->cpu->env, EXCP0D_GPF, GETPC());
+}
+
 static void apic_set_base(APICCommonState *s, uint64_t val)
 {
+    apic_set_base_check(s, val);
+
     s->apicbase = (val & 0xfffff000) |
         (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
     /* if disabled, cannot be enabled again */
@@ -319,6 +352,23 @@ static void apic_set_base(APICCommonState *s, uint64_t val)
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
 }
 
 static void apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d95914066e..396f828be8 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -43,11 +43,8 @@ void cpu_set_apic_base(DeviceState *dev, uint64_t val)
     if (dev) {
         APICCommonState *s = APIC_COMMON(dev);
         APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-        /* switching to x2APIC, reset possibly modified xAPIC ID */
-        if (!(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
-            (val & MSR_IA32_APICBASE_EXTD)) {
-            s->id = s->initial_apic_id;
-        }
+        /* Reset possibly modified xAPIC ID */
+        s->id = s->initial_apic_id;
         info->set_base(s, val);
     }
 }
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index a9ff10c517..f6bbe33372 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -235,6 +235,16 @@ void cpu_clear_apic_feature(CPUX86State *env)
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
 }
 
+void cpu_set_apic_feature(CPUX86State *env)
+{
+    env->features[FEAT_1_EDX] |= CPUID_APIC;
+}
+
+bool cpu_has_x2apic_feature(CPUX86State *env)
+{
+    return env->features[FEAT_1_ECX] & CPUID_EXT_X2APIC;
+}
+
 bool cpu_is_bsp(X86CPU *cpu)
 {
     return cpu_get_apic_base(cpu->apic_state) & MSR_IA32_APICBASE_BSP;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a61cd6d99d..a426d0f7f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -629,12 +629,13 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
           CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
           CPUID_EXT_RDRAND | CPUID_EXT_AVX | CPUID_EXT_F16C | \
-          CPUID_EXT_FMA)
+          CPUID_EXT_FMA | CPUID_EXT_X2APIC)
           /* missing:
           CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
           CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID,
           CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
-          CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
+          CPUID_EXT_TSC_DEADLINE_TIMER
+          */
 
 #ifdef TARGET_X86_64
 #define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d1a1ce25f4..77a60ad140 100644
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
@@ -2190,8 +2194,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx);
 void cpu_clear_apic_feature(CPUX86State *env);
+void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
+bool cpu_has_x2apic_feature(CPUX86State *env);
 
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 1fce2076a3..91a58d4d97 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -159,6 +159,10 @@ void helper_wrmsr(CPUX86State *env)
         env->sysenter_eip = val;
         break;
     case MSR_IA32_APICBASE:
+        if (val & MSR_IA32_APICBASE_RESERVED) {
+            goto error;
+        }
+
         cpu_set_apic_base(env_archcpu(env)->apic_state, val);
         break;
     case MSR_EFER:
-- 
2.25.1


