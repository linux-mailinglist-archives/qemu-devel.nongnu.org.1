Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E707D7934
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2w-0007FA-Bh; Wed, 25 Oct 2023 20:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2p-00073t-Ic
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-0004se-Jr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso2327755ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279367; x=1698884167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8OzJNyxwCQ0VtQM+kCN+UsaskilG2xBh6wLePJyHv0M=;
 b=NiKmpeHGEZNloiELg6jlgl62z3bhRY7+R+44ngjlrVUTLXf7elO4W//7n6Vfbo8qKd
 8xwqRYqyv6SXUogXbdfUrQZIAV444Z22EkIBE67QEC9Ztmyn3bsC8qvMBMLLhkOATgG3
 dh2t/hZTpKZaPludcohkDSmbmY58PyQyoguqnOllvu5ydNdXUUfHDMRfxcKZa0o1BaEk
 RtNqB4tbC3GqUZftAxNMtbdxp8aypz/dETwMLlMq9OgnpIi1oLJgZAP/w9Cd50tlJP8x
 487i5vr7uvU/S6gXmAwDXdrJW8Vj+LXYaTbCA1A4yDDxsdL3NglfAco+7b1Qp6ad4rHV
 9t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279367; x=1698884167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OzJNyxwCQ0VtQM+kCN+UsaskilG2xBh6wLePJyHv0M=;
 b=XZ8pNqxGqTNZuVQcXEpUaA3HSdMNUxYs6Nvsim/SZ5mIsRgLGvtVJrbnw+ufFvVMi3
 7StSS0ItMxltmGNsiGtI4N48NCPeLNByzdj2FgZ2WGIYR+I/5IrPU2S/uKX5Pg2eh1G8
 5edDpxGVTwhLFbkbVNj3+3mBRG5wOgVm0GE+92O3g35EqbvQO+h6FFCxKbz+KkkTjFDJ
 skvG0rRujyRi4NRkMPLAsS1et5MKQfcux8r+EiT37JsqtqQmA13GYY8IyR7axEuX9T9s
 NFI40mBtPZ7wjyoTcyFQs0BL/Q1s0hJ80xNxPnaaEgbrfVKB2IGrDfs8LNCy9zZaoFmw
 +O5w==
X-Gm-Message-State: AOJu0YwI1XyqoAIe1uJtqqRmVqtreoa7Y12Dn87KWBwGUBtrHQHdcCwG
 tJ/Pb1zvF5VDoPN4dKm6r2YHDIz+GoAj+FlmHSI=
X-Google-Smtp-Source: AGHT+IHPkiXs7WEhWV61Gvm2dqCGJsV9rwruiElbMWG/iIdMQGUuMugU/82v0u53Kseq5W7zHYt8hg==
X-Received: by 2002:a17:902:d50b:b0:1c8:75d9:f7dc with SMTP id
 b11-20020a170902d50b00b001c875d9f7dcmr1502222plg.28.1698279367034; 
 Wed, 25 Oct 2023 17:16:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/29] tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:07 -0700
Message-Id: <20231026001542.1141412-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


