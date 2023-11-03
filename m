Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E27E07A5
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8z-0005Ur-JE; Fri, 03 Nov 2023 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8P-0005FY-6R
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8G-0003WT-44
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so19363805ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033135; x=1699637935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRppr0jtETveHLOhJJnBGFSQpLGg4IDz6r7ulJ5/PtI=;
 b=SK1d2TE+bxllUmx1kSsJdzSfCWx7LWk3kbO7msBG7d6ijwCrhk9+zCyf0Khxoldc02
 Ey+ftPJUIAxK+tOz7Cx1U20M3Og1yX3Or5QrJxqk8KkgHE3JFHSWhWWHigWQrVdqgiar
 dRytO9CL7bFfaWZYiKocMj8K09fErpISDTiQoeaHMUnGdkAMPzvkCW1JNnj3LzG/rbta
 0Ek7PDuom9Sq/K01fWRMXFyNT7NveoqIRB234lksCNv9OCKxEomZbMnKKw5KoEC4i7aR
 IblcRBQ8BlnC5P/GRWXtjorxCDo0bAc4isjBKHpB7rd4Q9lLqT1zzlvlHcY0BNW2vel1
 OKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033135; x=1699637935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRppr0jtETveHLOhJJnBGFSQpLGg4IDz6r7ulJ5/PtI=;
 b=kL+VcSmtxK7OWjS+cWNRDRlW8UFQRPDra9lT8tk+GHvKjg94sj5esgvGXAoEyKyx8p
 QR5/DVSbWNtPBbd/lB/oRsO5e1haEn3QjtMSaf7LPjURTAItS8hEwyzhmmSzVZr9g1VV
 nte25G9zZCXf4ND4fhbA2P30ecIDyh2vD5F0gGPceDdJNtZXVxYIJH7c2Y5cIDwKoocu
 8dQxFpU+hMYNzTmhojcZN78FLv3lT/aRK14Mg7sIe4rKbu3Tr9adScHPKid9cN6S7Y4K
 CXhVnG86pCPrdOIBngt/pBjoSNMYoUSnRaEmoXV5yr2Izw4ebkLAJJof5HCuXngtV5ia
 iMFg==
X-Gm-Message-State: AOJu0YzSQTKu1UlcUdHtjqpZaiaZEOPvPjRYxGFzcRHQJwEUENYoNnXa
 F1u2sWubKKjgoy3wXppdWifeN1a7G7L94MOg6Xs=
X-Google-Smtp-Source: AGHT+IEvzDI+ys8/yLNogzX4K72kDoMe0uvQlcvNtGnzrELEZAm5kxVRqBRerK+VvExsCZW6AvZtiw==
X-Received: by 2002:a17:902:e84a:b0:1cc:4a47:1fe5 with SMTP id
 t10-20020a170902e84a00b001cc4a471fe5mr15633706plg.59.1699033134770; 
 Fri, 03 Nov 2023 10:38:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 15/22] target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
Date: Fri,  3 Nov 2023 10:38:34 -0700
Message-Id: <20231103173841.33651-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h          |  4 +++-
 target/sparc/helper.h       |  1 +
 linux-user/sparc/cpu_loop.c |  2 +-
 linux-user/sparc/signal.c   | 14 +++++++++-----
 target/sparc/cpu.c          |  5 +++--
 target/sparc/fop_helper.c   | 21 ++++++++++++++++++--
 target/sparc/gdbstub.c      |  8 ++++----
 target/sparc/machine.c      | 38 +++++++++++++++++++++++++++++++++++--
 target/sparc/translate.c    |  7 ++++++-
 9 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 446b38f3df..33c7d31fef 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -605,7 +605,9 @@ void sparc_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
 
-/* cpu-exec.c */
+/* fop_helper.c */
+target_ulong cpu_get_fsr(CPUSPARCState *);
+void cpu_put_fsr(CPUSPARCState *, target_ulong);
 
 /* win_helper.c */
 target_ulong cpu_get_psr(CPUSPARCState *env1);
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index f7aeb31169..cc8db50d75 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -36,6 +36,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
+DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
 DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_RWG, f64, env, f64)
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 3c1bde00dd..50424a54df 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -293,7 +293,7 @@ void cpu_loop (CPUSPARCState *env)
         case TT_FP_EXCP:
             {
                 int code = TARGET_FPE_FLTUNK;
-                target_ulong fsr = env->fsr;
+                target_ulong fsr = cpu_get_fsr(env);
 
                 if ((fsr & FSR_FTT_MASK) == FSR_FTT_IEEE_EXCP) {
                     if (fsr & FSR_NVC) {
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index dfcae707e0..c2dc1000e2 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -199,20 +199,21 @@ static void save_fpu(struct target_siginfo_fpu *fpu, CPUSPARCState *env)
     for (i = 0; i < 32; ++i) {
         __put_user(env->fpr[i].ll, &fpu->si_double_regs[i]);
     }
-    __put_user(env->fsr, &fpu->si_fsr);
+    __put_user(cpu_get_fsr(env), &fpu->si_fsr);
     __put_user(env->gsr, &fpu->si_gsr);
     __put_user(env->fprs, &fpu->si_fprs);
 #else
     for (i = 0; i < 16; ++i) {
         __put_user(env->fpr[i].ll, &fpu->si_double_regs[i]);
     }
-    __put_user(env->fsr, &fpu->si_fsr);
+    __put_user(cpu_get_fsr(env), &fpu->si_fsr);
     __put_user(0, &fpu->si_fpqdepth);
 #endif
 }
 
 static void restore_fpu(struct target_siginfo_fpu *fpu, CPUSPARCState *env)
 {
+    target_ulong fsr;
     int i;
 
 #ifdef TARGET_SPARC64
@@ -230,15 +231,16 @@ static void restore_fpu(struct target_siginfo_fpu *fpu, CPUSPARCState *env)
             __get_user(env->fpr[i].ll, &fpu->si_double_regs[i]);
         }
     }
-    __get_user(env->fsr, &fpu->si_fsr);
     __get_user(env->gsr, &fpu->si_gsr);
     env->fprs |= fprs;
 #else
     for (i = 0; i < 16; ++i) {
         __get_user(env->fpr[i].ll, &fpu->si_double_regs[i]);
     }
-    __get_user(env->fsr, &fpu->si_fsr);
 #endif
+
+    __get_user(fsr, &fpu->si_fsr);
+    cpu_put_fsr(env, fsr);
 }
 
 #ifdef TARGET_ARCH_HAS_SETUP_FRAME
@@ -662,6 +664,7 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(fenab, &(fpup->mcfpu_enab));
     if (fenab) {
         abi_ulong fprs;
+        abi_ulong fsr;
 
         /*
          * We use the FPRS from the guest only in deciding whether
@@ -690,7 +693,8 @@ void sparc64_set_context(CPUSPARCState *env)
                 __get_user(env->fpr[i].ll, &(fpup->mcfpu_fregs.dregs[i]));
             }
         }
-        __get_user(env->fsr, &(fpup->mcfpu_fsr));
+        __get_user(fsr, &(fpup->mcfpu_fsr));
+        cpu_put_fsr(env, fsr);
         __get_user(env->gsr, &(fpup->mcfpu_gsr));
     }
     unlock_user_struct(ucp, ucp_addr, 0);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index befa7fc4eb..69dfa1dd4e 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -670,7 +670,7 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  env->cansave, env->canrestore, env->otherwin, env->wstate,
                  env->cleanwin, env->nwindows - 1 - env->cwp);
     qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: %016x\n",
-                 env->fsr, env->y, env->fprs);
+                 cpu_get_fsr(env), env->y, env->fprs);
 
 #else
     qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
@@ -679,7 +679,7 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  env->psrps ? 'P' : '-', env->psret ? 'E' : '-',
                  env->wim);
     qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx "\n",
-                 env->fsr, env->y);
+                 cpu_get_fsr(env), env->y);
 #endif
     qemu_fprintf(f, "\n");
 }
@@ -770,6 +770,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.maxtl << 8;
     env->version |= env->def.nwindows - 1;
 #endif
+    cpu_put_fsr(env, 0);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 7353a61237..70b38011d2 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -347,10 +347,22 @@ GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 #undef GEN_FCMP_T
 #undef GEN_FCMP
 
-static void set_fsr(CPUSPARCState *env, target_ulong fsr)
+target_ulong cpu_get_fsr(CPUSPARCState *env)
+{
+    return env->fsr;
+}
+
+target_ulong helper_get_fsr(CPUSPARCState *env)
+{
+    return cpu_get_fsr(env);
+}
+
+static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 {
     int rnd_mode;
 
+    env->fsr = fsr;
+
     switch (fsr & FSR_RD_MASK) {
     case FSR_RD_NEAREST:
         rnd_mode = float_round_nearest_even;
@@ -369,7 +381,12 @@ static void set_fsr(CPUSPARCState *env, target_ulong fsr)
     set_float_rounding_mode(rnd_mode, &env->fp_status);
 }
 
+void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
+{
+    set_fsr_nonsplit(env, fsr);
+}
+
 void helper_set_fsr(CPUSPARCState *env, target_ulong fsr)
 {
-    set_fsr(env, fsr);
+    set_fsr_nonsplit(env, fsr);
 }
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index a1c8fdc4d5..d1586b2392 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -64,7 +64,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 69:
         return gdb_get_rega(mem_buf, env->npc);
     case 70:
-        return gdb_get_rega(mem_buf, env->fsr);
+        return gdb_get_rega(mem_buf, cpu_get_fsr(env));
     case 71:
         return gdb_get_rega(mem_buf, 0); /* csr */
     default:
@@ -94,7 +94,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                                      ((env->pstate & 0xfff) << 8) |
                                      cpu_get_cwp64(env));
     case 83:
-        return gdb_get_regl(mem_buf, env->fsr);
+        return gdb_get_regl(mem_buf, cpu_get_fsr(env));
     case 84:
         return gdb_get_regl(mem_buf, env->fprs);
     case 85:
@@ -156,7 +156,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->npc = tmp;
             break;
         case 70:
-            env->fsr = tmp;
+            cpu_put_fsr(env, tmp);
             break;
         default:
             return 0;
@@ -191,7 +191,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             cpu_put_cwp64(env, tmp & 0xff);
             break;
         case 83:
-            env->fsr = tmp;
+            cpu_put_fsr(env, tmp);
             break;
         case 84:
             env->fprs = tmp;
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 44dfc07014..e46f15adb8 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -83,6 +83,34 @@ static const VMStateInfo vmstate_psr = {
     .put = put_psr,
 };
 
+static int get_fsr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    target_ulong val = qemu_get_betl(f);
+
+    cpu_put_fsr(env, val);
+    return 0;
+}
+
+static int put_fsr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc)
+{
+    SPARCCPU *cpu = opaque;
+    CPUSPARCState *env = &cpu->env;
+    target_ulong val = cpu_get_fsr(env);
+
+    qemu_put_betl(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_fsr = {
+    .name = "fsr",
+    .get = get_fsr,
+    .put = put_fsr,
+};
+
 #ifdef TARGET_SPARC64
 static int get_xcc(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field)
@@ -157,7 +185,6 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINTTL(env.npc, SPARCCPU),
         VMSTATE_UINTTL(env.y, SPARCCPU),
         {
-
             .name = "psr",
             .version_id = 0,
             .size = sizeof(uint32_t),
@@ -165,7 +192,14 @@ const VMStateDescription vmstate_sparc_cpu = {
             .flags = VMS_SINGLE,
             .offset = 0,
         },
-        VMSTATE_UINTTL(env.fsr, SPARCCPU),
+        {
+            .name = "fsr",
+            .version_id = 0,
+            .size = sizeof(target_ulong),
+            .info = &vmstate_fsr,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
         VMSTATE_UINTTL(env.tbr, SPARCCPU),
         VMSTATE_INT32(env.interrupt_index, SPARCCPU),
         VMSTATE_UINT32(env.pil_in, SPARCCPU),
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 99482df256..1d5f36dafc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4417,13 +4417,18 @@ TRANS(LDXFSR, 64, do_ldfsr, a, MO_TEUQ, FSR_LDXFSR_MASK, FSR_LDXFSR_OLDMASK)
 static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    TCGv fsr;
+
     if (addr == NULL) {
         return false;
     }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    tcg_gen_qemu_st_tl(cpu_fsr, addr, dc->mem_idx, mop | MO_ALIGN);
+
+    fsr = tcg_temp_new();
+    gen_helper_get_fsr(fsr, tcg_env);
+    tcg_gen_qemu_st_tl(fsr, addr, dc->mem_idx, mop | MO_ALIGN);
     return advance_pc(dc);
 }
 
-- 
2.34.1


