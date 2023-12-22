Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504D81CE55
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4u-0001HH-E9; Fri, 22 Dec 2023 13:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4t-0001CI-0M
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4q-0006FL-5r
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WupHyJmuUNt7ysKhkT0O9XkGJqqDUaEHoe9me/DKx4=;
 b=Gu7GfCuYQUNPNow5WijfKqp67XPUNJ+1dagwEKYVTLMOyRACYqKEMn6yw8doHFsib/pOjF
 8Ava9ZF/DdBEW29MVhg33C1GdD6R9PoK05YMc0RmMjmMktHAv1np/v+pYlACdh4HqPVPwC
 qZN3zO+ddX0hiV8ohnnCpVaqGxxERno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-2YR4UKEpP3-BBQ7_ZVoZIw-1; Fri, 22 Dec 2023 13:16:50 -0500
X-MC-Unique: 2YR4UKEpP3-BBQ7_ZVoZIw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d427df857so11025625e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703269008; x=1703873808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WupHyJmuUNt7ysKhkT0O9XkGJqqDUaEHoe9me/DKx4=;
 b=cIvoNqilihKGUUkgLYfj6Uyy8gY9vaX8eCrTKWnF40NiFH+GwizEj5zpLkv2eMsgRc
 RlJ3bTcDRvThgd41Mzel9vxNsRQc4jYIzlTZ56Kkps2z9gOCpRADG0A0vdRBzdxb9oQd
 1Z010bO91gphAwRkFNxe9K7PH9oCeIPXjgZ5ZYfCngoiHftbt2zRxVAO1wG6iKfDmcrw
 2YRa0zu9zyysU78ssmQhi2sasuggwocFZmKMbfc/npbpAMIbolWyfCi00xGPQ6si7jFg
 l8s8iKJxn0uieB1bOgNrvf+4d6ykf7ASR3Fgyh2OEg8uyDA41rv31eMlKisoV3RUW0Q2
 UJDA==
X-Gm-Message-State: AOJu0Yxk7Fr7haa8woSI7OtsCwl20XoIiUQGM0DpsnmEYRsDgHi4YW+/
 PaajXzW5POdjrs0QNuD45EAUJ3gPYDqSpMTM9Fg+8LY5r7HiSnoIPFbgdt/Vy04hUJZxY1Qjy32
 RsfMSpmbEQw52m8nBHVPBpjlO+Y0kCS4cTmEfwcRDtEanvtsLt0kZC5US/QfLkREFT5u/bLZTYU
 gsI4REER8=
X-Received: by 2002:a05:600c:2342:b0:40c:532b:7a30 with SMTP id
 2-20020a05600c234200b0040c532b7a30mr931450wmq.202.1703269008434; 
 Fri, 22 Dec 2023 10:16:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFL9tQXdHIqA+l/AC63bb6K7oFE8YAYLryu+DqWIeziyJtEt1pHv+dd0OR4NWLNhXluFdKhg==
X-Received: by 2002:a05:600c:2342:b0:40c:532b:7a30 with SMTP id
 2-20020a05600c234200b0040c532b7a30mr931441wmq.202.1703269007976; 
 Fri, 22 Dec 2023 10:16:47 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ez11-20020a056402450b00b005532f5abaedsm2869998edb.72.2023.12.22.10.16.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/22] target/i386: implement CMPccXADD
Date: Fri, 22 Dec 2023 19:16:03 +0100
Message-ID: <20231222181603.174137-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
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

The main difficulty here is that a page fault when writing to the destination
must not overwrite the flags.  Therefore, the compute-flags helper must be
called with a temporary destination instead of using gen_jcc1*.

For simplicity, I am using an unconditional cmpxchg operation, that becomes
a NOP if the comparison fails.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c                |   2 +-
 target/i386/tcg/decode-new.c.inc |  25 ++++++++
 target/i386/tcg/decode-new.h     |   1 +
 target/i386/tcg/emit.c.inc       | 104 +++++++++++++++++++++++++++++++
 target/i386/tcg/translate.c      |   2 +
 5 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 95d5f16cd5e..fd47ee7defb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -738,7 +738,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_0_EDX_FEATURES (CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_KERNEL_FEATURES)
 
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
-          CPUID_7_1_EAX_FSRC)
+          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
 #define TCG_7_1_EDX_FEATURES 0
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 717d7307722..426c4594120 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -538,6 +538,28 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0xdd] = X86_OP_ENTRY3(VAESENCLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
     [0xde] = X86_OP_ENTRY3(VAESDEC,     V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
     [0xdf] = X86_OP_ENTRY3(VAESDECLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
+
+    /*
+     * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
+     * in manual, assumed to be 13 from the VEX.L0 constraint.
+     */
+    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+
+    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xea] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xec] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xed] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xee] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xef] = X86_OP_ENTRY3(CMPccXADD,   M,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
 };
 
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
@@ -1503,6 +1525,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
     case X86_FEAT_SHA_NI:
         return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SHA_NI);
+
+    case X86_FEAT_CMPCCXADD:
+        return (s->cpuid_7_1_eax_features & CPUID_7_1_EAX_CMPCCXADD);
     }
     g_assert_not_reached();
 }
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 25220fc4362..15e6bfef4b1 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -104,6 +104,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
     X86_FEAT_MOVBE,
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fd120e7b9b4..f05f79e1f62 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1190,6 +1190,109 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
+static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *label_top = gen_new_label();
+    TCGLabel *label_bottom = gen_new_label();
+    TCGv oldv = tcg_temp_new();
+    TCGv newv = tcg_temp_new();
+    TCGv cmpv = tcg_temp_new();
+    TCGCond cond;
+
+    TCGv cmp_lhs, cmp_rhs;
+    MemOp ot, ot_full;
+
+    int jcc_op = (decode->b >> 1) & 7;
+    static const TCGCond cond_table[8] = {
+        [JCC_O] = TCG_COND_LT,  /* test sign bit by comparing against 0 */
+        [JCC_B] = TCG_COND_LTU,
+        [JCC_Z] = TCG_COND_EQ,
+        [JCC_BE] = TCG_COND_LEU,
+        [JCC_S] = TCG_COND_LT,  /* test sign bit by comparing against 0 */
+        [JCC_P] = TCG_COND_EQ,  /* even parity - tests low bit of popcount */
+        [JCC_L] = TCG_COND_LT,
+        [JCC_LE] = TCG_COND_LE,
+    };
+
+    cond = cond_table[jcc_op];
+    if (decode->b & 1) {
+        cond = tcg_invert_cond(cond);
+    }
+
+    ot = decode->op[0].ot;
+    ot_full = ot | MO_LE;
+    if (jcc_op >= JCC_S) {
+        /*
+         * Sign-extend values before subtracting for S, P (zero/sign extension
+         * does not matter there) L, LE and their inverses.
+         */
+        ot_full |= MO_SIGN;
+    }
+
+    /*
+     * cmpv will be moved to cc_src *after* cpu_regs[] is written back, so use
+     * tcg_gen_ext_tl instead of gen_ext_tl.
+     */
+    tcg_gen_ext_tl(cmpv, cpu_regs[decode->op[1].n], ot_full);
+
+    /*
+     * Cmpxchg loop starts here.
+     * - s->T1: addition operand (from decoder)
+     * - s->A0: dest address (from decoder)
+     * - s->cc_srcT: memory operand (lhs for comparison)
+     * - cmpv: rhs for comparison
+     */
+    gen_set_label(label_top);
+    gen_op_ld_v(s, ot_full, s->cc_srcT, s->A0);
+    tcg_gen_sub_tl(s->T0, s->cc_srcT, cmpv);
+
+    /* Compute the comparison result by hand, to avoid clobbering cc_*.  */
+    switch (jcc_op) {
+    case JCC_O:
+        /* (src1 ^ src2) & (src1 ^ dst). newv is only used here for a moment */
+        tcg_gen_xor_tl(newv, s->cc_srcT, s->T0);
+        tcg_gen_xor_tl(s->tmp0, s->cc_srcT, cmpv);
+        tcg_gen_and_tl(s->tmp0, s->tmp0, newv);
+        tcg_gen_sextract_tl(s->tmp0, s->tmp0, 0, 8 << ot);
+        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        break;
+
+    case JCC_P:
+        tcg_gen_ext8u_tl(s->tmp0, s->T0);
+        tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
+        tcg_gen_andi_tl(s->tmp0, s->tmp0, 1);
+        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        break;
+
+    case JCC_S:
+        cmp_lhs = s->T0, cmp_rhs = tcg_constant_tl(0);
+        break;
+
+    default:
+        cmp_lhs = s->cc_srcT, cmp_rhs = cmpv;
+        break;
+    }
+
+    /* Compute new value: if condition does not hold, just store back s->cc_srcT */
+    tcg_gen_add_tl(newv, s->cc_srcT, s->T1);
+    tcg_gen_movcond_tl(cond, newv, cmp_lhs, cmp_rhs, newv, s->cc_srcT);
+    tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, s->cc_srcT, newv, s->mem_index, ot_full);
+
+    /* Exit unconditionally if cmpxchg succeeded.  */
+    tcg_gen_brcond_tl(TCG_COND_EQ, oldv, s->cc_srcT, label_bottom);
+
+    /* Try again if there was actually a store to make.  */
+    tcg_gen_brcond_tl(cond, cmp_lhs, cmp_rhs, label_top);
+    gen_set_label(label_bottom);
+
+    /* Store old value to registers only after a successful store.  */
+    gen_writeback(s, decode, 1, s->cc_srcT);
+
+    decode->cc_dst = s->T0;
+    decode->cc_src = cmpv;
+    decode->cc_op = CC_OP_SUBB + ot;
+}
+
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 53b98d5e6ac..c6bb215d68a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -122,6 +122,7 @@ typedef struct DisasContext {
     int cpuid_ext3_features;
     int cpuid_7_0_ebx_features;
     int cpuid_7_0_ecx_features;
+    int cpuid_7_1_eax_features;
     int cpuid_xsave_features;
 
     /* TCG local temps */
@@ -6973,6 +6974,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_ext3_features = env->features[FEAT_8000_0001_ECX];
     dc->cpuid_7_0_ebx_features = env->features[FEAT_7_0_EBX];
     dc->cpuid_7_0_ecx_features = env->features[FEAT_7_0_ECX];
+    dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
-- 
2.43.0


