Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60297D6299
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIb-0000GN-JB; Wed, 25 Oct 2023 03:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIY-0000FC-Kj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIX-0004hD-2U
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso34955405ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218844; x=1698823644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfu2q0GKRofhI6YPhlOPKDeRs/2pMo83YmOW1OzfqTU=;
 b=hzL0PtGgxAgGzYpGjXiBNSrxnyuHgrWYmcHklDfiQmaegpvEyr6pAkvwkA4SPrPFYO
 FmeoFl4FnuqRnYzE8S7AdJ0jKep8X+kqN/OwyAWwDJzYqWra05Vybbcb09RablLZuxLO
 ygiEi5J/xNJ0pjEPOwxWvX+dRYlczYsikFWGoxQeN1KeJizJIf8JjByzmO893U98v+3z
 xAa0tGJEU8DJ5BdvhNzS+MVIy92ttVZPDka2WrUHQ2LVMOfKJmMbwr+rpMzENH7OLiGP
 zckqtMuI2PBhrgFU8dKOOEH1wujDK4UbO7j4aFKWw4vV7rCl77v4+de5BxiRfuJEmcwx
 /Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218844; x=1698823644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfu2q0GKRofhI6YPhlOPKDeRs/2pMo83YmOW1OzfqTU=;
 b=ufMN5O/D7cBMvAfN/RI32jvHdE1sIhrlzC8RzS+1Idq0IdPppK16luypMiZ4k1E0lR
 t9OxhlI869hKb9bE5omqLI1KHhaAfsar0TPSaHnsb6Khv0JCqVcFlQddo3bJO2edaxsi
 b7sLlas6/xO00bhDpICLwK5cfN+Khf6oSXRrC7kxyvXcvlbGnzIJWaaYkGWGH8o7rfcp
 Ggv0SlhPOzBn7tUZWI5xWBgtHC005CwooWXqLvMwxjS9dCzYpF5mGq/JBjg+4b+50kmN
 Y8uasFBXMcAsoSSMMrSg78cL6ZoSUyrl+TmfAmld5qm5u2Fs4tWxYJRLLOy1+dtIxTXv
 1hCw==
X-Gm-Message-State: AOJu0YxnLxqxKt91xLCR3X7ZDkgqB803dHio3ZKC+rxIOujuEx3pj4rE
 JTI2JgPqafgenVBChJ/FZy4bHRowGmJEjMhKPbM=
X-Google-Smtp-Source: AGHT+IGpbwDy0hHm9V1kLPiuvBu4dsKJqmDAFSn/dDZyQY/nRZMZR9vFf77ECs8r8jnkcEqEV2jVQQ==
X-Received: by 2002:a17:902:c94d:b0:1c8:91d8:d5ca with SMTP id
 i13-20020a170902c94d00b001c891d8d5camr12073994pla.42.1698218843811; 
 Wed, 25 Oct 2023 00:27:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 16/29] tcg/riscv: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:54 -0700
Message-Id: <20231025072707.833943-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 tcg/riscv/tcg-target.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 34e10e77d9..3997e2f274 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -798,8 +798,14 @@ static const struct {
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
-    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
+    RISCVInsn op;
 
+    if (is_tst_cond(cond)) {
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP0, arg1, arg2);
+        cond = tcg_tst_eqne_cond(cond);
+    }
+
+    op = tcg_brcond_to_riscv[cond].op;
     tcg_debug_assert(op != 0);
 
     if (tcg_brcond_to_riscv[cond].swap) {
@@ -827,6 +833,7 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
     case TCG_COND_GEU:   /* -> LTU */
     case TCG_COND_GT:    /* -> LE  */
     case TCG_COND_GTU:   /* -> LEU */
+    case TCG_COND_TSTEQ: /* -> TSTNE */
         cond = tcg_invert_cond(cond);
         flags ^= SETCOND_INV;
         break;
@@ -886,6 +893,15 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
         }
         break;
 
+    case TCG_COND_TSTNE:
+        flags |= SETCOND_NEZ;
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ANDI, ret, arg1, arg2);
+        } else {
+            tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
+        }
+        break;
+
     case TCG_COND_LT:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SLTI, ret, arg1, arg2);
@@ -1079,7 +1095,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     int tmpflags;
     TCGReg t;
 
-    if (!have_zicond && (!c_cmp2 || cmp2 == 0)) {
+    if (!have_zicond && (!c_cmp2 || cmp2 == 0) && !is_tst_cond(cond)) {
         tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
                             val1, c_val1, val2, c_val2);
         return;
-- 
2.34.1


