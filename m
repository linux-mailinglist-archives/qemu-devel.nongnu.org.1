Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C0D903EAF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jun 2024 16:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Rv-0007eM-I8; Tue, 11 Jun 2024 10:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Ru-0007dq-0G
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Ro-000698-Rk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT0cfFR+bfzXMGrUOjzUugFi93WW3rdn0Fvc8xiuPSM=;
 b=JbxtBuoE9duFqR2Q6GnJsCv2fk3kPDkpLxwXl70YbArjfp+KnMOl1wZlCnD+vVXP86EFNB
 OeSht0hflXmNFWyCkNKm9dDzREgJo0+m4IK5QHEonKDZJtQfCKyZa/VbSlfrqg322ss1yy
 3e35wJYpW3RbD31918PFwO0TH5hDxYY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-tsGcmPaLPrm0mo3k_FFv2g-1; Tue, 11 Jun 2024 10:26:01 -0400
X-MC-Unique: tsGcmPaLPrm0mo3k_FFv2g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so726862a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115959; x=1718720759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT0cfFR+bfzXMGrUOjzUugFi93WW3rdn0Fvc8xiuPSM=;
 b=b4crmaXZaSClMkN4gYAQxEpxnjXocdpnmcyzy1S8YhNAARnwCiMacHT88mSZ3lbL+U
 CsCthA5iHLv+xk4cGGGNoljOuDNm6IAO3KzEfwf7nT5tldBzeDXT6ucCcqPOGbz/0wME
 JfNRsGEep+cex454i6ZH5LEQlVEX5MKs5KbWwMZvz/WsR3sFihgV/2KHKAG+5pp1hZos
 XcntFf2wR0Q61LkJcueRLRcxM1aaLd1tWZbUZRzM8HR8DybTz1sfZtgOteR0CL5mBY52
 yk4r8cbtqI6y4TSYpDEPI41Y0JUfzb0syAfhUjeHC46rL2Ts6ypPT6h9Hf76YpB0YFQd
 rDkA==
X-Gm-Message-State: AOJu0YxqtQ4Smt3i+ZWHN/U8wZQmnOqUS0E77XdTTCYo5IMwldEbQzpc
 BZ07NXKt60q2kilRLxiKv2znaysfmWilE2bJGJI+Ed5hbmN9a9n/jJMXWxrc3lvUxt9cyCodmJ8
 dWy76QTnffMxl72WUS3WQfRfwTHpZEn+YkFOetC9O5fSIqdZpy8NLtDOmeeH4+iiYblJxKRpoOc
 3zCuAVt+KqxMAap6TcbErkz3eHLjF6spVAanT4
X-Received: by 2002:a50:d4d8:0:b0:579:e6d1:d38b with SMTP id
 4fb4d7f45d1cf-57c50886a45mr7021858a12.2.1718115958830; 
 Tue, 11 Jun 2024 07:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe1cjny28YAdCqoU0o1dXUFijq4afUdLcSFOs0uNsQX5OMsQfwGfBiusps+ti4/i6Ofsp01w==
X-Received: by 2002:a50:d4d8:0:b0:579:e6d1:d38b with SMTP id
 4fb4d7f45d1cf-57c50886a45mr7021846a12.2.1718115958368; 
 Tue, 11 Jun 2024 07:25:58 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c867a6c6dsm2993494a12.32.2024.06.11.07.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/25] target/i386: finish converting 0F AE to the new decoder
Date: Tue, 11 Jun 2024 16:25:13 +0200
Message-ID: <20240611142524.83762-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is already partly implemented due to VLDMXCSR and VSTMXCSR; finish
the job.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |   7 ++
 target/i386/tcg/translate.c      | 188 -------------------------------
 target/i386/tcg/decode-new.c.inc |  48 +++++++-
 target/i386/tcg/emit.c.inc       |  80 +++++++++++++
 4 files changed, 129 insertions(+), 194 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 8465717ea21..5577f7509aa 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -108,10 +108,15 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CLFLUSH,
+    X86_FEAT_CLFLUSHOPT,
+    X86_FEAT_CLWB,
     X86_FEAT_CMOV,
     X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
+    X86_FEAT_FSGSBASE,
+    X86_FEAT_FXSR,
     X86_FEAT_MOVBE,
     X86_FEAT_PCLMULQDQ,
     X86_FEAT_SHA_NI,
@@ -122,6 +127,8 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_SSE41,
     X86_FEAT_SSE42,
     X86_FEAT_SSE4A,
+    X86_FEAT_XSAVE,
+    X86_FEAT_XSAVEOPT,
 } X86CPUIDFeature;
 
 /* Execution flags */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4958f4c45d5..ebae745ecba 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4197,194 +4197,6 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
         break;
-    /* MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4 support */
-    case 0x1ae:
-        modrm = x86_ldub_code(env, s);
-        switch (modrm) {
-        CASE_MODRM_MEM_OP(0): /* fxsave */
-            if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
-                goto illegal_op;
-            }
-            if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX);
-                break;
-            }
-            gen_lea_modrm(env, s, modrm);
-            gen_helper_fxsave(tcg_env, s->A0);
-            break;
-
-        CASE_MODRM_MEM_OP(1): /* fxrstor */
-            if (!(s->cpuid_features & CPUID_FXSR)
-                || (prefixes & PREFIX_LOCK)) {
-                goto illegal_op;
-            }
-            if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
-                gen_exception(s, EXCP07_PREX);
-                break;
-            }
-            gen_lea_modrm(env, s, modrm);
-            gen_helper_fxrstor(tcg_env, s->A0);
-            break;
-
-        CASE_MODRM_MEM_OP(2): /* ldmxcsr */
-            if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
-                goto illegal_op;
-            }
-            if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX);
-                break;
-            }
-            gen_lea_modrm(env, s, modrm);
-            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
-            gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
-            break;
-
-        CASE_MODRM_MEM_OP(3): /* stmxcsr */
-            if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
-                goto illegal_op;
-            }
-            if (s->flags & HF_TS_MASK) {
-                gen_exception(s, EXCP07_PREX);
-                break;
-            }
-            gen_helper_update_mxcsr(tcg_env);
-            gen_lea_modrm(env, s, modrm);
-            tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
-            gen_op_st_v(s, MO_32, s->T0, s->A0);
-            break;
-
-        CASE_MODRM_MEM_OP(4): /* xsave */
-            if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
-                goto illegal_op;
-            }
-            gen_lea_modrm(env, s, modrm);
-            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
-                                  cpu_regs[R_EDX]);
-            gen_helper_xsave(tcg_env, s->A0, s->tmp1_i64);
-            break;
-
-        CASE_MODRM_MEM_OP(5): /* xrstor */
-            if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (prefixes & (PREFIX_LOCK | PREFIX_DATA
-                                | PREFIX_REPZ | PREFIX_REPNZ))) {
-                goto illegal_op;
-            }
-            gen_lea_modrm(env, s, modrm);
-            tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
-                                  cpu_regs[R_EDX]);
-            gen_helper_xrstor(tcg_env, s->A0, s->tmp1_i64);
-            /* XRSTOR is how MPX is enabled, which changes how
-               we translate.  Thus we need to end the TB.  */
-            s->base.is_jmp = DISAS_EOB_NEXT;
-            break;
-
-        CASE_MODRM_MEM_OP(6): /* xsaveopt / clwb */
-            if (prefixes & PREFIX_LOCK) {
-                goto illegal_op;
-            }
-            if (prefixes & PREFIX_DATA) {
-                /* clwb */
-                if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLWB)) {
-                    goto illegal_op;
-                }
-                gen_nop_modrm(env, s, modrm);
-            } else {
-                /* xsaveopt */
-                if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                    || (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT) == 0
-                    || (prefixes & (PREFIX_REPZ | PREFIX_REPNZ))) {
-                    goto illegal_op;
-                }
-                gen_lea_modrm(env, s, modrm);
-                tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
-                                      cpu_regs[R_EDX]);
-                gen_helper_xsaveopt(tcg_env, s->A0, s->tmp1_i64);
-            }
-            break;
-
-        CASE_MODRM_MEM_OP(7): /* clflush / clflushopt */
-            if (prefixes & PREFIX_LOCK) {
-                goto illegal_op;
-            }
-            if (prefixes & PREFIX_DATA) {
-                /* clflushopt */
-                if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLFLUSHOPT)) {
-                    goto illegal_op;
-                }
-            } else {
-                /* clflush */
-                if ((s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))
-                    || !(s->cpuid_features & CPUID_CLFLUSH)) {
-                    goto illegal_op;
-                }
-            }
-            gen_nop_modrm(env, s, modrm);
-            break;
-
-        case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
-        case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
-        case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
-        case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
-            if (CODE64(s)
-                && (prefixes & PREFIX_REPZ)
-                && !(prefixes & PREFIX_LOCK)
-                && (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE)) {
-                TCGv base, treg, src, dst;
-
-                /* Preserve hflags bits by testing CR4 at runtime.  */
-                tcg_gen_movi_i32(s->tmp2_i32, CR4_FSGSBASE_MASK);
-                gen_helper_cr4_testbit(tcg_env, s->tmp2_i32);
-
-                base = cpu_seg_base[modrm & 8 ? R_GS : R_FS];
-                treg = cpu_regs[(modrm & 7) | REX_B(s)];
-
-                if (modrm & 0x10) {
-                    /* wr*base */
-                    dst = base, src = treg;
-                } else {
-                    /* rd*base */
-                    dst = treg, src = base;
-                }
-
-                if (s->dflag == MO_32) {
-                    tcg_gen_ext32u_tl(dst, src);
-                } else {
-                    tcg_gen_mov_tl(dst, src);
-                }
-                break;
-            }
-            goto unknown_op;
-
-        case 0xf8 ... 0xff: /* sfence */
-            if (!(s->cpuid_features & CPUID_SSE)
-                || (prefixes & PREFIX_LOCK)) {
-                goto illegal_op;
-            }
-            tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
-            break;
-        case 0xe8 ... 0xef: /* lfence */
-            if (!(s->cpuid_features & CPUID_SSE)
-                || (prefixes & PREFIX_LOCK)) {
-                goto illegal_op;
-            }
-            tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
-            break;
-        case 0xf0 ... 0xf7: /* mfence */
-            if (!(s->cpuid_features & CPUID_SSE2)
-                || (prefixes & PREFIX_LOCK)) {
-                goto illegal_op;
-            }
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-            break;
-
-        default:
-            goto unknown_op;
-        }
-        break;
-
     case 0x1aa: /* rsm */
         gen_svm_check_intercept(s, SVM_EXIT_RSM);
         if (!(s->flags & HF_SMM_MASK))
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 4e745f10dd8..1c6fa39c3eb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -269,20 +269,41 @@ static inline const X86OpEntry *decode_by_prefix(DisasContext *s, const X86OpEnt
 
 static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    /* only includes ldmxcsr and stmxcsr, because they have AVX variants.  */
     static const X86OpEntry group15_reg[8] = {
+        [0] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
+        [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
+        [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
+        [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
     };
 
     static const X86OpEntry group15_mem[8] = {
-        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128)),
-        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128)),
+        [0] = X86_OP_ENTRYw(FXSAVE,     M,y, cpuid(FXSR) p_00),
+        [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
+        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
+        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
+        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00),
+        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00),
+        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00),
+        [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
+    };
+
+    static const X86OpEntry group15_mem_66[8] = {
+        [6] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLWB)),
+        [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSHOPT)),
     };
 
     uint8_t modrm = get_modrm(s, env);
+    int op = (modrm >> 3) & 7;
+
     if ((modrm >> 6) == 3) {
-        *entry = group15_reg[(modrm >> 3) & 7];
+        *entry = group15_reg[op];
+    } else if (s->prefix & PREFIX_DATA) {
+        *entry = group15_mem_66[op];
     } else {
-        *entry = group15_mem[(modrm >> 3) & 7];
+        *entry = group15_mem[op];
     }
 }
 
@@ -2094,6 +2115,10 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return true;
     case X86_FEAT_CMOV:
         return (s->cpuid_features & CPUID_CMOV);
+    case X86_FEAT_CLFLUSH:
+        return (s->cpuid_features & CPUID_CLFLUSH);
+    case X86_FEAT_FXSR:
+        return (s->cpuid_features & CPUID_FXSR);
     case X86_FEAT_F16C:
         return (s->cpuid_ext_features & CPUID_EXT_F16C);
     case X86_FEAT_FMA:
@@ -2127,6 +2152,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
 
     case X86_FEAT_AVX:
         return (s->cpuid_ext_features & CPUID_EXT_AVX);
+    case X86_FEAT_XSAVE:
+        return (s->cpuid_ext_features & CPUID_EXT_XSAVE);
 
     case X86_FEAT_3DNOW:
         return (s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
@@ -2141,11 +2168,20 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI2);
     case X86_FEAT_AVX2:
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
+    case X86_FEAT_CLFLUSHOPT:
+        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLFLUSHOPT);
+    case X86_FEAT_CLWB:
+        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLWB);
+    case X86_FEAT_FSGSBASE:
+        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE);
     case X86_FEAT_SHA_NI:
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SHA_NI);
 
     case X86_FEAT_CMPCCXADD:
         return (s->cpuid_7_1_eax_features & CPUID_7_1_EAX_CMPCCXADD);
+
+    case X86_FEAT_XSAVEOPT:
+        return (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT);
     }
     g_assert_not_reached();
 }
@@ -2480,7 +2516,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             case 0x1a ... 0x1b: /* MPX */
             case 0x30 ... 0x35: /* more privileged instructions */
             case 0xa2 ... 0xa5: /* CPUID, BT, SHLD */
-            case 0xaa ... 0xae: /* RSM, SHRD, grp15 */
+            case 0xaa ... 0xad: /* RSM, SHRD */
             case 0xb0 ... 0xb1: /* cmpxchg */
             case 0xb3:          /* btr */
             case 0xb8:          /* integer ops */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bcb6bccbd75..5ca3764e006 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1653,6 +1653,22 @@ static void gen_EXTRQ_r(DisasContext *s, X86DecodedInsn *decode)
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_FXRSTOR(DisasContext *s, X86DecodedInsn *decode)
+{
+    if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
+        gen_NM_exception(s);
+    }
+    gen_helper_fxrstor(tcg_env, s->A0);
+}
+
+static void gen_FXSAVE(DisasContext *s, X86DecodedInsn *decode)
+{
+    if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
+        gen_NM_exception(s);
+    }
+    gen_helper_fxsave(tcg_env, s->A0);
+}
+
 static void gen_HLT(DisasContext *s, X86DecodedInsn *decode)
 {
 #ifdef CONFIG_SYSTEM_ONLY
@@ -2000,6 +2016,11 @@ static void gen_LES(DisasContext *s, X86DecodedInsn *decode)
     gen_lxx_seg(s, decode, R_ES);
 }
 
+static void gen_LFENCE(DisasContext *s, X86DecodedInsn *decode)
+{
+    tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
+}
+
 static void gen_LFS(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_lxx_seg(s, decode, R_FS);
@@ -2059,6 +2080,11 @@ static void gen_LSS(DisasContext *s, X86DecodedInsn *decode)
     gen_lxx_seg(s, decode, R_SS);
 }
 
+static void gen_MFENCE(DisasContext *s, X86DecodedInsn *decode)
+{
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+}
+
 static void gen_MOV(DisasContext *s, X86DecodedInsn *decode)
 {
     /* nothing to do! */
@@ -3092,6 +3118,15 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
+
+    /* Preserve hflags bits by testing CR4 at runtime.  */
+    gen_helper_cr4_testbit(tcg_env, tcg_constant_i32(CR4_FSGSBASE_MASK));
+    tcg_gen_mov_tl(s->T0, base);
+}
+
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
     int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
@@ -3372,6 +3407,11 @@ static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
     gen_setcc1(s, decode->b & 0xf, s->T0);
 }
 
+static void gen_SFENCE(DisasContext *s, X86DecodedInsn *decode)
+{
+    tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
@@ -4042,6 +4082,15 @@ static void gen_WAIT(DisasContext *s, X86DecodedInsn *decode)
     }
 }
 
+static void gen_WRxxBASE(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv base = cpu_seg_base[s->modrm & 8 ? R_GS : R_FS];
+
+    /* Preserve hflags bits by testing CR4 at runtime.  */
+    gen_helper_cr4_testbit(tcg_env, tcg_constant_i32(CR4_FSGSBASE_MASK));
+    tcg_gen_mov_tl(base, s->T0);
+}
+
 static void gen_XCHG(DisasContext *s, X86DecodedInsn *decode)
 {
     if (s->prefix & PREFIX_LOCK) {
@@ -4084,3 +4133,34 @@ static void gen_XOR(DisasContext *s, X86DecodedInsn *decode)
         prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
     }
 }
+
+static void gen_XRSTOR(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv_i64 features = tcg_temp_new_i64();
+
+    tcg_gen_concat_tl_i64(features, cpu_regs[R_EAX], cpu_regs[R_EDX]);
+    gen_helper_xrstor(tcg_env, s->A0, features);
+    if (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_MPX) {
+        /*
+         * XRSTOR is how MPX is enabled, which changes how
+         * we translate.  Thus we need to end the TB.
+         */
+        s->base.is_jmp = DISAS_EOB_NEXT;
+    }
+}
+
+static void gen_XSAVE(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv_i64 features = tcg_temp_new_i64();
+
+    tcg_gen_concat_tl_i64(features, cpu_regs[R_EAX], cpu_regs[R_EDX]);
+    gen_helper_xsave(tcg_env, s->A0, features);
+}
+
+static void gen_XSAVEOPT(DisasContext *s, X86DecodedInsn *decode)
+{
+    TCGv_i64 features = tcg_temp_new_i64();
+
+    tcg_gen_concat_tl_i64(features, cpu_regs[R_EAX], cpu_regs[R_EDX]);
+    gen_helper_xsave(tcg_env, s->A0, features);
+}
-- 
2.45.1


