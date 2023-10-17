Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8717CBB20
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKA-0000CR-RM; Tue, 17 Oct 2023 02:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK9-0000BE-3n
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK7-0003rn-BR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so32695985ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523178; x=1698127978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnBhp2EHdsMRCinu+kNLsNQ6f4/PHvr+hlBeFIVzmDs=;
 b=zTKi3F3+LnlaVVvfRb33PdpHqqF0mm2yZe1xJeP1WWZh66UIPlohSUAG7AY6rOUZtf
 053srNQYPOmrQ9Qk7fRIU09b7m2s+CCAef3nb++Kjqjf5+aii2FHLV0yF7RkaQ/7h8Vb
 nI9S4D4FSXllHLyS0kmA8UD3xMrU59JxlzjRuEHwiBX08At/DBwyBZANnkuZmFOudBBJ
 I7l79fjdPEVhraea9zBt32DVq9y5rlQpZxKOpUXhYzZRYSfAFAbeNlz2BRIBjYAoBtHr
 jL2d4VHeY81AqY1AA6P6J7N3M7rDDBNaMWJ7YOt7xvEaMFuUN9KjPLvwuexPLEoAu/3/
 GyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523178; x=1698127978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnBhp2EHdsMRCinu+kNLsNQ6f4/PHvr+hlBeFIVzmDs=;
 b=g0vLxndZawUYnt4AGxlP8BDvDYnKuxoKSvJCKl0aTFavCqRJd0JPhceiNAsXZSh2QY
 NmPUcDOnb4a0PXVX6wByknM6KrGx65GVeZYtXs/CYn1HfnDrsXifKzpRjrWB+mrIn4Kn
 RNNycHsHP15CNx7iL2Duj/3xDhdUI9A9U056MLMIQNxcX6JcF+F4A90mAgbHVQmoXSrE
 K3RZZ5Gs7gkvs/8j4WjHCUE+RfXVZZ7/llNeM1hkKME1nmnthcN0mO6fh4Bp7oFU3dBX
 7bUnmYK+dSCm+yrhGsUhWaoGwZ2tVxqC2bulgKsKvmijKNeTpVDfXoImhKT0luQaMYZR
 JPjA==
X-Gm-Message-State: AOJu0YwBUx8fojl+DiA4b6c7E+tUc40qrMVcp6VChtFmMYGAgOzuPWOb
 HgJKeluXo2G/SRv9gbnbxq5g17NjBADQB/38+Ag=
X-Google-Smtp-Source: AGHT+IHgVX9pJMaOfavp3cmzsQ64mhDb++bUb6X1Job8/ChNCXwA5MmAnrG71uR0/8IVn7rWB2avAQ==
X-Received: by 2002:a17:902:f945:b0:1c0:bcbc:d5d with SMTP id
 kx5-20020a170902f94500b001c0bcbc0d5dmr1191053plb.61.1697523177996; 
 Mon, 16 Oct 2023 23:12:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/90] target/sparc: Move FBPfcc and FBfcc to decodetree
Date: Mon, 16 Oct 2023 23:11:28 -0700
Message-Id: <20231017061244.681584-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/sparc/insns.decode |   4 ++
 target/sparc/translate.c  | 105 +++++++++++++++-----------------------
 2 files changed, 46 insertions(+), 63 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 838f4cdb1d..9ab3f2eb82 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -6,8 +6,12 @@
 &bcc    i a cond cc
 BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
 Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
+FBPfcc  00 a:1 cond:4   101 cc:2   - i:s19                 &bcc
+FBfcc   00 a:1 cond:4   110          i:s22                 &bcc cc=0
 
 %d16    20:s2 0:14
 BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=%d16
 
+NCP     00 -   ----     111 ----------------------         # CBcc
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a3c86b22d1..a05cb59cd6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1351,44 +1351,6 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
     cmp->c2 = tcg_constant_tl(0);
 }
 
-static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
-{
-    unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
-    target_ulong target = dc->pc + offset;
-
-    if (unlikely(AM_CHECK(dc))) {
-        target &= 0xffffffffULL;
-    }
-    if (cond == 0x0) {
-        /* unconditional not taken */
-        if (a) {
-            dc->pc = dc->npc + 4;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = dc->pc + 4;
-        }
-    } else if (cond == 0x8) {
-        /* unconditional taken */
-        if (a) {
-            dc->pc = target;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = target;
-            tcg_gen_mov_tl(cpu_pc, cpu_npc);
-        }
-    } else {
-        flush_cond(dc);
-        gen_fcond(cpu_cond, cc, cond);
-        if (a) {
-            gen_branch_a(dc, target);
-        } else {
-            gen_branch_n(dc, target);
-        }
-    }
-}
-
 #ifdef TARGET_SPARC64
 static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
@@ -3032,6 +2994,31 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 TRANS(BPcc,  64, do_bpcc, a)
 TRANS(Bicc, ALL, do_bpcc, a)
 
+static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
+{
+    target_long target = dc->pc + a->i * 4;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (unlikely(AM_CHECK(dc))) {
+        target &= 0xffffffffULL;
+    }
+    switch (a->cond) {
+    case 0x0:
+        return advance_jump_uncond_never(dc, a->a);
+    case 0x8:
+        return advance_jump_uncond_always(dc, a->a, target);
+    default:
+        flush_cond(dc);
+        gen_fcond(cpu_cond, a->cc, a->cond);
+        return advance_jump_cond(dc, a->a, target);
+    }
+}
+
+TRANS(FBPfcc,  64, do_fbpfcc, a)
+TRANS(FBfcc,  ALL, do_fbpfcc, a)
+
 static bool trans_BPr(DisasContext *dc, arg_BPr *a)
 {
     target_long target;
@@ -3071,6 +3058,20 @@ static bool trans_CALL(DisasContext *dc, arg_CALL *a)
     return true;
 }
 
+static bool trans_NCP(DisasContext *dc, arg_NCP *a)
+{
+    /*
+     * For sparc32, always generate the no-coprocessor exception.
+     * For sparc64, always generate illegal instruction.
+     */
+#ifdef TARGET_SPARC64
+    return false;
+#else
+    gen_exception(dc, TT_NCP_INSN);
+    return true;
+#endif
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3094,7 +3095,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     case 0:                     /* branches/sethi */
         {
             unsigned int xop = GET_FIELD(insn, 7, 9);
-            int32_t target;
             switch (xop) {
 #ifdef TARGET_SPARC64
             case 0x1:           /* V9 BPcc */
@@ -3102,36 +3102,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             case 0x3:           /* V9 BPr */
                 g_assert_not_reached(); /* in decodetree */
             case 0x5:           /* V9 FBPcc */
-                {
-                    int cc = GET_FIELD_SP(insn, 20, 21);
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    target = GET_FIELD_SP(insn, 0, 18);
-                    target = sign_extend(target, 19);
-                    target <<= 2;
-                    do_fbranch(dc, target, insn, cc);
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
 #else
             case 0x7:           /* CBN+x */
-                {
-                    goto ncp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
 #endif
             case 0x2:           /* BN+x */
                 g_assert_not_reached(); /* in decodetree */
             case 0x6:           /* FBN+x */
-                {
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    target = GET_FIELD(insn, 10, 31);
-                    target = sign_extend(target, 22);
-                    target <<= 2;
-                    do_fbranch(dc, target, insn, 0);
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x4:           /* SETHI */
                 /* Special-case %g0 because that's the canonical nop.  */
                 if (rd) {
-- 
2.34.1


