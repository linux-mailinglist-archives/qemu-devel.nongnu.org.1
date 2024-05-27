Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399268CFA1C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 09:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUkO-0001gI-1J; Mon, 27 May 2024 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUjX-00087S-8t; Mon, 27 May 2024 03:25:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUjT-0006Fa-Pf; Mon, 27 May 2024 03:25:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB1BB6A4CA;
 Mon, 27 May 2024 10:25:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0474CD8467;
 Mon, 27 May 2024 10:24:36 +0300 (MSK)
Received: (nullmailer pid 52909 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 13/21] tcg/loongarch64: Fill out tcg_out_{ld,
 st} for vector regs
Date: Mon, 27 May 2024 10:24:23 +0300
Message-Id: <20240527072435.52812-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

TCG register spill/fill uses tcg_out_ld/st with all types,
not necessarily going through INDEX_op_{ld,st}_vec.

Cc: qemu-stable@nongnu.org
Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2336
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit c9290dfebfdba5c13baa5e1f10e13a1c876b0643)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dcf0205458..abdc8b7f4d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -807,18 +807,88 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
     }
 }
 
-static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
-                       TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, intptr_t offset)
 {
-    bool is_32bit = type == TCG_TYPE_I32;
-    tcg_out_ldst(s, is_32bit ? OPC_LD_W : OPC_LD_D, arg, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (dest < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
+        } else {
+            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (dest < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
+        } else {
+            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
+        }
+        break;
+    case TCG_TYPE_V128:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_vld(s, dest, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_vldx(s, dest, base, TCG_REG_TMP0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
-static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                       TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
+                       TCGReg base, intptr_t offset)
 {
-    bool is_32bit = type == TCG_TYPE_I32;
-    tcg_out_ldst(s, is_32bit ? OPC_ST_W : OPC_ST_D, arg, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (src < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_ST_W, src, base, offset);
+        } else {
+            /* TODO: Could use fst_s, fstx_s */
+            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
+                if (-0x800 <= offset && offset <= 0x7ff) {
+                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
+                } else {
+                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
+                }
+                base = TCG_REG_TMP0;
+                offset = 0;
+            }
+            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (src < TCG_REG_V0) {
+            tcg_out_ldst(s, OPC_ST_D, src, base, offset);
+        } else {
+            /* TODO: Could use fst_d, fstx_d */
+            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
+                if (-0x800 <= offset && offset <= 0x7ff) {
+                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
+                } else {
+                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
+                }
+                base = TCG_REG_TMP0;
+                offset = 0;
+            }
+            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
+        }
+        break;
+    case TCG_TYPE_V128:
+        if (-0x800 <= offset && offset <= 0x7ff) {
+            tcg_out_opc_vst(s, src, base, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_vstx(s, src, base, TCG_REG_TMP0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -1739,7 +1809,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2, a3;
-    TCGReg temp = TCG_REG_TMP0;
     TCGReg temp_vec = TCG_VEC_TMP0;
 
     static const LoongArchInsn cmp_vec_insn[16][4] = {
@@ -1819,22 +1888,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_st_vec:
-        /* Try to fit vst imm */
-        if (-0x800 <= a2 && a2 <= 0x7ff) {
-            tcg_out_opc_vst(s, a0, a1, a2);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
-            tcg_out_opc_vstx(s, a0, a1, temp);
-        }
+        tcg_out_st(s, type, a0, a1, a2);
         break;
     case INDEX_op_ld_vec:
-        /* Try to fit vld imm */
-        if (-0x800 <= a2 && a2 <= 0x7ff) {
-            tcg_out_opc_vld(s, a0, a1, a2);
-        } else {
-            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
-            tcg_out_opc_vldx(s, a0, a1, temp);
-        }
+        tcg_out_ld(s, type, a0, a1, a2);
         break;
     case INDEX_op_and_vec:
         tcg_out_opc_vand_v(s, a0, a1, a2);
-- 
2.39.2


