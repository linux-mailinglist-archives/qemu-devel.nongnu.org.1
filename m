Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F381CE3F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:01:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjol-0001xG-IE; Fri, 22 Dec 2023 13:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoj-0001vk-MV
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoe-0004BJ-6h
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTiSU/rkllP5B8KDi/rXfGwcVGdKreTkW03nmSyR0OM=;
 b=JfYDZfwNUM4UuYkM2YX7emJjqZyd9W3L6Xf3s1LH46t3lwIZFcFH6hXykagvLkXgun9DQF
 4aMaFI2r8DFxGL3wx9hQ7luAW1I3zCB2gPbi4Gi8ndG4tZ2T6Rso0ytNE0M+bDuoWL03if
 XnIpyV4AXiCWxq9tzVQaQEQi1I/uu88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-hNRAbH0ZNl-fgXaViYSQHQ-1; Fri, 22 Dec 2023 13:00:02 -0500
X-MC-Unique: hNRAbH0ZNl-fgXaViYSQHQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d3eabab1eso12872205e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268000; x=1703872800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTiSU/rkllP5B8KDi/rXfGwcVGdKreTkW03nmSyR0OM=;
 b=AdoSXFE1F6ee371jHYOqgplwFy893pUBoNYlvSAQAVJkBdd1TiyGiTztiHXB1LhIoN
 Dpdc73Bo05eY4wUDla4OPPfgw5MPjg4ph7Ym5hl7ieqffL4ZTmpFe2JqqJNG+AjMendq
 qi2lxqi99vBVdY/YOvL6kQY2uQJnZCCFyVwSWEyESq6D+TtLmQ80mYnDoLbLMH4eolZQ
 U4mPnirYxw8RvwGrYRgGgqD5ei1KA+ohCGc/islEyJUtMUyJinYkFYKuhnj5c6Tx7stu
 KUongXszVvl5GLzBuHx8Paa2K6Ad+NlWtg5K1BEAWgxyFxbMMWK8XlqbXPz0AkntDByg
 XAuQ==
X-Gm-Message-State: AOJu0Yyega2pNHRKAoOVPMvjid9hFmCS4/HQB1mXg0a557YodoXVnp9C
 R+TUIZM6ndLZcO5JPHFn0FTwwmZdXJAX9uoJ5SOETTaEWiJR4kOhz09+f0rNjaGudneUzbsW3Xt
 c4Fp89jNfj59jqkH8zvH0s9CsU/OFwWYBA5SB9SXQXwDgunpwHnV/20KPmbAx8aWfMFovU0uTXP
 w+vqm2YIs=
X-Received: by 2002:a05:600c:378a:b0:40c:4904:bb72 with SMTP id
 o10-20020a05600c378a00b0040c4904bb72mr979126wmr.18.1703268000761; 
 Fri, 22 Dec 2023 10:00:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiMRP6MB1Mq0qr3NIcvLE8JyHGEFao7bZhNjqPjQSP2gmHIBeBoUohcwDGFwZvgT4YxMudRQ==
X-Received: by 2002:a05:600c:378a:b0:40c:4904:bb72 with SMTP id
 o10-20020a05600c378a00b0040c4904bb72mr979115wmr.18.1703268000371; 
 Fri, 22 Dec 2023 10:00:00 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05600c350700b0040d2e37c06dsm7585492wmq.20.2023.12.22.09.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 09:59:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org,
	qemu-stable@nongnu.org
Subject: [PATCH 2/5] target/i386: check validity of VMCB addresses
Date: Fri, 22 Dec 2023 18:59:48 +0100
Message-ID: <20231222175951.172669-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222175951.172669-1-pbonzini@redhat.com>
References: <20231222175951.172669-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

MSR_VM_HSAVE_PA bits 0-11 are reserved, as are the bits above the
maximum physical address width of the processor.  Setting them to
1 causes a #GP (see "15.30.4 VM_HSAVE_PA MSR" in the AMD manual).

The same is true of VMCB addresses passed to VMRUN/VMLOAD/VMSAVE,
even though the manual is not clear on that.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/misc_helper.c |  3 +++
 target/i386/tcg/sysemu/svm_helper.c  | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index e1528b7f80b..1901712ecef 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -201,6 +201,9 @@ void helper_wrmsr(CPUX86State *env)
         tlb_flush(cs);
         break;
     case MSR_VM_HSAVE_PA:
+        if (val & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+            goto error;
+        }
         env->vm_hsave = val;
         break;
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 32ff0dbb13c..5d6de2294fa 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -164,14 +164,19 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     uint64_t new_cr3;
     uint64_t new_cr4;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMRUN, 0, GETPC());
+
     qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmrun! " TARGET_FMT_lx "\n", addr);
 
     env->vm_vmcb = addr;
@@ -463,14 +468,19 @@ void helper_vmload(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMLOAD, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMLOAD, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
@@ -519,14 +529,19 @@ void helper_vmsave(CPUX86State *env, int aflag)
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
 
-    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
-
     if (aflag == 2) {
         addr = env->regs[R_EAX];
     } else {
         addr = (uint32_t)env->regs[R_EAX];
     }
 
+    /* Exceptions are checked before the intercept.  */
+    if (addr & (0xfff | ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_VMSAVE, 0, GETPC());
+
     if (virtual_vm_load_save_enabled(env, SVM_EXIT_VMSAVE, GETPC())) {
         mmu_idx = MMU_NESTED_IDX;
     }
-- 
2.43.0


