Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9E80F9B6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:47:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDAaf-00023T-LX; Tue, 12 Dec 2023 16:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDAac-00023B-W2
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:46:55 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDAab-0002go-1C
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:46:54 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28ad71e588cso611171a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702417612; x=1703022412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uB+Zo2dKpagpEEaoOzFwK3Yhfs0kYdWM+6hUjTfBc0=;
 b=c7UeHSoQsZX7Y2SwS2sxPQy8BTVNCwTY3WpenFYziATTL5hwtesekAyW7gwRpga0oy
 LlITTKgV9tgEmrTx2BB6VqiTjnmEY56TDgl/W2eOyxbDdbR8xGX9mlNRaCMvIIANV91h
 noy7HChBN6vOgznMQHi/1AauVOJnOahI8RoO0/rZ+37+VouQbfqq2fLUmbeZyXsJicDn
 oQu3o6lbEJR5dSG1v+gT5G23wBFQ+vUFQ0MkaWkSAiFxXsB/j4qOjrqZgtY1xs1B5ZDC
 f4VA9dzuRggRSUleEOMQXfce/7BTcku2qbba7EMurEb0vNY1Dg9pX11pil+FPPcrubA5
 Qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702417612; x=1703022412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uB+Zo2dKpagpEEaoOzFwK3Yhfs0kYdWM+6hUjTfBc0=;
 b=Ho3oal5/mv7KJiAYPJJbARvbc9754M/URhbR6cANddf/unfcFnBewaPtngeg/wgTBw
 nl7Nr5leUtCnN8HRaRS6WcGWurBcoRDqUyJgC6ENgHXKAKRrR4MxcL2IfWuX6YXGGTqY
 yn9MroMnR+aLPTjba8iRGcuxyfO4jChQswgp0KJEXxAZsFmwTpWXuRqVvHwvKJD0Ai+V
 uSWnRMULZnUVl9OpCQ+qhcpMgEpLo90x4h+CwZKN5KNTeOx3J3wBosfZVn8yZ+iJluT1
 9n0YLu41T8zMnKBCNM2+GP1rdXpq4/uKCcGsmLSVFDDranZ9pGyQSGFYQWXNz1fyaDJf
 qo0A==
X-Gm-Message-State: AOJu0Yx2kTexFz0A3OFAPMCnhqRhHLnROVNC7FZMNQtEPOWdmQ0aYeNv
 ts4lKXlubwJXnr1QYDWOE1IpOt0BNQ0ol8qQPrBeCQ==
X-Google-Smtp-Source: AGHT+IGm5fcQBLe6MKTG91JC2Io2Yxop2SG2ozAhRG2XgNKLVVlyrnqWYOLtIRJ1OI3Nl+Y7NRv9iQ==
X-Received: by 2002:a17:90b:188b:b0:286:d242:2629 with SMTP id
 mn11-20020a17090b188b00b00286d2422629mr3740046pjb.3.1702417611713; 
 Tue, 12 Dec 2023 13:46:51 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 qa6-20020a17090b4fc600b00286dd95143fsm11037538pjb.50.2023.12.12.13.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 13:46:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/2] tcg: Reduce serial context atomicity earlier
Date: Tue, 12 Dec 2023 13:46:48 -0800
Message-Id: <20231212214648.300959-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212214648.300959-1-richard.henderson@linaro.org>
References: <20231212214648.300959-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reduce atomicity while emitting opcodes, instead of later
during code generation.  This ensures that any helper called
also sees the reduced atomicity requirement.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2034
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231212193542.149117-1-richard.henderson@linaro.org>
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


