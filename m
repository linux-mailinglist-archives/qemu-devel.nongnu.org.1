Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A40767CF5A7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYY-0006YR-S5; Thu, 19 Oct 2023 06:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYW-0006Xl-Oy
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYU-0006Dc-Tw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ypl19ID9rWp7SnfV9jL8pJ7ArDpt8Bkcpd7SvsYCvJI=;
 b=W1iWnJ2uYLYxWdWYlZ7qNzfATW+3erhplOB2Tg0kv5mn3zzhlgydanUkIXU2c9Izcw+3es
 IDq4w9mtlke+Hic5CLD6AGUi6+9kqxQP9pc+fBrFUyVDy8C2V0HKLDa6mop9aeRi83j4Ip
 0R4ZuyYTNKocMTebja8chN1kz7gb3lc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-BeZkAr0oMxuDyh_rwzquqQ-1; Thu, 19 Oct 2023 06:46:55 -0400
X-MC-Unique: BeZkAr0oMxuDyh_rwzquqQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079630993dso6784276e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712413; x=1698317213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ypl19ID9rWp7SnfV9jL8pJ7ArDpt8Bkcpd7SvsYCvJI=;
 b=X4928y9LB7lST0dooYaw8H5GPPGF5Qlx9JxKse0u5f6/xYd1DVm6KSzK8FSmQV7Fyv
 nDd92pXoflXeM3WLCfqhndvEv+8QWFxMsB562N6X0rlsFKJ/DWJWoM2xOJ2zO8U3zN56
 GquJfibSkoMFyYlX6RFHHJOaBAdRIymSZzLcN7Jy5Ltr4D86hZ0zPAskt9mLfBuydQv1
 e6Dtw8O04KZREWrSiDZBJfDdrwHJQ+dGHbSGkEYqo8aUTQiDP5f8XL0G+1k4xrj7fetp
 I5gSPGi5Qp6NQ9bx880M0W7y2eu5DJv0FDHFaPA/VO14s9oUYJ+m+B6//Ps6T2pf0z97
 jklg==
X-Gm-Message-State: AOJu0Yw8MvlyL3jGAlTMRMcfHSUif+e9WdPVSJ4RU3GmYE183sNrgcxw
 /alVCrHMhJkcmLE9a/BULlYKPyzovNa2Ly5GSFL9QcLWwW4SsF659wFU0B/U7FDAhsJVcQNT8V4
 eXh08X8CTNWOpL4SIByyrwv1XlhCh05uvHyfqce/ZNmbydRaMpSlNFnRUaOwZqbmUq24OLjr5/z
 Y=
X-Received: by 2002:a05:6512:33ce:b0:503:257a:7f5d with SMTP id
 d14-20020a05651233ce00b00503257a7f5dmr1365635lfg.31.1697712412813; 
 Thu, 19 Oct 2023 03:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBwFtCL67NumZflLUDy7nS/GG6pFa5pqZAzlkREcoLdgqVvSzBf8N5BDV1+sUufy4pgNOSmQ==
X-Received: by 2002:a05:6512:33ce:b0:503:257a:7f5d with SMTP id
 d14-20020a05651233ce00b00503257a7f5dmr1365616lfg.31.1697712412248; 
 Thu, 19 Oct 2023 03:46:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 d29-20020a50f69d000000b0053daf92f0easm4260318edn.97.2023.10.19.03.46.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/19] target/i386: group common checks in the decoding
 phase
Date: Thu, 19 Oct 2023 12:46:30 +0200
Message-ID: <20231019104648.389942-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation for adding more similar checks, move the VEX.L=0 check
and several X86_SPECIAL_* checks to a new field, where each bit represent
a common check on unused bits, or a restriction on the processor mode.

Likewise, many SVM intercepts can be checked during the decoding phase,
the main exception being the selective CR0 write, MSR and IOIO intercepts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 79 +++++++++++++++++++++++---------
 target/i386/tcg/decode-new.h     | 25 +++++++---
 target/i386/tcg/emit.c.inc       |  8 ----
 3 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7d76f152758..790339eaf25 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -90,8 +90,6 @@
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
-#define i64 .special = X86_SPECIAL_i64,
-#define o64 .special = X86_SPECIAL_o64,
 #define xchg .special = X86_SPECIAL_Locked,
 #define mmx .special = X86_SPECIAL_MMX,
 #define zext0 .special = X86_SPECIAL_ZExtOp0,
@@ -114,6 +112,9 @@
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
 
+#define chk(a) .check = X86_CHECK_##a,
+#define svm(a) .intercept = SVM_EXIT_##a,
+
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
 
 #define P_00          1
@@ -161,8 +162,8 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
     };
 
     static const X86OpEntry group15_mem[8] = {
-        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5),
-        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5),
+        [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128)),
+        [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128)),
     };
 
     uint8_t modrm = get_modrm(s, env);
@@ -1579,6 +1580,12 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
+
+    if (e->check & X86_CHECK_VEX128) {
+        if (s->vex_l) {
+            goto illegal;
+        }
+    }
     return true;
 
 nm_exception:
@@ -1764,6 +1771,25 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         goto illegal_op;
     }
 
+    /* Checks that result in #UD come first.  */
+    if (decode.e.check) {
+        if (decode.e.check & X86_CHECK_i64) {
+            if (CODE64(s)) {
+                goto illegal_op;
+            }
+        }
+        if (decode.e.check & X86_CHECK_o64) {
+            if (!CODE64(s)) {
+                goto illegal_op;
+            }
+        }
+        if (decode.e.check & X86_CHECK_prot) {
+            if (!PE(s) || VM86(s)) {
+                goto illegal_op;
+            }
+        }
+    }
+
     switch (decode.e.special) {
     case X86_SPECIAL_None:
         break;
@@ -1774,23 +1800,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case X86_SPECIAL_ProtMode:
-        if (!PE(s) || VM86(s)) {
-            goto illegal_op;
-        }
-        break;
-
-    case X86_SPECIAL_i64:
-        if (CODE64(s)) {
-            goto illegal_op;
-        }
-        break;
-    case X86_SPECIAL_o64:
-        if (!CODE64(s)) {
-            goto illegal_op;
-        }
-        break;
-
     case X86_SPECIAL_ZExtOp0:
         assert(decode.op[0].unit == X86_OP_INT);
         if (!decode.op[0].has_ea) {
@@ -1820,6 +1829,31 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     if (!validate_vex(s, &decode)) {
         return;
     }
+
+    /*
+     * Checks that result in #GP or VMEXIT come second.  Intercepts are
+     * generally checked after non-memory exceptions (i.e. before all
+     * exceptions if there is no memory operand).  Exceptions are
+     * vm86 checks (INTn, IRET, PUSHF/POPF), RSM and XSETBV (!).
+     *
+     * RSM and XSETBV will be handled in the gen_* functions
+     * instead of using chk().
+     */
+    if (decode.e.check & X86_CHECK_cpl0) {
+        if (CPL(s) != 0) {
+            goto gp_fault;
+        }
+    }
+    if (decode.e.intercept && unlikely(GUEST(s))) {
+        gen_helper_svm_check_intercept(tcg_env,
+                                       tcg_constant_i32(decode.e.intercept));
+    }
+    if (decode.e.check & X86_CHECK_vm86_iopl) {
+        if (VM86(s) && IOPL(s) < 3) {
+            goto gp_fault;
+        }
+    }
+
     if (decode.e.special == X86_SPECIAL_MMX &&
         !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
         gen_helper_enter_mmx(tcg_env);
@@ -1846,6 +1880,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         gen_writeback(s, &decode, 0, s->T0);
     }
     return;
+ gp_fault:
+    gen_exception_gpf(s);
+    return;
  illegal_op:
     gen_illegal_opcode(s);
     return;
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a542ec16813..631d39220bb 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -130,15 +130,28 @@ typedef enum X86OpUnit {
     X86_OP_MMX,     /* address in either s->ptrX or s->A0 depending on has_ea */
 } X86OpUnit;
 
+typedef enum X86InsnCheck {
+    /* Illegal or exclusive to 64-bit mode */
+    X86_CHECK_i64 = 1,
+    X86_CHECK_o64 = 2,
+
+    /* Fault outside protected mode */
+    X86_CHECK_prot = 4,
+
+    /* Privileged instruction checks */
+    X86_CHECK_cpl0 = 8,
+    X86_CHECK_vm86_iopl = 16,
+
+    /* Fault if VEX.L=1 */
+    X86_CHECK_VEX128 = 32,
+} X86InsnCheck;
+
 typedef enum X86InsnSpecial {
     X86_SPECIAL_None,
 
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
-    /* Fault outside protected mode */
-    X86_SPECIAL_ProtMode,
-
     /*
      * Register operand 0/2 is zero extended to 32 bits.  Rd/Mb or Rd/Mw
      * in the manual.
@@ -157,10 +170,6 @@ typedef enum X86InsnSpecial {
      * become P/P/Q/N, and size "x" becomes "q".
      */
     X86_SPECIAL_MMX,
-
-    /* Illegal or exclusive to 64-bit mode */
-    X86_SPECIAL_i64,
-    X86_SPECIAL_o64,
 } X86InsnSpecial;
 
 /*
@@ -224,6 +233,8 @@ struct X86OpEntry {
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
     uint16_t     valid_prefix:16;
+    uint8_t      check:8;
+    uint8_t      intercept:8;
     bool         is_decode:1;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 88793ba988d..7c36cf8a6df 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1236,10 +1236,6 @@ static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 
 static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (s->vex_l) {
-        gen_illegal_opcode(s);
-        return;
-    }
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
@@ -1832,10 +1828,6 @@ static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
 
 static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    if (s->vex_l) {
-        gen_illegal_opcode(s);
-        return;
-    }
     gen_helper_update_mxcsr(tcg_env);
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
-- 
2.41.0


