Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EAB80F6C5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 20:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD8Xp-0000rk-5S; Tue, 12 Dec 2023 14:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rD8Xm-0000qR-SO
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 14:35:50 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rD8Xh-00067j-PQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 14:35:50 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c68da9d639so3474099a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702409744; x=1703014544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/qtpDzmC2fPWyklxZL3CGK81+89kWbTA62dfbpXj/Vw=;
 b=bVxNW40ALTm8Y3NvR+a/KKBApd4H9VvodffBEyWrmtMzw0DriD1iCUb61Ijbb0pH/1
 Kl+I/tFc8NNsHKYdpoLsDsqwugi2f2n57mLW1rmO1OfbE6ndpUPkFkCo4SSok1gaPN7t
 62Sje6kqAr8zIrKh9IKXRIaG8nN5QTFvYNQ6iEJ0sKf1x/kC5KLFvnxl2mbm8XoQoxzZ
 X9DaDmAbsT/R+bYamIRHz3C83XLy75jRg9GZUl4TQnmHgRPEdEe02WhRuNPiTL228Xnn
 wFLZvawFJfAhOL3ni+2uAmmAFrGuIQCoyq47CWcUw8/FfTYUE4PPlfs9Ib+awWDdkKuT
 sVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702409744; x=1703014544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qtpDzmC2fPWyklxZL3CGK81+89kWbTA62dfbpXj/Vw=;
 b=XfaZETROgcYJOacP/XJe6194Zjhx8JoqLw08cutCMHLnkN2PqnTmV2/4VeJfU9FqBr
 dGPsGjuxbv2fOCnllT8+JmlL8UZ6eLZE3EPr5L4uO1M7KDnOgojs8a4bJug/VtQ/rDVd
 2K3X5h06vvk9PHvmv8Dqzo/kWZXMV/wa71uMOR8LKnInkz/Lohq2kboOstV6WXeD+b4V
 sQc41HZfgedF2gzyulgdtJY/W+xoIgyklztXCdS5XJNPNTRMj8BHs7l4gvBWAkRS9A+G
 Q29Lia+XOoENKbeDXGgA1NJY65qk/4biecU+Q28sbiPL5Iu73/IkQrVIKmhq0yxanIov
 LSbg==
X-Gm-Message-State: AOJu0Yxezs5Tj0EFwIImGEmzlbsbFcvUbPhmOUN57B0j7n8ekDWU9Fe2
 Qae8TnMAqFJbSq8jd1gEHm0W1gyLCySxYqSOgs9DQg==
X-Google-Smtp-Source: AGHT+IEBkO03OnNhWmMrlUAgSXkLsCHMVI3zoOAfT6V6iuN5H6cHIob+pxnoep6JWZcF+cTFwP5ywg==
X-Received: by 2002:a05:6a20:f397:b0:18f:c875:6b3b with SMTP id
 qr23-20020a056a20f39700b0018fc8756b3bmr3559231pzb.100.1702409743969; 
 Tue, 12 Dec 2023 11:35:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x6-20020aa784c6000000b006c8b14f3f0asm8495582pfn.117.2023.12.12.11.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 11:35:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] tcg: Reduce serial context atomicity earlier
Date: Tue, 12 Dec 2023 11:35:42 -0800
Message-Id: <20231212193542.149117-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reduce atomicity while emitting opcodes, instead of later
during code generation.  This ensures that any helper called
also sees the reduced atomicity requirement.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2034
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 28 ++++++++++++++++++++++++----
 tcg/tcg.c         |  9 +--------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index e2c55df217..f11043b449 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -77,6 +77,13 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
     if (st) {
         op &= ~MO_SIGN;
     }
+
+    /* In serial mode, reduce atomicity. */
+    if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
+        op &= ~MO_ATOM_MASK;
+        op |= MO_ATOM_NONE;
+    }
+
     return op;
 }
 
@@ -428,8 +435,7 @@ static bool use_two_i64_for_i128(MemOp mop)
     case MO_ATOM_SUBALIGN:
     case MO_ATOM_WITHIN16:
     case MO_ATOM_WITHIN16_PAIR:
-        /* In a serialized context, no atomicity is required. */
-        return !(tcg_ctx->gen_tb->cflags & CF_PARALLEL);
+        return false;
     default:
         g_assert_not_reached();
     }
@@ -499,13 +505,20 @@ static void maybe_free_addr64(TCGv_i64 a64)
 static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
-    const MemOpIdx orig_oi = make_memop_idx(memop, idx);
+    MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
     TCGOpcode opc;
 
     check_max_alignment(get_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
 
+    /* In serial mode, reduce atomicity. */
+    if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
+        memop &= ~MO_ATOM_MASK;
+        memop |= MO_ATOM_NONE;
+    }
+    orig_oi = make_memop_idx(memop, idx);
+
     /* TODO: For now, force 32-bit hosts to use the helper. */
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
         TCGv_i64 lo, hi;
@@ -608,13 +621,20 @@ void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
 static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
-    const MemOpIdx orig_oi = make_memop_idx(memop, idx);
+    MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
     TCGOpcode opc;
 
     check_max_alignment(get_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
 
+    /* In serial mode, reduce atomicity. */
+    if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
+        memop &= ~MO_ATOM_MASK;
+        memop |= MO_ATOM_NONE;
+    }
+    orig_oi = make_memop_idx(memop, idx);
+
     /* TODO: For now, force 32-bit hosts to use the helper. */
 
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d2ea22b397..896a36caeb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5440,15 +5440,8 @@ static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
     MemOp align = get_alignment_bits(opc);
     MemOp size = opc & MO_SIZE;
     MemOp half = size ? size - 1 : 0;
+    MemOp atom = opc & MO_ATOM_MASK;
     MemOp atmax;
-    MemOp atom;
-
-    /* When serialized, no further atomicity required.  */
-    if (s->gen_tb->cflags & CF_PARALLEL) {
-        atom = opc & MO_ATOM_MASK;
-    } else {
-        atom = MO_ATOM_NONE;
-    }
 
     switch (atom) {
     case MO_ATOM_NONE:
-- 
2.34.1


