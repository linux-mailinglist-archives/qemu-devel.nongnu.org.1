Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315373D9E0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhfN-0005Kq-LJ; Mon, 26 Jun 2023 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhfB-0005Jg-6G
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhf5-0005iM-8n
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSEByrAfUGAY0DAdQIbJpEEfvbQiHhZixZUpqPmdQCQ=;
 b=dd/bTHSaC4dNbrEEbvhNLel+oqVZZJHSHwGaYFUbEseGxiaNYgy5UJfYZpi+MnsACjA8sO
 ncvOMSfWjIi/APWVjTQRfrGuZnUWjrH2tMPUpfdfg9uk+ghcTfvv7fxM1KVWly9sWJCf4J
 q6Dq7zzepkVbAwVID0tIgDwhxKJzmes=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-AyZlejoqPsC4b5mhBoZQYA-1; Mon, 26 Jun 2023 04:33:24 -0400
X-MC-Unique: AyZlejoqPsC4b5mhBoZQYA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31286355338so1772849f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768403; x=1690360403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSEByrAfUGAY0DAdQIbJpEEfvbQiHhZixZUpqPmdQCQ=;
 b=J4qe/dzA2stdiE1cUQQokBAbSHetqovrL3Tri1Hj8jxysqTgEEA3jnK9lUjxKklgwa
 gIcTa5Ur0GC6+CPBLrz+NwEosfQ3k7DIrVa1eUvTmuD+2pOoPyIK76fl5kMYkj6qlnhK
 ERmOaAPYm8yGv+dHWq5aGydoW+GT+5KTDjuO/rsmv4foZ4um77tVA9QlfwOYkP0mswiU
 2SEDWRHuf9e/tXT+e0wnuGpCh4UiZs5Z6YZnrWiZxQKnTVGe38lxPBql7sWf/pzIgrkF
 +pWXQlUVRtyg0PxSPjIHXyOg3BsD8kGdqdo4nDscY2dEZCw0ZtE4P28jyCKN7301qxg5
 QYwQ==
X-Gm-Message-State: AC+VfDwcYR0ZAD7LS95/sCkP6CS2gfggcFrx06d/+QFeHsDqj//54kAj
 1w7ZEodQltvNYstUG2vw8U//mhAT5GhSIX3pfP15FvMWfqilK8Dwj5RrOj2v8xN8fy7y3t7SwFe
 UmcP9VGIb0u2YO08pcx1d3AR2r0lr/e/Jo464Gi5SURCiciVbzAcWIwKqoS/w3wfkBwKkGsM8Yo
 M=
X-Received: by 2002:a5d:58d8:0:b0:313:e2a2:fc80 with SMTP id
 o24-20020a5d58d8000000b00313e2a2fc80mr4852226wrf.33.1687768403124; 
 Mon, 26 Jun 2023 01:33:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MThEgTN+X/tmN30SU5YWl4j+RXnVmFx5Q7jWDSE+CaDqZgGuXASOPLPm1CcxJWpWfpkmsJg==
X-Received: by 2002:a5d:58d8:0:b0:313:e2a2:fc80 with SMTP id
 o24-20020a5d58d8000000b00313e2a2fc80mr4852208wrf.33.1687768402535; 
 Mon, 26 Jun 2023 01:33:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a5d522d000000b003119633ecb5sm6655508wra.88.2023.06.26.01.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 01:33:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/i386: emulate 64-bit ring 0 for linux-user if
 LM feature is set
Date: Mon, 26 Jun 2023 10:33:17 +0200
Message-ID: <20230626083317.144746-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626083317.144746-1-pbonzini@redhat.com>
References: <20230626083317.144746-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

32-bit binaries can run on a long mode processor even if the kernel
is 64-bit, of course, and this can have slightly different behavior;
for example, SYSCALL is allowed on Intel processors.

Allow reporting LM to programs running under user mode emulation,
so that "-cpu" can be used with named CPU models even for qemu-i386
and even without disabling LM by hand.

Fortunately, most of the runtime code in QEMU has to depend on HF_LMA_MASK
or on HF_CS64_MASK (which is anyway false for qemu-i386's 32-bit code
segment) rather than TARGET_X86_64, therefore all that is needed is an
update of linux-user's ring 0 setup.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1534
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/i386/cpu_loop.c  | 57 ++++++++++++++++++-------------------
 target/i386/cpu.c           | 15 ++++++++--
 target/i386/tcg/translate.c |  6 ++--
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 9eeda551eaf..ef2dcb3d767 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -47,7 +47,7 @@ static void write_dt(void *ptr, unsigned long addr, unsigned long limit,
 }
 
 static uint64_t *idt_table;
-#ifdef TARGET_X86_64
+
 static void set_gate64(void *ptr, unsigned int type, unsigned int dpl,
                        uint64_t addr, unsigned int sel)
 {
@@ -60,8 +60,10 @@ static void set_gate64(void *ptr, unsigned int type, unsigned int dpl,
     p[2] = tswap32(addr >> 32);
     p[3] = 0;
 }
+
+#ifdef TARGET_X86_64
 /* only dpl matters as we do only user space emulation */
-static void set_idt(int n, unsigned int dpl)
+static void set_idt(int n, unsigned int dpl, bool is64)
 {
     set_gate64(idt_table + n * 2, 0, dpl, 0, 0);
 }
@@ -78,9 +80,13 @@ static void set_gate(void *ptr, unsigned int type, unsigned int dpl,
 }
 
 /* only dpl matters as we do only user space emulation */
-static void set_idt(int n, unsigned int dpl)
+static void set_idt(int n, unsigned int dpl, bool is64)
 {
-    set_gate(idt_table + n, 0, dpl, 0, 0);
+    if (is64) {
+        set_gate64(idt_table + n * 2, 0, dpl, 0, 0);
+    } else {
+        set_gate(idt_table + n, 0, dpl, 0, 0);
+    }
 }
 #endif
 
@@ -325,6 +331,9 @@ static void target_cpu_free(void *obj)
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
     CPUState *cpu = env_cpu(env);
+    bool is64 = (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) != 0;
+    int i;
+
     OBJECT(cpu)->free = target_cpu_free;
     env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
     env->hflags |= HF_PE_MASK | HF_CPL_MASK;
@@ -332,15 +341,18 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
         env->cr[4] |= CR4_OSFXSR_MASK;
         env->hflags |= HF_OSFXSR_MASK;
     }
-#ifndef TARGET_ABI32
+
     /* enable 64 bit mode if possible */
-    if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
+    if (is64) {
+        env->cr[4] |= CR4_PAE_MASK;
+        env->efer |= MSR_EFER_LMA | MSR_EFER_LME;
+        env->hflags |= HF_LMA_MASK;
+    }
+#ifndef TARGET_ABI32
+    else {
         fprintf(stderr, "The selected x86 CPU does not support 64 bit mode\n");
         exit(EXIT_FAILURE);
     }
-    env->cr[4] |= CR4_PAE_MASK;
-    env->efer |= MSR_EFER_LMA | MSR_EFER_LME;
-    env->hflags |= HF_LMA_MASK;
 #endif
 
     /* flags setup : we activate the IRQs by default as in user mode */
@@ -379,27 +391,12 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
                                 PROT_READ|PROT_WRITE,
                                 MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
     idt_table = g2h_untagged(env->idt.base);
-    set_idt(0, 0);
-    set_idt(1, 0);
-    set_idt(2, 0);
-    set_idt(3, 3);
-    set_idt(4, 3);
-    set_idt(5, 0);
-    set_idt(6, 0);
-    set_idt(7, 0);
-    set_idt(8, 0);
-    set_idt(9, 0);
-    set_idt(10, 0);
-    set_idt(11, 0);
-    set_idt(12, 0);
-    set_idt(13, 0);
-    set_idt(14, 0);
-    set_idt(15, 0);
-    set_idt(16, 0);
-    set_idt(17, 0);
-    set_idt(18, 0);
-    set_idt(19, 0);
-    set_idt(0x80, 3);
+    for (i = 0; i < 20; i++) {
+        set_idt(i, 0, is64);
+    }
+    set_idt(3, 3, is64);
+    set_idt(4, 3, is64);
+    set_idt(0x80, 3, is64);
 
     /* linux segment setup */
     {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69a1f2f805b..958878f6064 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -666,7 +666,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
  * and therefore using the 32-bit ABI; the CPU itself might be 64-bit
  * but again the difference is only visible in kernel mode.
  */
-#if defined CONFIG_USER_ONLY
+#if defined CONFIG_LINUX_USER
+#define CPUID_EXT2_KERNEL_FEATURES (CPUID_EXT2_LM | CPUID_EXT2_FFXSR)
+#elif defined CONFIG_USER_ONLY
+/* FIXME: Long mode not yet supported for i386 bsd-user */
 #define CPUID_EXT2_KERNEL_FEATURES CPUID_EXT2_FFXSR
 #else
 #define CPUID_EXT2_KERNEL_FEATURES 0
@@ -5539,7 +5542,15 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
     }
 #ifndef TARGET_X86_64
     if (w == FEAT_8000_0001_EDX) {
-        r &= ~CPUID_EXT2_LM;
+        /*
+         * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
+         * way for userspace to get out of its 32-bit jail, we can leave
+         * the LM bit set.
+         */
+        uint32_t unavail = tcg_enabled()
+            ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
+            : CPUID_EXT2_LM;
+        r &= ~unavail;
     }
 #endif
     if (migratable_only) {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 28cb3fb7f4b..90c7b32f362 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -173,12 +173,14 @@ typedef struct DisasContext {
 #endif
 #if !defined(TARGET_X86_64)
 #define CODE64(S) false
-#define LMA(S)    false
 #elif defined(CONFIG_USER_ONLY)
 #define CODE64(S) true
-#define LMA(S)    true
 #else
 #define CODE64(S) (((S)->flags & HF_CS64_MASK) != 0)
+#endif
+#if defined(CONFIG_SOFTMMU) && !defined(TARGET_X86_64)
+#define LMA(S)    false
+#else
 #define LMA(S)    (((S)->flags & HF_LMA_MASK) != 0)
 #endif
 
-- 
2.41.0


