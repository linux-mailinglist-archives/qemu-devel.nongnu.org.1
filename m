Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC527423DE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokR-0000GR-Bg; Thu, 29 Jun 2023 06:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokO-0000Fa-Ux
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokN-0005nu-25
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/BPeDEyjtsQ6hPWSKw4UFehpwhBRKieWZPk05sxyLI=;
 b=QEdmVDsDpMOSU5DneI1+6MYFRSbH5hTKKGmOx6SXkRz0sjbNp+0eJ39URnrHW5UWyYY33q
 99DiBrS64lWQxlYVhfNgNpaboGTbgAMa9BH3yj9UgCiQL//G30G7pN9JkfKOuC3GDPvyHL
 c5obF/9R78ZiNlAyskDqefmcAPyjuTQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Bboj_4itOKiousCtBEn9aQ-1; Thu, 29 Jun 2023 06:19:28 -0400
X-MC-Unique: Bboj_4itOKiousCtBEn9aQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9879d2fc970so46661866b.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033967; x=1690625967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/BPeDEyjtsQ6hPWSKw4UFehpwhBRKieWZPk05sxyLI=;
 b=V/mJSezTQeN2TkhQFFDFBVTBgdsL+cmnPP5o1B2+6XlzBSh11gkRx3FNAFWA1N6f/E
 9ki5IQXE7ju+uBSYx4cmKE9BYlfzCaVR7ubjwOnDZ6IPrzcymiOWj+nG/cQ2GxiZ3+4D
 Icb6oPU+znjQdCAsDYxHYPS6py8yJOCB6CmPGGH+Yhcy0rZAjXo9rTpzQQ1lBAmCsc/d
 mhRag/B1oVjiqcki8azMI90LQiLDaQT7qo1Gs7dJtijL0FI0I66dls8PYwyVCix3sSxZ
 9ftmCqRqYUm0fcqDPCzNVpG0i6UAbY+GLKxGz2XN9RTNYsTjoVXEcUXkOI6YmpHcMKuR
 VsZw==
X-Gm-Message-State: AC+VfDwkCCZaddjinscIr9JJqvv8jj0mGFn8J9Os1xpoYJFCh6yTz+6V
 5kzXnvl0liMlrRDeRFgTu7kl/ibx8zplcA8yyCdioaJVSV3PTSZoDWxqVmzmvV12AWcY/8KTcOy
 TPzPXh899TlhiP3w/NPX+iGxPoKePRDlL7uwfPJDRGodyUoIusuBwLhnUMpy4nPv2HOPrxOuEdj
 g=
X-Received: by 2002:a17:906:411b:b0:992:5135:4109 with SMTP id
 j27-20020a170906411b00b0099251354109mr3823933ejk.28.1688033967449; 
 Thu, 29 Jun 2023 03:19:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UayXAlENu0UvUmaVp5fuWVqH2V69w6D4friirODGHt2JteCUKresv9etMGN3DsoBGWNOCSw==
X-Received: by 2002:a17:906:411b:b0:992:5135:4109 with SMTP id
 j27-20020a170906411b00b0099251354109mr3823920ejk.28.1688033967013; 
 Thu, 29 Jun 2023 03:19:27 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 gv18-20020a170906f11200b0098e0a937a6asm6127776ejb.69.2023.06.29.03.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] target/i386: emulate 64-bit ring 0 for linux-user if LM
 feature is set
Date: Thu, 29 Jun 2023 12:19:18 +0200
Message-ID: <20230629101918.9800-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
References: <20230629101918.9800-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index a3ddd1b6137..b5688cabb4f 100644
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


