Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4C7D7930
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo30-0007MQ-Ho; Wed, 25 Oct 2023 20:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2u-0007BQ-62
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2m-0004tQ-Ey
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso2037835ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279370; x=1698884170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jfu2q0GKRofhI6YPhlOPKDeRs/2pMo83YmOW1OzfqTU=;
 b=V8SckxP7XvyqVSAJ4TIWQovghMVmTPYWGm3a8IT6QRMBlfuCk4QEIVTIKyuRvR6p8b
 UahVk6H+oz3dZFyzfxvzRnNxRkTRbO1ZNH4xefFLzTLsX0ifZcNv4GyiEBQcdO43HQCP
 Mu2L+q4DNG4/+kV+wh1FaXlY9oRMCdBDuvYBCEHCcJ5KGcua0ARZJXZHJCW7a0EGhFSp
 LwDwAtJc++AwWJV7uA4yN/i86Veia2UtGLVAsQlEuyhTTHFfU3vdvXxQU/0cNDCno5S3
 WCiUooj+ICyrdUN1WKRHfTYR4KzMiWNKG87vBT13NkaTUeDVj6hhngmfEuOSuSIVdDGt
 4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279370; x=1698884170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfu2q0GKRofhI6YPhlOPKDeRs/2pMo83YmOW1OzfqTU=;
 b=ZNIPjl4hcgwYz+qzhbtZ/WUrZYfe1M/GMz349w059GSWXt+rLyx2qvbQNK4sS6aD4z
 Ng5Z2MM2CKOP9U4qBfks+++u5QPrzCR3zR8JALOV3wWuWWvljZtDa+0doTYoo+1S4Cgj
 vTruR1qffl908KyN4kpg/XBcAEFNf0UuN821DUFRFRaUP71cHb2YfKmD2rOHjrQ7UuuX
 7IO5kLyKtkt+zwGBBCkkScct+hcyC3nESZV/hMa6nz5u+O7GPZZ8I415+oGOw+cWy7Eg
 xckp+zoy3AuUPq7eOZVT528geEVWpPr3ef9nxsls08Y8IeflpCIWHbdoxg7R3kK0TKP8
 qjAQ==
X-Gm-Message-State: AOJu0YzirxFs4Qq7ddbuMjSUXtfVJP1Sa/u8k16B3JZFajyPi9j1YWJS
 NVF/TELI/9JSh+5DUWMP9xVmrmAT3lWS12mN7gc=
X-Google-Smtp-Source: AGHT+IELMpj7ukEgOm85gwohCgawpQGsMWhS4YW6MRwdDCBty8D7skDpLiKd9OvVyFt7LzJON45lMA==
X-Received: by 2002:a17:902:7485:b0:1ca:7086:f009 with SMTP id
 h5-20020a170902748500b001ca7086f009mr12457851pll.61.1698279370159; 
 Wed, 25 Oct 2023 17:16:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/29] tcg/riscv: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:11 -0700
Message-Id: <20231026001542.1141412-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


