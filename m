Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4242C7D630E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIZ-0000FO-Hh; Wed, 25 Oct 2023 03:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIW-0000EE-Qt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIV-0004gj-6z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-694ed847889so4607473b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218842; x=1698823642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OzJNyxwCQ0VtQM+kCN+UsaskilG2xBh6wLePJyHv0M=;
 b=SkkKhfCLxR/5BhANU+RAeJP08fJyjV8T3hUldCRQgflcreviMx+KlFwQ4oJQvu75qL
 3hmeuvluz4s/y6VHzg39CpBBdNwhLUCeH3AP4JaV2pe/PJGKanJQ83j6Hx5PCni6GJ+I
 dWS0bNkuvYgATRBTOpqdoUZBbtI0ruCMy8ZvALkwQOClvtCSGdifRnVahpj2qTuAYNMp
 SXVerHa9aJz8i/H4JhKhH883dvgT7vhAeUOr6IRPrFZbyrIVpukV+5Dqg1ZLw/X/BiZo
 dJn1+Ce3keQXFYAweXKq0TbAb/QdR0UcQketcOA4t8+tk8HyU9tDwh/10nhC0fokVebf
 yQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218842; x=1698823642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OzJNyxwCQ0VtQM+kCN+UsaskilG2xBh6wLePJyHv0M=;
 b=vauQotPYIhT7CBbM5sCoQe+TXiLoFYXs43Cop4tEp//9pKkdQz3kIk5xSFdpKg3CAD
 ME5SLURM8M9bL1Rc72ll22iQopY1ARX9ID7I94EIa1r760MMXap56S+35RuU2ZYaNhqj
 9w+dkd0ztvexU46nmKNnEkuj1h2DDbWl+/WOXVp2OL2bm+UtDoEcqX+IBEFF1Pptmek7
 AeXeZmqjgfem8e7+z+PvABck+5zqy9heru2ou/RgRk9sziWsrlACPc/Bv81tobL7mPdy
 0BuE4aKpVJtVV3YylfAj4W+VfcN2hndw3GX9A7p8mAm7Xzb4XtZYoq3Lb2Vzehr1cLeB
 4Z2Q==
X-Gm-Message-State: AOJu0Yz0RyOkKHLmNUewy3b6ggRYyxAJsLGvIRqYOsLraKFV8mbiZ6P3
 KW7VxTc74CnSnnMe3Q9MW6rQrcF5GqYYZdh0JdI=
X-Google-Smtp-Source: AGHT+IG2kJ4XneW/Y+cmhPjR6XwksfEaK3cag64sLmVzpVu7U8fRfkRVW6jaRl0bopsb8t7hVgzCvg==
X-Received: by 2002:a05:6a21:66c9:b0:14b:7d8b:cbaf with SMTP id
 ze9-20020a056a2166c900b0014b7d8bcbafmr4215516pzb.57.1698218841788; 
 Wed, 25 Oct 2023 00:27:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 14/29] tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:52 -0700
Message-Id: <20231025072707.833943-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ccf133db4b..4e850a29e5 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -555,6 +555,7 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
     case TCG_COND_GEU:   /* -> LTU */
     case TCG_COND_GT:    /* -> LE  */
     case TCG_COND_GTU:   /* -> LEU */
+    case TCG_COND_TSTEQ: /* -> TSTNE */
         cond = tcg_invert_cond(cond);
         flags ^= SETCOND_INV;
         break;
@@ -611,6 +612,18 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
         }
         break;
 
+    case TCG_COND_TSTNE:
+        flags |= SETCOND_NEZ;
+        if (!c2) {
+            tcg_out_opc_and(s, ret, arg1, arg2);
+        } else if (arg2 >= 0 && arg2 <= 0xfff) {
+            tcg_out_opc_andi(s, ret, arg1, arg2);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP0, arg2);
+            tcg_out_opc_and(s, ret, arg1, TCG_REG_TMP0);
+        }
+        break;
+
     case TCG_COND_LT:
     case TCG_COND_LTU:
         if (c2) {
@@ -695,29 +708,36 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
  * Branch helpers
  */
 
-static const struct {
-    LoongArchInsn op;
-    bool swap;
-} tcg_brcond_to_loongarch[] = {
-    [TCG_COND_EQ] =  { OPC_BEQ,  false },
-    [TCG_COND_NE] =  { OPC_BNE,  false },
-    [TCG_COND_LT] =  { OPC_BGT,  true  },
-    [TCG_COND_GE] =  { OPC_BLE,  true  },
-    [TCG_COND_LE] =  { OPC_BLE,  false },
-    [TCG_COND_GT] =  { OPC_BGT,  false },
-    [TCG_COND_LTU] = { OPC_BGTU, true  },
-    [TCG_COND_GEU] = { OPC_BLEU, true  },
-    [TCG_COND_LEU] = { OPC_BLEU, false },
-    [TCG_COND_GTU] = { OPC_BGTU, false }
-};
-
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
-    LoongArchInsn op = tcg_brcond_to_loongarch[cond].op;
+    static const struct {
+        LoongArchInsn op;
+        bool swap;
+    } tcg_brcond_to_loongarch[16] = {
+        [TCG_COND_EQ] =  { OPC_BEQ,  false },
+        [TCG_COND_NE] =  { OPC_BNE,  false },
+        [TCG_COND_LT] =  { OPC_BGT,  true  },
+        [TCG_COND_GE] =  { OPC_BLE,  true  },
+        [TCG_COND_LE] =  { OPC_BLE,  false },
+        [TCG_COND_GT] =  { OPC_BGT,  false },
+        [TCG_COND_LTU] = { OPC_BGTU, true  },
+        [TCG_COND_GEU] = { OPC_BLEU, true  },
+        [TCG_COND_LEU] = { OPC_BLEU, false },
+        [TCG_COND_GTU] = { OPC_BGTU, false }
+    };
 
+    LoongArchInsn op;
+
+    if (is_tst_cond(cond)) {
+        tcg_out_opc_and(s, TCG_REG_TMP0, arg1, arg2);
+        arg1 = TCG_REG_TMP0;
+        arg2 = TCG_REG_ZERO;
+        cond = tcg_tst_eqne_cond(cond);
+    }
+
+    op = tcg_brcond_to_loongarch[cond].op
     tcg_debug_assert(op != 0);
-
     if (tcg_brcond_to_loongarch[cond].swap) {
         TCGReg t = arg1;
         arg1 = arg2;
-- 
2.34.1


