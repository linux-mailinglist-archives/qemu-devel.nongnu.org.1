Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6F73B89D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfT-0004ar-Ft; Fri, 23 Jun 2023 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfR-0004aa-C5
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfP-0005cq-Ec
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMOwH0aObN7XtN7vdF9lFgenKbujdWtyVueTxJna5Bg=;
 b=D96wBcPqkOliLz8rKLDPZNIsYwH1IXmsVCTONQSYetSKMpKZECbzcJ+fC9AKWOXnl5ARHk
 B5KMFHwo4jP/T603NaIuOLpw3xUHMmXYRamOUUeBxjxqjXDCpHwsbFvZio3TWrcidzaYHl
 KaxPWtUxJ7r3z4BL/Sgvobhe9cZsHfY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-jcsULCI1N8SotoUdbpzu8g-1; Fri, 23 Jun 2023 09:17:32 -0400
X-MC-Unique: jcsULCI1N8SotoUdbpzu8g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bf847b267so369419a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526251; x=1690118251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMOwH0aObN7XtN7vdF9lFgenKbujdWtyVueTxJna5Bg=;
 b=Rvk7H+3ULwthW3Ey6B98DhsSva9svdGP/5W4MYZqS8/JZXlcpqGAF3nwpaHMevCfXm
 XPKuHgg+kUfjna4X5UnR3oHr0+RejeQrQ2CFHnR+SguTuRTOteVy6JR2neOvgU+R+7BZ
 7041BokTI4VHfjs1ACIQiSLHRikrTFLOVRsHobGbA+WrfwBdt7f1uX1szxOi0uWkIRgh
 WaVd9EzT70/80fKuUXACtDhuYOwU2raTtYCQ8kNpS5ppLsA+KrnR1JTZE6lL/7hzQiQJ
 OMFn/ITl2w2y5udiqZvfOn/ADnUTN/bT9fZn5CT5kJIKWsbjBdfk41fcK6gwm6p3aBkr
 0Cbg==
X-Gm-Message-State: AC+VfDz+nYude0UtrBYvMSPeYbKXGnftL7xwB6fEDQrgArbgfPoY+e37
 NDh1e+iKLafrSWsaXmacu1Ujb+AXX+U5VCn5QGABW+XcQ8CIumku8i9qEtTbXrTPvzquvtVs54B
 sxK0PZbOzOiMszwLJVWzJr4fuZckGSufuII6mqanSV3Xaa7teIuE9h4Q4kdabQcqoT/2yRSG41F
 g=
X-Received: by 2002:a50:fc07:0:b0:51a:60be:7d5a with SMTP id
 i7-20020a50fc07000000b0051a60be7d5amr8474576edr.14.1687526251125; 
 Fri, 23 Jun 2023 06:17:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7S7tfAfozRMSEq/cRulNkPVWmnA1u8zuY1y46qL84Lf5swQhdSv9TF0oie+r53UkorwsLyig==
X-Received: by 2002:a50:fc07:0:b0:51a:60be:7d5a with SMTP id
 i7-20020a50fc07000000b0051a60be7d5amr8474561edr.14.1687526250814; 
 Fri, 23 Jun 2023 06:17:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t24-20020aa7d4d8000000b0051a4a1abdbbsm5206767edr.49.2023.06.23.06.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 11/11] target/i386: implement SYSCALL/SYSRET in 32-bit
 emulators
Date: Fri, 23 Jun 2023 15:17:11 +0200
Message-ID: <20230623131711.96775-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
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

AMD supports both 32-bit and 64-bit SYSCALL/SYSRET, but the TCG only
exposes it for 64-bit targets.  For system emulation just reuse the
helper; for user-mode emulation the ABI is the same as "int $80".

The BSDs does not support any fast system call mechanism in 32-bit
mode so add to bsd-user the same stub that FreeBSD has for 64-bit
compatibility mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/i386/target_arch_cpu.h     |  4 ++++
 linux-user/i386/cpu_loop.c          | 13 +++++++++----
 target/i386/cpu.c                   |  4 ++--
 target/i386/helper.h                |  2 --
 target/i386/tcg/seg_helper.c        |  7 +++++--
 target/i386/tcg/sysemu/seg_helper.c |  7 ++++---
 target/i386/tcg/translate.c         |  2 --
 target/i386/tcg/user/seg_helper.c   |  2 --
 8 files changed, 24 insertions(+), 17 deletions(-)

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
index 2d0918a93ff..3283f08cd9c 100644
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
@@ -227,9 +230,13 @@ void cpu_loop(CPUX86State *env)
                 env->regs[R_EAX] = ret;
             }
             break;
-#ifndef TARGET_ABI32
+#ifdef TARGET_X86_64
         case EXCP_SYSCALL:
-            /* linux syscall from syscall instruction */
+            /*
+             * linux syscall from syscall instruction.  Note that x32 also
+             * uses the SYSCALL instruction and the 64-bit syscall table,
+             * so this uses TARGET_X86_64 not TARGET_ABI32.
+             */
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EDI],
@@ -245,8 +252,6 @@ void cpu_loop(CPUX86State *env)
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


