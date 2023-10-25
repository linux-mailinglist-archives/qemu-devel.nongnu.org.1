Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053BD7D7898
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:31:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHq-0001WA-Jb; Wed, 25 Oct 2023 19:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHk-0001Ua-HA
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHh-0004nN-SM
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRoh6y+Jb8tosN0TUpZBlHO1oV7L9EwOB8dECwAOKek=;
 b=e7Veq/qhd/7xsfyhtA6mUDrTTk6p9+26qn5KB4LjwLE0Ct+lruphNDok3cazMNOAfexcZ2
 kKzAg7ckd0DtFlIC3zzqLNTW6akMfHX4IIjDuZ1opV3jFhidDVAHHyKYjv1COva1yA89xU
 i3SeIXgafZKxxpQrgdVLXtNViebCiZs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-escmd1FbP9WvCsED30qYOw-1; Wed, 25 Oct 2023 19:27:30 -0400
X-MC-Unique: escmd1FbP9WvCsED30qYOw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e3e4aa311so4167671cf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276449; x=1698881249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRoh6y+Jb8tosN0TUpZBlHO1oV7L9EwOB8dECwAOKek=;
 b=wLqO7XHztXUQAHo4mXdFI3T1AfiZF2n7sIiY5XtOaDKfQx29b69OLgDEolIFaLSRZp
 jZIa0a8wadKKEiiALZj9bt/dVAVcpZ/lO0/FvyR425mLkw45prb5N5V7DwGu+X27ZbSW
 kaVVee6oVtwDzz1vnDIMSRd/cBPqeo8kkp/m0b9vRIVhpEH2kGNrjXgtRMY+jG821Xfv
 fxxz0Vdtzuzem90IEWDKb7qJ+lpK/ppDWOuTV7I9X+5scZoz2OC88m9u68moe01t83Yr
 oTWqRFmLPlT94kqJOozuNWyEpMLBOjZXc05bgyiQ56JGa2MBbCM747xcS7JW9i+DRx+n
 EvIA==
X-Gm-Message-State: AOJu0YywHXQM8NfTvHXKLGpULLGOiZ8ORBbZ7XME/4c6zgETj/Wv9j+2
 p6wwwrEdC03mvbkOXQlJmGDRAe3lPHL4u1Z1H17UgOCNEzfyP5jGnlb5FvzNmX2YF+J34/hGFHu
 NZbk9Mbc8rlwHxtlAczvHLuTHUqKPf+7rbzRflP4RBG3pqUCJvtUWZEkA5VC1fhxP1l/AhSny+k
 g=
X-Received: by 2002:ac8:5886:0:b0:40f:f0e0:a008 with SMTP id
 t6-20020ac85886000000b0040ff0e0a008mr20591900qta.53.1698276449631; 
 Wed, 25 Oct 2023 16:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxLwmB0fudVvELS44rjex0VzkkkS6ZVqYXtulpUT+AzF+qVaLV9D1g0hYtvcLlkbODmgqHQ==
X-Received: by 2002:ac8:5886:0:b0:40f:f0e0:a008 with SMTP id
 t6-20020ac85886000000b0040ff0e0a008mr20591878qta.53.1698276449253; 
 Wed, 25 Oct 2023 16:27:29 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a05622a131000b00417f330026bsm4574883qtk.49.2023.10.25.16.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/24] target/i386: group common checks in the decoding phase
Date: Thu, 26 Oct 2023 01:26:58 +0200
Message-ID: <20231025232718.89428-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

In preparation for adding more similar checks, move the VEX.L=0 check
and several X86_SPECIAL_* checks to a new field, where each bit represent
a common check on unused bits, or a restriction on the processor mode.

Likewise, many SVM intercepts can be checked during the decoding phase,
the main exception being the selective CR0 write, MSR and IOIO intercepts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 85 ++++++++++++++++++++++++--------
 target/i386/tcg/decode-new.h     | 29 ++++++++---
 target/i386/tcg/emit.c.inc       |  8 ---
 3 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ec5d260b7ea..25c1dae55a4 100644
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
@@ -1590,6 +1591,12 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -1775,6 +1782,25 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
@@ -1785,23 +1811,6 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
@@ -1831,6 +1840,37 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
+    if (decode.e.check) {
+        if ((decode.e.check & X86_CHECK_vm86_iopl) && VM86(s)) {
+            if (IOPL(s) < 3) {
+                goto gp_fault;
+            }
+        } else if (decode.e.check & X86_CHECK_cpl_iopl) {
+            if (IOPL(s) < CPL(s)) {
+                goto gp_fault;
+            }
+        }
+    }
+
     if (decode.e.special == X86_SPECIAL_MMX &&
         !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
         gen_helper_enter_mmx(tcg_env);
@@ -1857,6 +1897,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
index 9be8a6e65fd..bbc9aea940d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -131,15 +131,30 @@ typedef enum X86OpUnit {
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
+    X86_CHECK_cpl_iopl = 32,
+    X86_CHECK_iopl = X86_CHECK_cpl_iopl | X86_CHECK_vm86_iopl,
+
+    /* Fault if VEX.L=1 */
+    X86_CHECK_VEX128 = 64,
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
@@ -158,10 +173,6 @@ typedef enum X86InsnSpecial {
      * become P/P/Q/N, and size "x" becomes "q".
      */
     X86_SPECIAL_MMX,
-
-    /* Illegal or exclusive to 64-bit mode */
-    X86_SPECIAL_i64,
-    X86_SPECIAL_o64,
 } X86InsnSpecial;
 
 /*
@@ -224,7 +235,9 @@ struct X86OpEntry {
     X86CPUIDFeature cpuid:8;
     unsigned     vex_class:8;
     X86VEXSpecial vex_special:8;
-    uint16_t     valid_prefix:16;
+    unsigned     valid_prefix:16;
+    unsigned     check:16;
+    unsigned     intercept:8;
     bool         is_decode:1;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 16085a19d7a..82da5488d47 100644
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
@@ -1886,10 +1882,6 @@ static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
 
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


