Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B06A9D565
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Apr 2025 00:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9h-0000En-Lq; Fri, 25 Apr 2025 18:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7h-0005Ea-QN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7d-0001MH-0E
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so31687705ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618531; x=1746223331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64ZfABGiy4MwqRbVhRyDHI6fexI+JZ1H79oaqGBDrD4=;
 b=VGtHcpUxmQ/KEidgJJB6z0GifqiQ41UF8BAygkvU8h7YxpxJk/b1efBf9FFC1FlmK7
 62rNF+5eqBJIp9xxsMUMRYWpUHPXBYINq31uhZf5v3FTj0InX/kb30+T4/MwKYPtZCHj
 1viE9RLOxpjfCrzJXyrqXRsyXdta1m9wo2DyAWKk6cdhmNv3VtNImqG/I0Kcb0J7maNk
 eaLx/R835hPgLf4tEnnIQ8t/5Ax313s57B6vKNSiTj1oqGqp7n6t+b5RMQv+TuqvSkU1
 AcjwEVXhbrHp5DEc2NDmcUNohhXjjuytbfwnUWfsekrQaxzAfdYfIhnTAR1GlFrpVtHT
 SyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618531; x=1746223331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64ZfABGiy4MwqRbVhRyDHI6fexI+JZ1H79oaqGBDrD4=;
 b=NpbnJlmoEDncg+azF6Ma4ep0d512ltX53ESpqI2abhRZMxV64laG0C4WAgIjJJoS2Q
 Csex4Uri5OKYaAXjSW6Rwy8SjC6XI91ne7t0ZzXtqTL8gioXmi3o7T5Pj6DOeedZ1geo
 +xfJXjOXGmshNObgRLmZjd5B/GLK3I4of3ieLUyVigEcsFOqDB4zpHjHV2HA080CFXNo
 dN15/F7RfPRYQoTZHfz7XWP2hge3MAmPXQYmJZ4qzPTy5Ag3rrPvyAPYadgrPYMdPyQg
 Ep/QjEebbenOKxKPh/r5hU8ezVhHlOhmzHS+9blY+v1mSw0a4O2tzIeoAP8c1iqeXdZ9
 Svxg==
X-Gm-Message-State: AOJu0Yx6UM4iLo7v/littGJIpeKxCYqgQnP5BmTvcS6pGTDLpr6Y9vGv
 Z0a57QSfNEDpKUZE2ri9acvDQ2FczoHrrYtuiJHgPy3SVmY+XH7WGDKJxA1pyJgTGwMvpTKPe65
 p
X-Gm-Gg: ASbGncuGgxL5e47PTbxCJH7vD1v2j6Cu00RuDecdyPOx+C9BZgLwgeZ16TwnocRSez8
 zeHN5Q5ctNDznU/gdNN4vQpdkSarjMwyjKhfcm/KE/M/QHiUqzAkB2fwl+ox/l7y+ghkBY3NKsp
 AoT0pYVx3ENqQi5unKYlUL/9JphkoEVLWjPfrwqOTbALF4n4zyEOH/as1b9vo13Pls7o5lDywQW
 IHFT33An16nJkOSTIGtV8MVo/rCJmxBPfJf/+Uayq9+Ii/tv6zxCw2QcX4a1QBTvyBRojfQU6OS
 eIbFph7eguWW5nxydPdNRlAZVMuRaFcDVI9UybJjefN7kY0nECo/xwDAqZ43cXuQF8NkPFGKyDA
 =
X-Google-Smtp-Source: AGHT+IG96jzFbbRvc4Pnj9GcqblA9W3cfwavkgD0agAWW6m91fs0Ipf5/zFllfRSr1UQxNaYaBTE7Q==
X-Received: by 2002:a17:902:ce8b:b0:223:501c:7576 with SMTP id
 d9443c01a7336-22dbf5ef67dmr62612505ad.12.1745618531180; 
 Fri, 25 Apr 2025 15:02:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 100/159] tcg: Merge INDEX_op_sextract_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:54 -0700
Message-ID: <20250425215454.886111-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 22 +++-------------------
 tcg/tcg-op.c             | 12 ++++++------
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  5 +----
 7 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a8c304ca63..4ace1f85c4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -74,6 +74,7 @@ DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
+DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -90,7 +91,6 @@ DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i32, 1, 2, 2, 0)
-DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
@@ -112,7 +112,6 @@ DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i64, 1, 2, 2, 0)
-DEF(sextract_i64, 1, 1, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index fbfcbf23cd..d324cbf7fe 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2317,7 +2317,6 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
@@ -2336,27 +2335,12 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
     sh = ctz64(val);
 
-    switch (ctx->type) {
-    case TCG_TYPE_I32:
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i32;
-        }
-        break;
-    case TCG_TYPE_I64:
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i64;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     ret = op->args[0];
     src1 = op->args[1];
     inv = cond == TCG_COND_TSTEQ;
 
-    if (sh && sext_opc && neg && !inv) {
-        op->opc = sext_opc;
+    if (sh && neg && !inv && TCG_TARGET_sextract_valid(ctx->type, sh, 1)) {
+        op->opc = INDEX_op_sextract;
         op->args[1] = src1;
         op->args[2] = sh;
         op->args[3] = 1;
@@ -3019,7 +3003,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bitsel_vec:
             done = fold_bitsel_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sextract):
+        case INDEX_op_sextract:
             done = fold_sextract(&ctx, op);
             break;
         case INDEX_op_sub:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ddade73b7b..d3f3c9d248 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1043,19 +1043,19 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i32(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, ret, 0, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
@@ -2747,19 +2747,19 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i64(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, ret, 0, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7f5fa25062..c7ce13cda0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1111,8 +1111,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_setcond, TCGOutOpSetcond, outop_setcond),
-    OUTOP(INDEX_op_sextract_i32, TCGOutOpExtract, outop_sextract),
-    OUTOP(INDEX_op_sextract_i64, TCGOutOpExtract, outop_sextract),
+    OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -2333,6 +2332,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond:
     case INDEX_op_or:
     case INDEX_op_setcond:
+    case INDEX_op_sextract:
     case INDEX_op_xor:
         return has_type;
 
@@ -2344,7 +2344,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_sextract_i32:
     case INDEX_op_deposit_i32:
         return true;
 
@@ -2372,7 +2371,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i64:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
@@ -5520,8 +5518,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_extract:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
         {
             const TCGOutOpExtract *out =
                 container_of(all_outop[op->opc], TCGOutOpExtract, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 6345029802..5a07d65db8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -28,6 +28,7 @@
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
 #define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
+#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
 
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
@@ -661,9 +662,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract_tr(regs[r1], pos, len);
             break;
-        case INDEX_op_sextract_i32:
+        case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract32(regs[r1], pos, len);
+            regs[r0] = sextract_tr(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
@@ -773,10 +774,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_sextract_i64:
-            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract64(regs[r1], pos, len);
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
@@ -1055,8 +1052,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_extract:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
         tci_args_rrbb(insn, &r0, &r1, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s,%s,%d,%d",
                            op_name, str_r(r0), str_r(r1), pos, len);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 2843f88772..ca7550f68c 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -458,7 +458,7 @@ Misc
 
    * - extract *dest*, *t1*, *pos*, *len*
 
-       sextract_i32/i64 *dest*, *t1*, *pos*, *len*
+       sextract *dest*, *t1*, *pos*, *len*
 
      - | Extract a bitfield from *t1*, placing the result in *dest*.
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e013321ac7..9ba108ef8d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -445,10 +445,7 @@ static const TCGOutOpExtract outop_extract = {
 static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
                              TCGReg rs, unsigned pos, unsigned len)
 {
-    TCGOpcode opc = type == TCG_TYPE_I32 ?
-                    INDEX_op_sextract_i32 :
-                    INDEX_op_sextract_i64;
-    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_sextract = {
-- 
2.43.0


