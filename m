Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964773DD30
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:20:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBv-0003O5-U7; Mon, 26 Jun 2023 07:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBl-0003BE-NT
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBi-0000nL-VJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxo0t+jYTob4i3n0tl1tmTHGoKeu4dfrE81+plrkwh8=;
 b=ftUujoCppxxbYfQlVMYltHA0xvo2NCQIq7n6JX1mMGsQov3CC+RbyLER6j5dHKQZuLF+ck
 rIDGnRv39O9QVVJ9PZq5VnYXQAQrivBulw5dJWuwXkSpf1FGZXQRSZWujcRBtVPdMpHWZD
 KjgFQi/mpXGX3bzmd/bnfnRuaSEqgDY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xZ0_JD7LOmSQrHbMKAFO9Q-1; Mon, 26 Jun 2023 07:15:14 -0400
X-MC-Unique: xZ0_JD7LOmSQrHbMKAFO9Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f97512901eso1820806e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778112; x=1690370112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxo0t+jYTob4i3n0tl1tmTHGoKeu4dfrE81+plrkwh8=;
 b=BtEybW/9GGtzebjieBDA4pE1hnk7/EFqxCvXSo9jZKWs27VlfY+F/wP/hN2uqMj49g
 hE3n0qm734RRA44L4GPL0WWWoZB5t9V751klbc0wzu0V345io571kAfWi/gGW8bforJT
 57Wd1H/R8DP1dY8gRfh4wRBSWwUkY/0W27rfivABE+mrtMyyX2BSG9YiSJh/seJKnEmz
 n1gXd5KE7nLVJbg4nsHonBu67Kfn1tG8mLLMqexOqss1RvILncuWpKSxywOrVEmU4Zka
 1oQhRKOoCPBPhNztxqrKB+fURWEKLXs6Qsp2gTbiUv2Xl0rjFLYMyL4NgVnWixJIMzwp
 mXdw==
X-Gm-Message-State: AC+VfDxH3nYNVz4bl8cnvsd6P1PcF4PyCjYSU3ywMWrG80HdE2es/1Yg
 oM5sSfd3/FnlqGKEGz/xbsi9mNqWD7G0kUymswnjzbkR3Orm+R7+TeODsXw7A918eCN1kqCXKsl
 zKILxAhpkcNitw5dCiSTXS0dWyGw46JxIZZEG1v2ohxptZ28MpegQIkPI24aX7JTJiPhmhvUcIj
 8=
X-Received: by 2002:a05:6512:68:b0:4f7:4098:9905 with SMTP id
 i8-20020a056512006800b004f740989905mr15854719lfo.65.1687778112665; 
 Mon, 26 Jun 2023 04:15:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lkGslXHDTKxR6iFleJStwKdYKBgzRhLThSMnMYpCAsIwGiFsX1luCQDgKMr7ZioAvcS8MfA==
X-Received: by 2002:a05:6512:68:b0:4f7:4098:9905 with SMTP id
 i8-20020a056512006800b004f740989905mr15854705lfo.65.1687778112250; 
 Mon, 26 Jun 2023 04:15:12 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003f8f8fc3c32sm7398551wmk.31.2023.06.26.04.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/18] target/i386: implement SYSCALL/SYSRET in 32-bit emulators
Date: Mon, 26 Jun 2023 13:14:44 +0200
Message-ID: <20230626111445.163573-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

AMD supports both 32-bit and 64-bit SYSCALL/SYSRET, but the TCG only
exposes it for 64-bit targets.  For system emulation just reuse the
helper; for user-mode emulation the ABI is the same as "int $80".

The BSDs does not support any fast system call mechanism in 32-bit
mode so add to bsd-user the same stub that FreeBSD has for 64-bit
compatibility mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/i386/target_arch_cpu.h     | 4 ++++
 linux-user/i386/cpu_loop.c          | 9 +++++----
 target/i386/cpu.c                   | 4 ++--
 target/i386/helper.h                | 2 --
 target/i386/tcg/seg_helper.c        | 7 +++++--
 target/i386/tcg/sysemu/seg_helper.c | 7 ++++---
 target/i386/tcg/translate.c         | 2 --
 target/i386/tcg/user/seg_helper.c   | 2 --
 8 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index d792dc720f9..9bf2c4244b7 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -164,6 +164,10 @@ static inline void target_cpu_loop(CPUX86State *env)
             }
             break;
 
+        case EXCP_SYSCALL:
+            /* doesn't do anything */
+            break;
+
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 2d0918a93ff..9eeda551eaf 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -211,6 +211,9 @@ void cpu_loop(CPUX86State *env)
 
         switch(trapnr) {
         case 0x80:
+#ifndef TARGET_X86_64
+        case EXCP_SYSCALL:
+#endif
             /* linux syscall from int $0x80 */
             ret = do_syscall(env,
                              env->regs[R_EAX],
@@ -227,9 +230,9 @@ void cpu_loop(CPUX86State *env)
                 env->regs[R_EAX] = ret;
             }
             break;
-#ifndef TARGET_ABI32
+#ifdef TARGET_X86_64
         case EXCP_SYSCALL:
-            /* linux syscall from syscall instruction */
+            /* linux syscall from syscall instruction.  */
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EDI],
@@ -245,8 +248,6 @@ void cpu_loop(CPUX86State *env)
                 env->regs[R_EAX] = ret;
             }
             break;
-#endif
-#ifdef TARGET_X86_64
         case EXCP_VSYSCALL:
             emulate_vsyscall(env);
             break;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d52e612ac7..c0fb6b3ad92 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -637,7 +637,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
 
 #ifdef TARGET_X86_64
-#define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)
+#define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
 #else
 #define TCG_EXT2_X86_64_FEATURES 0
 #endif
@@ -645,7 +645,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
           CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
-          TCG_EXT2_X86_64_FEATURES)
+          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
           CPUID_EXT3_3DNOWPREFETCH)
diff --git a/target/i386/helper.h b/target/i386/helper.h
index c93c1d6c8f5..ac2b04abd63 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -51,10 +51,8 @@ DEF_HELPER_FLAGS_2(get_dr, TCG_CALL_NO_WG, tl, env, int)
 
 DEF_HELPER_1(sysenter, void, env)
 DEF_HELPER_2(sysexit, void, env, int)
-#ifdef TARGET_X86_64
 DEF_HELPER_2(syscall, void, env, int)
 DEF_HELPER_2(sysret, void, env, int)
-#endif
 DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 03b58e94a2d..e8d19c65fdc 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -977,6 +977,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
                    e2);
     env->eip = offset;
 }
+#endif /* TARGET_X86_64 */
 
 void helper_sysret(CPUX86State *env, int dflag)
 {
@@ -990,6 +991,7 @@ void helper_sysret(CPUX86State *env, int dflag)
         raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
     }
     selector = (env->star >> 48) & 0xffff;
+#ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
         cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
                         | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
@@ -1015,7 +1017,9 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                DESC_W_MASK | DESC_A_MASK);
-    } else {
+    } else
+#endif
+    {
         env->eflags |= IF_MASK;
         cpu_x86_load_seg_cache(env, R_CS, selector | 3,
                                0, 0xffffffff,
@@ -1030,7 +1034,6 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_W_MASK | DESC_A_MASK);
     }
 }
-#endif /* TARGET_X86_64 */
 
 /* real mode interrupt */
 static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 2c9bd007adb..1cb5a0db45c 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -26,7 +26,6 @@
 #include "tcg/helper-tcg.h"
 #include "../seg_helper.h"
 
-#ifdef TARGET_X86_64
 void helper_syscall(CPUX86State *env, int next_eip_addend)
 {
     int selector;
@@ -35,6 +34,7 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
         raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
     }
     selector = (env->star >> 32) & 0xffff;
+#ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
         int code64;
 
@@ -61,7 +61,9 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
         } else {
             env->eip = env->cstar;
         }
-    } else {
+    } else
+#endif
+    {
         env->regs[R_ECX] = (uint32_t)(env->eip + next_eip_addend);
 
         env->eflags &= ~(IF_MASK | RF_MASK | VM_MASK);
@@ -78,7 +80,6 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
         env->eip = (uint32_t)env->star;
     }
 }
-#endif /* TARGET_X86_64 */
 
 void handle_even_inj(CPUX86State *env, int intno, int is_int,
                      int error_code, int is_hw, int rm)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a6c24241338..28cb3fb7f4b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5704,7 +5704,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             s->base.is_jmp = DISAS_EOB_ONLY;
         }
         break;
-#ifdef TARGET_X86_64
     case 0x105: /* syscall */
         /* For Intel SYSCALL is only valid in long mode */
         if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
@@ -5738,7 +5737,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_eob_worker(s, false, true);
         }
         break;
-#endif
     case 0x1a2: /* cpuid */
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 67481b0aa8e..c45f2ac2ba6 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -26,7 +26,6 @@
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
 
-#ifdef TARGET_X86_64
 void helper_syscall(CPUX86State *env, int next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
@@ -36,7 +35,6 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
     env->exception_next_eip = env->eip + next_eip_addend;
     cpu_loop_exit(cs);
 }
-#endif /* TARGET_X86_64 */
 
 /*
  * fake user mode interrupt. is_int is TRUE if coming from the int
-- 
2.41.0


