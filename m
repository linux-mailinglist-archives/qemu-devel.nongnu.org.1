Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D817C9403
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:03:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTG-0002ag-Kd; Sat, 14 Oct 2023 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT1-0002Zj-IE
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSz-000411-FB
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIEBS5WcbCIH/XcvSSeHQPKzHK4MbC/UM6H3HdBQbig=;
 b=Polj/kQ0DCj3c/sxAB9QTiTJ+M8rpmUdX8RXp8eHgvBo9kuMlZN8dA9yrYZIr+UXOYtpMd
 v0UYiWc1u0WVOhTFVr3cs8ePrw5NYeVBns6iHWWcDaGzegQYKhI7i+Z9ln/1BI2sJTXDBo
 NUCKWeTTDK3+DU6uz+RgHEeHm6QLZHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-cjmDjnR2Px-O2JBUngiJng-1; Sat, 14 Oct 2023 06:01:40 -0400
X-MC-Unique: cjmDjnR2Px-O2JBUngiJng-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso221753666b.1
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277699; x=1697882499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIEBS5WcbCIH/XcvSSeHQPKzHK4MbC/UM6H3HdBQbig=;
 b=b9pPNZ4RxIRW4ARV6ZB+WbkQm+lz84HHIF3LzGhKYxC/YK8h9m8V4GYu+VcHyekbX0
 gKitwEae2j+dMyfC/J5nUmDx3+39TMlUqmuFhySjqz/8lJyM3UMiQbLoaNgDjHz7rLc2
 WZ8mEertzoOHhrEEjfHqK+R4YHLwv3d4pqvME095APPpMC28BSoPa4stlY//QDalicUY
 YBNZ1trt2ipmuXsJMSdir+UHg7ASTvbmcxV+M/KS668DS4SnQVQv9qP9ID351njbRaIR
 h+MCAUbfPSD7fPszZq2teaWRAygx+Be4kBwji/v+ZgDyur2Q1ijCQE+/6O9iNRj+eWS+
 BQVg==
X-Gm-Message-State: AOJu0Yz2Zz3+IXP9E/4JwX2qi36hgmqRwXnIgsjO02XCZJlZJ5oHZduh
 B4gKJ3he0z4cB993wfCyduw0Z30JCSvG64KlGZSnUH8Q6UXvIRTrrC2nySYIDiK62yiDyUkHTXE
 xqjVBBJEnolc+8J++med0e5eo+1fwEJQAqV7ifGFeUeZoknuvg4RfTlvS0/ZqREw+3n6AHWkOw7
 M=
X-Received: by 2002:a17:907:869f:b0:9bf:388e:8e97 with SMTP id
 qa31-20020a170907869f00b009bf388e8e97mr242150ejc.67.1697277698641; 
 Sat, 14 Oct 2023 03:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwXGp7NkKs95NM+hJRz8Ivfp6IHPw5kkeW2ZCyRvO3iPdkAXuTXgEkFS1wlHrHCGjWaxzOIQ==
X-Received: by 2002:a17:907:869f:b0:9bf:388e:8e97 with SMTP id
 qa31-20020a170907869f00b009bf388e8e97mr242125ejc.67.1697277697890; 
 Sat, 14 Oct 2023 03:01:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 mr8-20020a170907828800b009b94a8150d8sm730629ejc.199.2023.10.14.03.01.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/18] target/i386: implement CMPccXADD
Date: Sat, 14 Oct 2023 12:01:10 +0200
Message-ID: <20231014100121.109817-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/cpu.c                |  2 +-
 target/i386/tcg/decode-new.c.inc | 30 ++++++++++
 target/i386/tcg/decode-new.h     |  2 +
 target/i386/tcg/emit.c.inc       | 98 ++++++++++++++++++++++++++++++++
 target/i386/tcg/translate.c      |  2 +
 5 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8beb989701c..80f0445301b 100644
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
index bad561ff66d..01c46e6a789 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -516,6 +516,28 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0xdd] = X86_OP_ENTRY3(VAESENCLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
     [0xde] = X86_OP_ENTRY3(VAESDEC,     V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
     [0xdf] = X86_OP_ENTRY3(VAESDECLAST, V,x,  H,x,       W,x,  vex4 cpuid(AES) p_66),
+
+    /*
+     * REG selects srcdest2 operand, VEX.vvvv selects src3.  VEX class not found
+     * in manual, assumed to be 13 from the VEX.L0 = constraint.
+     */
+    [0xe0] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe1] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe2] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe3] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe4] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe5] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe6] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe7] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+
+    [0xe8] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xe9] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xea] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xeb] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xec] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xed] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xee] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
+    [0xef] = X86_OP_ENTRY3(CMPccXADD,   EM,y, G,y, B,y,  vex13 xchg chk(o64) cpuid(CMPCCXADD) p_66),
 };
 
 /* five rows for no prefix, 66, F3, F2, 66+F2  */
@@ -1273,8 +1295,13 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
 
     case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
         op->unit = X86_OP_SSE;
+        goto get_modrm_mem;
+
+    case X86_TYPE_EM:  /* modrm byte selects an ALU memory operand */
+        op->unit = X86_OP_INT;
         /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
+    get_modrm_mem:
         modrm = get_modrm(s, env);
         if ((modrm >> 6) == 3) {
             return false;
@@ -1511,6 +1538,9 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
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
index b2879136614..b22de02ce54 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -47,6 +47,7 @@ typedef enum X86OpType {
     X86_TYPE_Y, /* string destination */
 
     /* Custom */
+    X86_TYPE_EM, /* modrm byte selects an ALU memory operand */
     X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
     X86_TYPE_2op, /* 2-operand RMW instruction */
     X86_TYPE_LoBits, /* encoded in bits 0-2 of the operand + REX.B */
@@ -104,6 +105,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
     X86_FEAT_MOVBE,
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index b5dfdc409e5..9f70e9dbaa6 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1168,6 +1168,104 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
+static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGv z_tl = tcg_constant_tl(0);
+    TCGLabel *label_top = gen_new_label();
+    TCGLabel *label_bottom = gen_new_label();
+    TCGv oldv = tcg_temp_new();
+    TCGv memv = tcg_temp_new();
+    TCGv newv = tcg_temp_new();
+    TCGv cmpv = tcg_temp_new();
+    TCGv tmp_cc = tcg_temp_new();
+
+    TCGv cmp_lhs, cmp_rhs;
+    MemOp ot, ot_full;
+
+    int jcc_op = (decode->b >> 1) & 7;
+    static const uint8_t cond[16] = {
+        TCG_COND_NE,  /* o, just test OF=1 */
+        TCG_COND_EQ,  /* no, just test OF=0 */
+        TCG_COND_LTU, /* b */
+        TCG_COND_GEU, /* ae (nb) */
+        TCG_COND_EQ,  /* z */
+        TCG_COND_NE,  /* nz */
+        TCG_COND_LEU, /* be */
+        TCG_COND_GTU, /* a (nbe) */
+        TCG_COND_LT,  /* s, compares result against 0 */
+        TCG_COND_GE,  /* ns, compares result against 0 */
+        TCG_COND_NE,  /* p, just test PF=1 */
+        TCG_COND_EQ,  /* np, just test PF=0 */
+        TCG_COND_LT,  /* l */
+        TCG_COND_GE,  /* ge (nl) */
+        TCG_COND_LE,  /* le */
+        TCG_COND_GT,  /* g (nle) */
+    };
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
+    gen_ext_tl(cmpv, cpu_regs[decode->op[1].n], ot_full);
+
+    /*
+     * Cmpxchg loop starts here.
+     * s->A0: dest address; cmpv: compare operand; s->T1: addition operand.
+     */
+    gen_set_label(label_top);
+    gen_op_ld_v(s, ot_full, memv, s->A0);
+    tcg_gen_sub_tl(s->T0, memv, cmpv);
+
+    /* Compute comparison result but do not clobber cc_* yet.  */
+    switch (jcc_op) {
+    case JCC_O:
+    case JCC_P:
+        tcg_gen_sub_tl(s->T0, memv, cmpv);
+        gen_helper_cc_compute_all(tmp_cc, s->T0, cmpv, z_tl,
+                                  tcg_constant_i32(CC_OP_SUBB + ot));
+        decode->cc_src = tmp_cc;
+        set_cc_op(s, CC_OP_EFLAGS);
+
+        tcg_gen_andi_tl(s->T0, tmp_cc, (jcc_op == JCC_O ? CC_O : CC_P));
+        cmp_lhs = s->T0, cmp_rhs = z_tl;
+        break;
+
+    case JCC_S:
+        cmp_lhs = s->T0, cmp_rhs = z_tl;
+        goto cc_sub;
+
+    default:
+        cmp_lhs = memv, cmp_rhs = cmpv;
+    cc_sub:
+        decode->cc_dst = s->T0;
+        decode->cc_src = cmpv;
+        decode->cc_srcT = memv;
+        set_cc_op(s, CC_OP_SUBB + ot);
+        break;
+    }
+
+    /* Compute new value: if condition does not hold, just store back memv */
+    tcg_gen_add_tl(newv, memv, s->T1);
+    tcg_gen_movcond_tl(cond[decode->b & 15], newv, cmp_lhs, cmp_rhs, newv, memv);
+    tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, memv, newv, s->mem_index, ot_full);
+
+    /* Exit unconditionally if cmpxchg succeeded.  */
+    tcg_gen_brcond_tl(TCG_COND_EQ, oldv, memv, label_bottom);
+
+    /* Try again if there was actually a store to make.  */
+    tcg_gen_brcond_tl(cond[decode->b & 15], cmp_lhs, cmp_rhs, label_top);
+    gen_set_label(label_bottom);
+
+    /* Store old value only after a successful store.  */
+    gen_writeback(s, decode, 1, memv);
+}
+
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d7d6c85877d..038151a8c3e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -122,6 +122,7 @@ typedef struct DisasContext {
     int cpuid_ext3_features;
     int cpuid_7_0_ebx_features;
     int cpuid_7_0_ecx_features;
+    int cpuid_7_1_eax_features;
     int cpuid_xsave_features;
 
     /* TCG local temps */
@@ -6957,6 +6958,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_ext3_features = env->features[FEAT_8000_0001_ECX];
     dc->cpuid_7_0_ebx_features = env->features[FEAT_7_0_EBX];
     dc->cpuid_7_0_ecx_features = env->features[FEAT_7_0_ECX];
+    dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
-- 
2.41.0


