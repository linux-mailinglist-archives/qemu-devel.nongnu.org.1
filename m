Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320D7081C4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6T-0004Co-Ay; Thu, 18 May 2023 08:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6Q-0004Bm-4a
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6K-00082B-5Z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f450815d0bso19663975e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414280; x=1687006280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KJ0AuTZIeHtuKSRHgOzvysEJomvJ3ZVkSEuGxl++Sq4=;
 b=HshaxGK1tq+rZh64u+TC8e4zMT1kwD+MOLJb4VzWrnqQsOP/BcV3gJhT1BOajUIhHT
 WNGzeNDjVdgRNNRu/kU03mHi7BfG8gmnAJvV92Kz7ppERRjEOzegkyllxSLG0t7IDpp/
 gKdZT8kbsHxG4V13EIBOTZLNdeXC3PZHMFQDEk6eo6zC0LIs745kOsayd+HHSLV07ZVe
 lYI3OdNoD7Zot7eNdbGgXKYhwLb0N8BDgfnxtC0zffTnysbBEH3XPqo1FOA7+90vxi3+
 a8ueeSJFdDLpOF810ReGXrc97CQhBrJA7GcMNm180JcgItAtETO0tkM7kGtL0L7YzfwJ
 mwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414280; x=1687006280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ0AuTZIeHtuKSRHgOzvysEJomvJ3ZVkSEuGxl++Sq4=;
 b=ArRYGfsToGtI5zRkxJGR61sKCXdhJcawnO9+Y9orhDwp1gKj2cPSEVIHowxBmsg8lU
 xY/uXbjpxMNMJPKNwIK4QN0YC+4moOmOSdlKOzWdCX9aJoxe3+RTcUIQmNqy+4sb4P/Q
 +NVWCAMYX7Qcg4aQNDm5h0gdgTRQv5joc0Vy0hRpTovV7gSvASZDZ3j9eL1u5BWnzjns
 G0vqodmGGfUdLkfVQyE/agiY1YnEBU7rS+JH9kGhtJNOJWdV3pQ3JIj5qHBj20wDvKxV
 C73iA2gttDI3/vKpmsaa7jxi/DmjtSspF50NgKc+IXpVkJs8xgEDCZnFyQ2pI1MZKNG1
 Zd8Q==
X-Gm-Message-State: AC+VfDw8RnKBaqLRheBJwxAHerjJhqVgzBIZl5UY2MJzWPt54s6/ynDg
 6cT15Z4OCD9Te16LV5W6QgGH4TSN4+fd9TKwksw=
X-Google-Smtp-Source: ACHHUZ4+XVvknHRR/U1tFbof+/yo+JyQXDAVOC5ou1uLRWbohuAu1o6Mhg994IOJGCf+5C/3gT1tzg==
X-Received: by 2002:a7b:c393:0:b0:3f4:2267:10c0 with SMTP id
 s19-20020a7bc393000000b003f4226710c0mr1577703wmj.28.1684414280776; 
 Thu, 18 May 2023 05:51:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] target/arm: Convert ERET, ERETAA, ERETAB to decodetree
Date: Thu, 18 May 2023 13:51:04 +0100
Message-Id: <20230518125107.146421-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Convert the exception-return insns ERET, ERETA and ERETB to
decodetree. These were the last insns left in the legacy
decoder function disas_uncond_reg_b(), which allows us to
remove it.

The old decoder explicitly decoded the DRPS instruction,
only in order to call unallocated_encoding() on it, exactly
as would have happened if it hadn't decoded it. This is
because this insn always UNDEFs unless the CPU is in
halting-debug state, which we don't emulate. So we list
the pattern in a comment in a64.decode, but don't actively
decode it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-21-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |   8 ++
 target/arm/tcg/translate-a64.c | 163 +++++++++++----------------------
 2 files changed, 63 insertions(+), 108 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2fd435b6317..12a310d0a31 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -142,3 +142,11 @@ RETA            1101011 0010 11111 00001 m:1 11111 11111 &reta  # RETAA, RETAB
 &bra        rn rm m
 BRA             1101011 1000 11111 00001 m:1 rn:5 rm:5 &bra # BRAA, BRAB
 BLRA            1101011 1001 11111 00001 m:1 rn:5 rm:5 &bra # BLRAA, BLRAB
+
+ERET            1101011 0100 11111 000000 11111 00000
+ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
+
+# We don't need to decode DRPS because it always UNDEFs except when
+# the processor is in halting debug state (which we don't implement).
+# The pattern is listed here as documentation.
+# DRPS            1101011 0101 11111 000000 11111 00000
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 40a6e59a609..741a6087399 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1539,6 +1539,61 @@ static bool trans_BLRA(DisasContext *s, arg_bra *a)
     return true;
 }
 
+static bool trans_ERET(DisasContext *s, arg_ERET *a)
+{
+    TCGv_i64 dst;
+
+    if (s->current_el == 0) {
+        return false;
+    }
+    if (s->fgt_eret) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF, 0, 2);
+        return true;
+    }
+    dst = tcg_temp_new_i64();
+    tcg_gen_ld_i64(dst, cpu_env,
+                   offsetof(CPUARMState, elr_el[s->current_el]));
+
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+
+    gen_helper_exception_return(cpu_env, dst);
+    /* Must exit loop to check un-masked IRQs */
+    s->base.is_jmp = DISAS_EXIT;
+    return true;
+}
+
+static bool trans_ERETA(DisasContext *s, arg_reta *a)
+{
+    TCGv_i64 dst;
+
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
+    }
+    if (s->current_el == 0) {
+        return false;
+    }
+    /* The FGT trap takes precedence over an auth trap. */
+    if (s->fgt_eret) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF, a->m ? 3 : 2, 2);
+        return true;
+    }
+    dst = tcg_temp_new_i64();
+    tcg_gen_ld_i64(dst, cpu_env,
+                   offsetof(CPUARMState, elr_el[s->current_el]));
+
+    dst = auth_branch_target(s, dst, cpu_X[31], !a->m);
+    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+
+    gen_helper_exception_return(cpu_env, dst);
+    /* Must exit loop to check un-masked IRQs */
+    s->base.is_jmp = DISAS_EXIT;
+    return true;
+}
+
 /* HINT instruction group, including various allocated HINTs */
 static void handle_hint(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int crm)
@@ -2307,111 +2362,6 @@ static void disas_exc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Unconditional branch (register)
- *  31           25 24   21 20   16 15   10 9    5 4     0
- * +---------------+-------+-------+-------+------+-------+
- * | 1 1 0 1 0 1 1 |  opc  |  op2  |  op3  |  Rn  |  op4  |
- * +---------------+-------+-------+-------+------+-------+
- */
-static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
-{
-    unsigned int opc, op2, op3, rn, op4;
-    TCGv_i64 dst;
-    TCGv_i64 modifier;
-
-    opc = extract32(insn, 21, 4);
-    op2 = extract32(insn, 16, 5);
-    op3 = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    op4 = extract32(insn, 0, 5);
-
-    if (op2 != 0x1f) {
-        goto do_unallocated;
-    }
-
-    switch (opc) {
-    case 0:
-    case 1:
-    case 2:
-    case 8:
-    case 9:
-        /*
-         * BR, BLR, RET, RETAA, RETAB, BRAAZ, BRABZ, BLRAAZ, BLRABZ,
-         * BRAA, BLRAA: handled in decodetree
-         */
-        goto do_unallocated;
-
-    case 4: /* ERET */
-        if (s->current_el == 0) {
-            goto do_unallocated;
-        }
-        switch (op3) {
-        case 0: /* ERET */
-            if (op4 != 0) {
-                goto do_unallocated;
-            }
-            if (s->fgt_eret) {
-                gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(op3), 2);
-                return;
-            }
-            dst = tcg_temp_new_i64();
-            tcg_gen_ld_i64(dst, cpu_env,
-                           offsetof(CPUARMState, elr_el[s->current_el]));
-            break;
-
-        case 2: /* ERETAA */
-        case 3: /* ERETAB */
-            if (!dc_isar_feature(aa64_pauth, s)) {
-                goto do_unallocated;
-            }
-            if (rn != 0x1f || op4 != 0x1f) {
-                goto do_unallocated;
-            }
-            /* The FGT trap takes precedence over an auth trap. */
-            if (s->fgt_eret) {
-                gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(op3), 2);
-                return;
-            }
-            dst = tcg_temp_new_i64();
-            tcg_gen_ld_i64(dst, cpu_env,
-                           offsetof(CPUARMState, elr_el[s->current_el]));
-            if (s->pauth_active) {
-                modifier = cpu_X[31];
-                if (op3 == 2) {
-                    gen_helper_autia(dst, cpu_env, dst, modifier);
-                } else {
-                    gen_helper_autib(dst, cpu_env, dst, modifier);
-                }
-            }
-            break;
-
-        default:
-            goto do_unallocated;
-        }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
-
-        gen_helper_exception_return(cpu_env, dst);
-        /* Must exit loop to check un-masked IRQs */
-        s->base.is_jmp = DISAS_EXIT;
-        return;
-
-    case 5: /* DRPS */
-        if (op3 != 0 || op4 != 0 || rn != 0x1f) {
-            goto do_unallocated;
-        } else {
-            unallocated_encoding(s);
-        }
-        return;
-
-    default:
-    do_unallocated:
-        unallocated_encoding(s);
-        return;
-    }
-}
-
 /* Branches, exception generating and system instructions */
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
@@ -2427,9 +2377,6 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
             disas_exc(s, insn);
         }
         break;
-    case 0x6b: /* Unconditional branch (register) */
-        disas_uncond_b_reg(s, insn);
-        break;
     default:
         unallocated_encoding(s);
         break;
-- 
2.34.1


