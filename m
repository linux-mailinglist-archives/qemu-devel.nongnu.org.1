Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC337AF04C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAbi-0001qI-9b; Tue, 26 Sep 2023 12:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbg-0001q8-Jc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbe-0001cl-KC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:08:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso63926595ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695744491; x=1696349291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lI8vxm59IUUB9GNslRhQ6XHVIUlyHOGXSGh0HhgWPlk=;
 b=ZgpouUcZ+MBRejY7CQmnWjszRko/1u33o/Bo1g+prx6rvZkKuKbY+vNF3jz10MbRzD
 ajZAoili0wMrAMk4a4ML3Y02ESt+n8Vz7PZN/AfaWFjPRL60kbJu8twCO7xF7XfDdDbW
 VDGJy2zzki35ftvX2zOCiMkN3/QLBJKIEPIplmzmxGx2j3vQ1JC55/2G2m7k5TKS7UrX
 4wx/jyIRS7ZyH5WPOw2jT6vIM6VvQpREI0fcZCTE34psu12ATFK7gfBhYWetm4hquT0N
 FtWyOr9R4blk/i2SHUnGVeDP/1dvVGKBxe1OTG/wCn1p9PAxBcElBsTMXW2bCDn0H//n
 8/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744491; x=1696349291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lI8vxm59IUUB9GNslRhQ6XHVIUlyHOGXSGh0HhgWPlk=;
 b=acuvB3WAFGhNj7CqhWF7FXQ/aiko+L8imDgw8Wj2RVTeQ4kB1UhtKK5Rl0aNcI8afy
 vfiO7TAK6xizEb+9+v7mkMnINASAPGnmqeGZN9TELR4VcLqAKGwK7/u+jki4AMNC6i/M
 efxov9PhUYRmGY0Npg2LBA9tdqLuKKJRRa+AaoQ/1QerVsfr4sh4ZDkN/VAlzOBrqZcL
 zDTgNztnmEkA4Uk4CoXxmvEFQ48sg61AuRW67jnZBnT3UZZcUTiVRZqK49pw3evfYEqf
 RD6YTlLhKB9ekNLkxn15GpTx6WjtKazApPVeOR5txNobsiDQ1eMsIkfCdEuOYLAC2seN
 UGWA==
X-Gm-Message-State: AOJu0Yzvf2WAQwRqOZrJz9mIlBz69dsrGqzMoAYjUVf5J5mWVbsi6LkS
 6OctMnbgZ7KHGFy5R/I47ScnjCq77GuXiw==
X-Google-Smtp-Source: AGHT+IHTRtvHv9b/oq5weRU8Z3XCcPH0H5n759CnuCCTimlFk78J2Hh7c+fPWhhjv/TgoUKYR1hpjA==
X-Received: by 2002:a17:902:6944:b0:1bd:fa80:103d with SMTP id
 k4-20020a170902694400b001bdfa80103dmr7123890plt.25.1695744491426; 
 Tue, 26 Sep 2023 09:08:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:2173:954b:298f:df36])
 by smtp.googlemail.com with ESMTPSA id
 9-20020a17090a190900b0026fa1931f66sm11158410pjg.9.2023.09.26.09.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:08:10 -0700 (PDT)
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
Subject: [PATCH v8 3/5] apic, i386/tcg: add x2apic transitions
Date: Tue, 26 Sep 2023 23:06:35 +0700
Message-Id: <20230926160637.27995-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926160637.27995-1-minhquangbui99@gmail.com>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/intc/apic.c                       | 50 ++++++++++++++++++++++++++++
 hw/intc/apic_common.c                |  7 ++--
 target/i386/cpu-sysemu.c             | 10 ++++++
 target/i386/cpu.c                    |  8 ++---
 target/i386/cpu.h                    |  6 ++++
 target/i386/tcg/sysemu/misc_helper.c |  4 +++
 6 files changed, 76 insertions(+), 9 deletions(-)

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
index ac8ec00eef..c6b10af88f 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -42,11 +42,8 @@ void cpu_set_apic_base(DeviceState *dev, uint64_t val)
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
index 0e0f8cf8ad..7422096737 100644
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
index 7836aa6692..1c6e0dc2f3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -630,8 +630,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
  * in CPL=3; remove them if they are ever implemented for system emulation.
  */
 #if defined CONFIG_USER_ONLY
-#define CPUID_EXT_KERNEL_FEATURES (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER | \
-                                 CPUID_EXT_X2APIC)
+#define CPUID_EXT_KERNEL_FEATURES (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER)
 #else
 #define CPUID_EXT_KERNEL_FEATURES 0
 #endif
@@ -641,12 +640,13 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
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
index 78489378ad..270e320704 100644
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
@@ -2202,8 +2206,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


