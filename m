Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD8781551
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j1-000516-3T; Fri, 18 Aug 2023 18:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iy-0004zx-MN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iw-0004Op-CV
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:44 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdc243d62bso10876595ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396821; x=1693001621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqbZRam3fZd1lBjYZ1sw5Qn0FmCM+QeoAzzqT19MaTo=;
 b=SW5SFkXXbxR84Mxq9WxLODfICB5PsrsDNJcTipENvMyjLgXKyu6WYr6oqhjMLrPSAa
 sC2rCnvNtMgCP48kbhH96RQzgWeaEvAsCf0h6pVPdyaGs9X/mj/+l1Bkl0mWCUzcKsfi
 MdoLlbnbSKAJIdnPPMi1Eob/cW59p0TLpZNbq1vvyr+AcsqIdFq09LMgBy4HXBRRb0Ol
 ZO33hRA3Lh+V64K6p7ZgFT3t5w9krxYCg1bBTtl1nf0CKyMPmlrgF300ZGasEWrNW5gg
 bCyOe1H1cjw1VTJGwXKrPbjv0hDw/klxmMC+w9YXNWSVCZRhuntmVtApw3bWmY6H7N2w
 xoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396821; x=1693001621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqbZRam3fZd1lBjYZ1sw5Qn0FmCM+QeoAzzqT19MaTo=;
 b=DLz1JOsvhbBjuY1PJzXZ6iMxOZgux+o30aAH/nztkSrV2OXTYdXxJ0Vqfxsy5+OaZq
 AyVan/hFOKVUWsQ6OZ1XFEfbWs6Ne2RSymBz4v9ud0CdVFYWbiVYuTtafBkQWpMiWMUo
 7lyha2DGsyl6/Bj4FgwBjhNS8tEriW94eMnR5eJzU0C8A5T8SwJvwEIDA9dLj992VFjO
 lOPoFEnuN72wZVlFSKk6GqkorwLYFNl6+R9WeOcmoADzBjxJUVFEE88gJoHOAxKEnKu2
 Qhg0PjwAkCDjHYmYeGp+twu+f0j0eK6G4H2v4ViNQ7u8N+fYyDNZ1T2i/uOGwSukoVCI
 ljEw==
X-Gm-Message-State: AOJu0Yx1g2pJUnPiFrpJIQqA+60BZaHSZWTKTlXJtbajO5J1i1dJRqfV
 aRdVujOOiwdjXuk8ilXXMVjQbfY76naoJ9/FBBk=
X-Google-Smtp-Source: AGHT+IHfX9YVjDFvcipgeETWyFl+tUXu5na+LpGClwveIF6G2uA3e8KLsczS8EkhOC20/UiJobA6AA==
X-Received: by 2002:a17:903:11d2:b0:1b9:e913:b585 with SMTP id
 q18-20020a17090311d200b001b9e913b585mr627997plh.13.1692396820961; 
 Fri, 18 Aug 2023 15:13:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 14/23] tcg/riscv: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:18 -0700
Message-Id: <20230818221327.150194-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  4 ++--
 tcg/riscv/tcg-target.c.inc | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index b2961fec8e..7e8ac48a7d 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -120,7 +120,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ctpop_i32        have_zbb
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_movcond_i64      1
@@ -159,7 +159,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..232b616af3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -936,6 +936,44 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, tcg_target_long arg2, bool c2)
+{
+    int tmpflags;
+    TCGReg tmp;
+
+    /* For LT/GE comparison against 0, replicate the sign bit. */
+    if (c2 && arg2 == 0) {
+        switch (cond) {
+        case TCG_COND_GE:
+            tcg_out_opc_imm(s, OPC_XORI, ret, arg1, -1);
+            arg1 = ret;
+            /* fall through */
+        case TCG_COND_LT:
+            tcg_out_opc_imm(s, OPC_SRAI, ret, arg1, TCG_TARGET_REG_BITS - 1);
+            return;
+        default:
+            break;
+        }
+    }
+
+    tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
+    tmp = tmpflags & ~SETCOND_FLAGS;
+
+    /* If intermediate result is zero/non-zero: test != 0. */
+    if (tmpflags & SETCOND_NEZ) {
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+        tmp = ret;
+    }
+
+    /* Produce the 0/-1 result. */
+    if (tmpflags & SETCOND_INV) {
+        tcg_out_opc_imm(s, OPC_ADDI, ret, tmp, -1);
+    } else {
+        tcg_out_opc_reg(s, OPC_SUB, ret, TCG_REG_ZERO, tmp);
+    }
+}
+
 static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg test_ne,
                                    int val1, bool c_val1,
                                    int val2, bool c_val2)
@@ -1782,6 +1820,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_negsetcond(s, args[3], a0, a1, a2, c2);
+        break;
+
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2,
@@ -1910,6 +1953,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_andc_i32:
-- 
2.34.1


