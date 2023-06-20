Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE62173702B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6S-0003WG-UW; Tue, 20 Jun 2023 11:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6Q-0003VA-VN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6P-0007SO-0t
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9wRB+bJq7UCCX2IcUL9W3jxwQ0n71C1A39mEYwMApU=;
 b=UHwJmtcnv4pt7UK9nF2Bbz1ur+GzPmaCWOzHJhGVhxd7qbPy/SqnXIbQnyZnF7o/HfpYPs
 SqLd2p0BrC5UYmTVRI7J+Kv+xDtCR78kB9RwxjcY1GtoL1XoW6+ST1U0+K1XolQ/8GJqUq
 B2PH89cnyOJiXYVfW74KB5fFiFjoWWg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Tu5Z9XGyMeaLItRru2ezbg-1; Tue, 20 Jun 2023 11:16:57 -0400
X-MC-Unique: Tu5Z9XGyMeaLItRru2ezbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-986db3313f0so268163866b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274212; x=1689866212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9wRB+bJq7UCCX2IcUL9W3jxwQ0n71C1A39mEYwMApU=;
 b=HJCs7dlJ+x5FWZGIMmJyCvuAGPJ5JPPc8UqL4lyLqvlPksJ+YYjjx+nE3x9HOKip9s
 WxJakKF3zCDLr3X9mt5Ikn5xGSWT4IsdVpfk3uG+QNqm1ShTaZvt/q9NTrQR1/LStSeW
 fDqv9wxn2GsGIW8ALiaCP0Z3hWx3Wg3lE3IzVEcw4q+BPd16YX5Bc481l2fLFNhY3fKt
 IBeg6zYJA082FbT29QPbb2gRrhAm/S4s5UO3Qi5zunWuF5htD/F45IiRaQqZV+GFrpzX
 3Kp24kDyTFsnRk2xZRApSRCltcWkKhUgT21yg3hHICq3bM3JdLagagYbs+mXgQ0DIOH4
 U7kA==
X-Gm-Message-State: AC+VfDwlUf4xoU97S3bKDLAE/YPEW95otWZpIc3ASyzJQqtnNUBlbYD6
 bu+EMOUPQ1cZVMhd0Fyop+jx29XlF/iSoc5yi/reZG14dLD8o/aM/mI/zWpE9Gw5GhPelpedf2Z
 +3lfzHkKVmtkrcqxXpTTYZRfVYUO5Ruj4Rw1enWMgoRdwssi5o7Y4HSxNeXZD0BEKv2mWsOgcuj
 Q=
X-Received: by 2002:a17:907:368c:b0:982:2586:f85 with SMTP id
 bi12-20020a170907368c00b0098225860f85mr11286758ejc.65.1687274212639; 
 Tue, 20 Jun 2023 08:16:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44rgW1UAhthdSh+v/vZH8uxSrCveg6xM6AfV89bJ10yDmm49fvA8RaPiquoLTWQMiX0JiMUA==
X-Received: by 2002:a17:907:368c:b0:982:2586:f85 with SMTP id
 bi12-20020a170907368c00b0098225860f85mr11286745ejc.65.1687274212246; 
 Tue, 20 Jun 2023 08:16:52 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a170906191500b0096a6be0b66dsm1534377eje.208.2023.06.20.08.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 09/10] target/i386: implement 32-bit SYSENTER for linux-user
Date: Tue, 20 Jun 2023 17:16:33 +0200
Message-Id: <20230620151634.21053-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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

TCG reports the SEP feature (SYSENTER/SYSEXIT) in user mode emulation,
but does not plumb it into the linux-user run loop.  Split the helper into
system emulation and user-mode emulation cases and implement the latter.

SYSENTER does not have the best design for a kernel-mode entry
instruction, and therefore Linux always makes it return to the
vsyscall page.  Because QEMU does not provide the _contents_ of
the vsyscall page, the instructions executed after SYSEXIT have
to be emulated by hand until the first RET.

Some corner cases, such as restarting the system call after the
system call has rewritten the SYSENTER instruction, are not emulated
correctly.  On Linux, the system call restart uses the SYSENTER
call in the vsyscall page, while on QEMU it uses the emulated
program's instruction.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/i386/cpu_loop.c          | 51 +++++++++++++++++++++++++++--
 target/i386/cpu.c                   |  9 ++++-
 target/i386/cpu.h                   |  1 +
 target/i386/helper.h                |  2 +-
 target/i386/tcg/seg_helper.c        | 33 -------------------
 target/i386/tcg/sysemu/seg_helper.c | 33 +++++++++++++++++++
 target/i386/tcg/translate.c         |  2 +-
 target/i386/tcg/user/seg_helper.c   | 16 +++++++++
 8 files changed, 109 insertions(+), 38 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 6908bad14aa..690d9a42ee0 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -197,6 +197,41 @@ static bool maybe_handle_vm86_trap(CPUX86State *env, int trapnr)
     return false;
 }
 
+static void emulate_vsyscall_sysexit(CPUX86State *env)
+{
+    /*
+     * Emulate the pop and ret instructions after the sysenter instruction
+     * in the vsyscall page.  Any sysenter returns there, because sysenter
+     * does not save the old EIP!
+     */
+    abi_ulong word;
+    if (get_user_ual(word, env->regs[R_ESP])) {
+        goto segv;
+    }
+    env->regs[R_EBP] = word;
+    env->regs[R_ESP] += sizeof(target_ulong);
+    if (get_user_ual(word, env->regs[R_ESP])) {
+        goto segv;
+    }
+    env->regs[R_EDX] = word;
+    env->regs[R_ESP] += sizeof(target_ulong);
+    if (get_user_ual(word, env->regs[R_ESP])) {
+        goto segv;
+    }
+    env->regs[R_ECX] = word;
+    env->regs[R_ESP] += sizeof(target_ulong);
+    if (get_user_ual(word, env->regs[R_ESP])) {
+        goto segv;
+    }
+    env->eip = word;
+    env->regs[R_ESP] += sizeof(target_ulong);
+    return;
+
+segv:
+    env->error_code = PG_ERROR_W_MASK | PG_ERROR_U_MASK;
+    force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR, env->regs[R_ESP]);
+}
+
 void cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -213,6 +248,7 @@ void cpu_loop(CPUX86State *env)
         case 0x80:
 #ifdef TARGET_ABI32
         case EXCP_SYSCALL:
+        case EXCP_SYSENTER:
 #endif
             /* linux syscall from int $0x80 */
             ret = do_syscall(env,
@@ -226,12 +262,18 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+                break;
+            }
+            if (ret != -QEMU_ESIGRETURN) {
                 env->regs[R_EAX] = ret;
             }
+            if (trapnr == EXCP_SYSENTER) {
+                emulate_vsyscall_sysexit(env);
+            }
             break;
 #ifndef TARGET_ABI32
         case EXCP_SYSCALL:
+        case EXCP_SYSENTER:
             /* linux syscall from syscall instruction */
             ret = do_syscall(env,
                              env->regs[R_EAX],
@@ -244,9 +286,14 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+                break;
+            }
+            if (ret != -QEMU_ESIGRETURN) {
                 env->regs[R_EAX] = ret;
             }
+            if (trapnr == EXCP_SYSENTER) {
+                emulate_vsyscall_sysexit(env);
+            }
             break;
 #endif
 #ifdef TARGET_X86_64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 934360e4091..2c71c3ea32b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -614,11 +614,18 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_PAT | CPUID_FXSR | CPUID_MMX | CPUID_SSE | CPUID_SSE2 | \
           CPUID_PAE | CPUID_SEP | CPUID_APIC)
 
+#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX_USER
+#define TCG_NOBSD_FEATURES CPUID_SEP
+#else
+#define TCG_NOBSD_FEATURES 0
+#endif
+
 #define TCG_FEATURES (CPUID_FP87 | CPUID_PSE | CPUID_TSC | CPUID_MSR | \
           CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
           CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
           CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
-          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
+          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE | \
+          TCG_NOBSD_FEATURES)
           /* partly implemented:
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7201a71de86..bc7d10bf863 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1185,6 +1185,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
 #define EXCP_VSYSCALL   0x102 /* only for user emulation */
+#define EXCP_SYSENTER   0x103 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
diff --git a/target/i386/helper.h b/target/i386/helper.h
index c2e86c6119c..49d2f537557 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -49,7 +49,7 @@ DEF_HELPER_FLAGS_3(set_dr, TCG_CALL_NO_WG, void, env, int, tl)
 DEF_HELPER_FLAGS_2(get_dr, TCG_CALL_NO_WG, tl, env, int)
 #endif /* !CONFIG_USER_ONLY */
 
-DEF_HELPER_1(sysenter, void, env)
+DEF_HELPER_2(sysenter, void, env, int)
 DEF_HELPER_2(sysexit, void, env, int)
 DEF_HELPER_2(syscall, void, env, int)
 #ifdef TARGET_X86_64
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 03b58e94a2d..6899b8f6890 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2147,39 +2147,6 @@ void helper_lret_protected(CPUX86State *env, int shift, int addend)
     helper_ret_protected(env, shift, 0, addend, GETPC());
 }
 
-void helper_sysenter(CPUX86State *env)
-{
-    if (env->sysenter_cs == 0) {
-        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
-    }
-    env->eflags &= ~(VM_MASK | IF_MASK | RF_MASK);
-
-#ifdef TARGET_X86_64
-    if (env->hflags & HF_LMA_MASK) {
-        cpu_x86_load_seg_cache(env, R_CS, env->sysenter_cs & 0xfffc,
-                               0, 0xffffffff,
-                               DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
-                               DESC_S_MASK |
-                               DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
-                               DESC_L_MASK);
-    } else
-#endif
-    {
-        cpu_x86_load_seg_cache(env, R_CS, env->sysenter_cs & 0xfffc,
-                               0, 0xffffffff,
-                               DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
-                               DESC_S_MASK |
-                               DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK);
-    }
-    cpu_x86_load_seg_cache(env, R_SS, (env->sysenter_cs + 8) & 0xfffc,
-                           0, 0xffffffff,
-                           DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
-                           DESC_S_MASK |
-                           DESC_W_MASK | DESC_A_MASK);
-    env->regs[R_ESP] = env->sysenter_esp;
-    env->eip = env->sysenter_eip;
-}
-
 void helper_sysexit(CPUX86State *env, int dflag)
 {
     int cpl;
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 2c9bd007adb..967882b6c69 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -215,3 +215,36 @@ void helper_check_io(CPUX86State *env, uint32_t addr, uint32_t size)
         raise_exception_err_ra(env, EXCP0D_GPF, 0, retaddr);
     }
 }
+
+void helper_sysenter(CPUX86State *env, int next_eip_addend)
+{
+    if (env->sysenter_cs == 0) {
+        raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+    }
+    env->eflags &= ~(VM_MASK | IF_MASK | RF_MASK);
+
+#ifdef TARGET_X86_64
+    if (env->hflags & HF_LMA_MASK) {
+        cpu_x86_load_seg_cache(env, R_CS, env->sysenter_cs & 0xfffc,
+                               0, 0xffffffff,
+                               DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
+                               DESC_S_MASK |
+                               DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
+                               DESC_L_MASK);
+    } else
+#endif
+    {
+        cpu_x86_load_seg_cache(env, R_CS, env->sysenter_cs & 0xfffc,
+                               0, 0xffffffff,
+                               DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
+                               DESC_S_MASK |
+                               DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK);
+    }
+    cpu_x86_load_seg_cache(env, R_SS, (env->sysenter_cs + 8) & 0xfffc,
+                           0, 0xffffffff,
+                           DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
+                           DESC_S_MASK |
+                           DESC_W_MASK | DESC_A_MASK);
+    env->regs[R_ESP] = env->sysenter_esp;
+    env->eip = env->sysenter_eip;
+}
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0ddb689444e..af74c842f96 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5667,7 +5667,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
-            gen_helper_sysenter(cpu_env);
+            gen_helper_sysenter(cpu_env, cur_insn_len_i32(s));
             s->base.is_jmp = DISAS_EOB_ONLY;
         }
         break;
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index c45f2ac2ba6..1ac3ee39b5b 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -36,6 +36,22 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
     cpu_loop_exit(cs);
 }
 
+void helper_sysenter(CPUX86State *env, int next_eip_addend)
+{
+    CPUState *cs = env_cpu(env);
+
+    /*
+     * sysenter returns to the landing pad of the vDSO, which pops
+     * ebp/edx/ecx before executing a "ret".
+     */
+    cs->exception_index = EXCP_SYSENTER;
+    env->exception_is_int = 0;
+
+    /* Used for ERESTARTSYS.  */
+    env->exception_next_eip = env->eip + next_eip_addend;
+    cpu_loop_exit(cs);
+}
+
 /*
  * fake user mode interrupt. is_int is TRUE if coming from the int
  * instruction. next_eip is the env->eip value AFTER the interrupt
-- 
2.40.1


