Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC481CE52
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4p-000168-KU; Fri, 22 Dec 2023 13:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4X-0000yt-8p
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4T-0006C7-PX
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sQWWugEvI2ifaKtCgvRiC1IDRrk/O3Q3w8Hq0zeM8ds=;
 b=LDxbktYY5LyeoqYBi1OBWzv/pmDzLeET0nMxKHEb8VJecJ39lrINHYaLlBCv0R2mPzg1b1
 mIMaBF9O06OceMwEdY6zo0RKoMuz8w6Q0ns33ALIfdfrazDSL/S5K9R/TmamJ/7ViXWJU7
 g7pGZW+B2hyWNflOrYq+aF2QA9Xyq/o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-1HW0AbQDNtWqoqBfi299-Q-1; Fri, 22 Dec 2023 13:16:27 -0500
X-MC-Unique: 1HW0AbQDNtWqoqBfi299-Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54cb8899c20so818639a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268986; x=1703873786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQWWugEvI2ifaKtCgvRiC1IDRrk/O3Q3w8Hq0zeM8ds=;
 b=ImjpZOcoI2XA1cLlqZBHVyk5LvDxTm1XfaUdtzhE0FXR//GuXaoWA074dfRcGF0ElL
 dygj0BKdKem2rNiwsXk+f68SCHrCuVDDSapw+HPmkIQHrQW3Tw7XeCH/UmmLKeXXHQr9
 szCQQNUsXm3mmKTIe28wvphDR59Di+n9/8GmLNvtA5PzCw59hTHzalz8GBBQ4W0A1gty
 cHfYlbOLZ2hTjduj27DHI4EXAeFaKpvNvGqXvd4EXlbDx8SCcuPocWIQfqMsuXynbNJQ
 aRvJvrE59XUspVTwp2iPRvYuk4/cQATI1lLB+y9nJ2Ch2lHWRcOAFuyLLNS2NXE9vnrC
 AJQw==
X-Gm-Message-State: AOJu0Yxjs+CXBHZTKsDjqs3oAkgj/HNOdfiggU5HrH8ozk4ptZvxONSr
 QnOU2DKLr1FsBPEnfV9D8ZRoKGBFbmAjKmAJTksPrgAfvOSfdRFRnBQI8pH/Sec73V2cpQ9Z0rj
 HP4AZGQUXmgdoaSat6W5MRMUJ7pMlMDxITEJIbWTRFaAifVvrb/Sqc1AfjLoRlWV5/9Q0rnD3fa
 jk0lrZG/Q=
X-Received: by 2002:a50:aa94:0:b0:554:347a:4f58 with SMTP id
 q20-20020a50aa94000000b00554347a4f58mr924114edc.66.1703268985745; 
 Fri, 22 Dec 2023 10:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFfxgj3JMehyksYOgvesLE//e9HgnPQAlTaj6fyZMKDdE7pCp9FQq4CvetvulhoKRn0DJ87A==
X-Received: by 2002:a50:aa94:0:b0:554:347a:4f58 with SMTP id
 q20-20020a50aa94000000b00554347a4f58mr924104edc.66.1703268985351; 
 Fri, 22 Dec 2023 10:16:25 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ew10-20020a056402538a00b005546ba152f4sm577455edb.71.2023.12.22.10.16.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/22] target/i386: add X86_SPECIALs for MOVSX and MOVZX
Date: Fri, 22 Dec 2023 19:15:51 +0100
Message-ID: <20231222181603.174137-11-pbonzini@redhat.com>
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

Usually the registers are just moved into s->T0 without much care for
their operand size.  However, in some cases we can get more efficient
code if the operand fetching logic syncs with the emission function
on what is nicer.

All the current uses are mostly demonstrative and only reduce the code
in the emission functions, because the instructions do not support
memory operands.  However the logic is generic and applies to several
more instructions such as MOVSXD (aka movslq), one-byte shift
instructions, multiplications, XLAT, and indirect calls/jumps.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 18 ++++++++++----
 target/i386/tcg/decode-new.h     |  4 +++
 target/i386/tcg/emit.c.inc       | 42 +++++++++++++++++---------------
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 00fdb243857..d7a86d96c0c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -156,6 +156,8 @@
 #define op0_Rd .special = X86_SPECIAL_Op0_Rd,
 #define op2_Ry .special = X86_SPECIAL_Op2_Ry,
 #define avx_movx .special = X86_SPECIAL_AVXExtMov,
+#define sextT0 .special = X86_SPECIAL_SExtT0,
+#define zextT0 .special = X86_SPECIAL_ZExtT0,
 
 #define vex1 .vex_class = 1,
 #define vex1_rep3 .vex_class = 1, .vex_special = X86_VEX_REPScalar,
@@ -571,8 +573,8 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
     [5] = {
         X86_OP_ENTRY3(BZHI, G,y, E,y, B,y, vex13 cpuid(BMI1)),
         {},
-        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 cpuid(BMI2)),
-        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 cpuid(BMI2)),
+        X86_OP_ENTRY3(PEXT, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
+        X86_OP_ENTRY3(PDEP, G,y, B,y, E,y, vex13 zextT0 cpuid(BMI2)),
         {},
     },
     [6] = {
@@ -583,10 +585,10 @@ static const X86OpEntry opcodes_0F38_F0toFF[16][5] = {
         {},
     },
     [7] = {
-        X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 cpuid(BMI1)),
+        X86_OP_ENTRY3(BEXTR, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
         X86_OP_ENTRY3(SHLX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
-        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
-        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 cpuid(BMI1)),
+        X86_OP_ENTRY3(SARX, G,y, E,y, B,y, vex13 sextT0 cpuid(BMI1)),
+        X86_OP_ENTRY3(SHRX, G,y, E,y, B,y, vex13 zextT0 cpuid(BMI1)),
         {},
     },
 };
@@ -1905,6 +1907,12 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
+    case X86_SPECIAL_SExtT0:
+    case X86_SPECIAL_ZExtT0:
+        /* Handled in gen_load.  */
+        assert(decode.op[1].unit == X86_OP_INT);
+        break;
+
     default:
         break;
     }
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index b253f7457ae..70b6717227f 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -191,6 +191,10 @@ typedef enum X86InsnSpecial {
      * become P/P/Q/N, and size "x" becomes "q".
      */
     X86_SPECIAL_MMX,
+
+    /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
+    X86_SPECIAL_SExtT0,
+    X86_SPECIAL_ZExtT0,
 } X86InsnSpecial;
 
 /*
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index f5e44117eab..4c2006fdd09 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -232,9 +232,30 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
         break;
     case X86_OP_INT:
         if (op->has_ea) {
-            gen_op_ld_v(s, op->ot, v, s->A0);
+            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
+                gen_op_ld_v(s, op->ot | MO_SIGN, v, s->A0);
+            } else {
+                gen_op_ld_v(s, op->ot, v, s->A0);
+            }
+
+        } else if (op->ot == MO_8 && byte_reg_is_xH(s, op->n)) {
+            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
+                tcg_gen_sextract_tl(v, cpu_regs[op->n - 4], 8, 8);
+            } else {
+                tcg_gen_extract_tl(v, cpu_regs[op->n - 4], 8, 8);
+            }
+
+        } else if (op->ot < MO_TL && v == s->T0 &&
+                   (decode->e.special == X86_SPECIAL_SExtT0 ||
+                    decode->e.special == X86_SPECIAL_ZExtT0)) {
+            if (decode->e.special == X86_SPECIAL_SExtT0) {
+                tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot | MO_SIGN);
+            } else {
+                tcg_gen_ext_tl(v, cpu_regs[op->n], op->ot);
+            }
+
         } else {
-            gen_op_mov_v_reg(s, op->ot, v, op->n);
+            tcg_gen_mov_tl(v, cpu_regs[op->n]);
         }
         break;
     case X86_OP_IMM:
@@ -1084,9 +1105,6 @@ static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
      * Shifts larger than operand size get zeros.
      */
     tcg_gen_ext8u_tl(s->A0, s->T1);
-    if (TARGET_LONG_BITS == 64 && ot == MO_32) {
-        tcg_gen_ext32u_tl(s->T0, s->T0);
-    }
     tcg_gen_shr_tl(s->T0, s->T0, s->A0);
 
     tcg_gen_movcond_tl(TCG_COND_LEU, s->T0, s->A0, bound, s->T0, zero);
@@ -1428,19 +1446,11 @@ static void gen_PCMPISTRM(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
 
 static void gen_PDEP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
-    if (ot < MO_64) {
-        tcg_gen_ext32u_tl(s->T0, s->T0);
-    }
     gen_helper_pdep(s->T0, s->T0, s->T1);
 }
 
 static void gen_PEXT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    MemOp ot = decode->op[1].ot;
-    if (ot < MO_64) {
-        tcg_gen_ext32u_tl(s->T0, s->T0);
-    }
     gen_helper_pext(s->T0, s->T0, s->T1);
 }
 
@@ -1796,9 +1806,6 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     mask = ot == MO_64 ? 63 : 31;
     tcg_gen_andi_tl(s->T1, s->T1, mask);
-    if (ot != MO_64) {
-        tcg_gen_ext32s_tl(s->T0, s->T0);
-    }
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
@@ -1873,9 +1880,6 @@ static void gen_SHRX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     mask = ot == MO_64 ? 63 : 31;
     tcg_gen_andi_tl(s->T1, s->T1, mask);
-    if (ot != MO_64) {
-        tcg_gen_ext32u_tl(s->T0, s->T0);
-    }
     tcg_gen_shr_tl(s->T0, s->T0, s->T1);
 }
 
-- 
2.43.0


