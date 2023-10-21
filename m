Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF67D1B27
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4au-0007AA-KJ; Sat, 21 Oct 2023 01:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4as-00079N-FS
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4aq-0008NJ-PZ
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce2bcb131fso1009013a34.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866331; x=1698471131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3VEIbvjRYgsDHOF+dDcgCX/rxnIBN6JS7kHe55iiGc=;
 b=zl5M9xg71jrC9xf67X4wDskVVWdRVxPw37v4VECT9FO0DwtLjT9y9goJdWDp81nIcj
 TlqBrxya6MrFOqOMEdbb2qFv2MCqiYz9GT/9WqRPTHfNFozLEBbos7/ftLTW2db9fmQg
 wtrXOxBjXny4ck34EEvGmGFLgUiUfZWQyyunD21sUpD30LaE3X47sg4MOJCSm5as0o5t
 TeVAqcq0rbeqCMcwO8w7l/oUyf0BeZzB6McrkmCu6ymJWB2bS5GCVOSf0RGse+WR5m/y
 vjeo+o5bBrl5YoPe61RY9XMWj/InDSglBADuUEbdacGQ4/VKwbw5QsNBVzPRF97lLdik
 6jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866331; x=1698471131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3VEIbvjRYgsDHOF+dDcgCX/rxnIBN6JS7kHe55iiGc=;
 b=hH7sOQU+9qdgExawucUTaAqrdHITbDJYSnsrmd1rPLHB66CCOPkMMWjXkq3aNBMBXj
 GRIQkZ5qelgZ7ASwfhVZai8rjHCdowWpY17It+JI0xKSFPb9I8/GPtE3RzfqBsWNfqVT
 W9CPY1dzJ2RcIgmAPIvqWUKz0rhmXWZHHnKvQEnDqN/1+Our/IaiEmF7pb4agEkaRZOw
 JKghgTvbNKHSr5qL0WSJTOv6+8nMvwfi3OL3VGoEd1QY5KvufosTzLz+VfvHD3l00LWB
 JmLOeEGvgks/PuD4iXTq98ShB7Cm9lVRxqF3MpwaK70kwteoa8kGzXs0gR1wr0xnKOOP
 wFRA==
X-Gm-Message-State: AOJu0Ywgl86jWIbAAa8owWyt5XjOqmpbTXVLbks7GImvn+wxNl+7earm
 H1Ly0BERWtbTzsSTyibrrgTsfUSccarV2e3yuXc=
X-Google-Smtp-Source: AGHT+IHjPo7DAsiIvZrFyFpY0TmBes7+HqQc6GNNPfbK1wDThKMeMcM4e8Y7QE/LdcV12DL+uGv6QA==
X-Received: by 2002:a05:6830:9:b0:6bc:f999:a544 with SMTP id
 c9-20020a056830000900b006bcf999a544mr3923730otp.15.1697866331473; 
 Fri, 20 Oct 2023 22:32:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 14/90] target/sparc: Move FBPfcc and FBfcc to decodetree
Date: Fri, 20 Oct 2023 22:30:42 -0700
Message-Id: <20231021053158.278135-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
 target/sparc/translate.c  | 102 +++++++++++++++-----------------------
 2 files changed, 43 insertions(+), 63 deletions(-)

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
index 2d08c81821..69e85b1842 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1356,44 +1356,6 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
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
@@ -3034,6 +2996,28 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 TRANS(Bicc, ALL, do_bpcc, a)
 TRANS(BPcc,  64, do_bpcc, a)
 
+static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
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
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
@@ -3062,6 +3046,20 @@ static bool trans_CALL(DisasContext *dc, arg_CALL *a)
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
@@ -3085,7 +3083,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     case 0:                     /* branches/sethi */
         {
             unsigned int xop = GET_FIELD(insn, 7, 9);
-            int32_t target;
             switch (xop) {
 #ifdef TARGET_SPARC64
             case 0x1:           /* V9 BPcc */
@@ -3093,36 +3090,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


