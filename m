Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494E7DA8FE
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFw-0004q2-47; Sat, 28 Oct 2023 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFe-0004ki-LK
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFc-00048I-Av
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:41 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5b94489e82eso807406a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522339; x=1699127139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd1KYkP1mjjPOSt2a57McXEK543XMiCskNaYfZeSrS0=;
 b=ekzLAxWRr4VGMgkuSzoEqbZytwQFZ/Q+2k43P36hYiOp5tFSzZMZm9TaX2gDk89fgG
 aaavhkEiYjhY/PiobWLZee3clN2Uojzy5EJQI3rgLT/KOx1tQDxDQq69IpvX/ECbF5+V
 6kHsOoawmfmHB7fWowhhJOU9Fv91ipIi7whuBvErp9PUmR6cLwTiRF/+NKWSE+0Piajo
 TaVzC0lbIEaqOsnct9/+6RsQR5T/O1nwJTbDAOTLAKSqRWZnQqsdRzcefHc8FdD2+iyA
 7oXK/ZO0gcUolxx76i/oJ7nbAOwJxxAfhVMm5cmgYVVvNb+qZoI+8dt27pgbO4mnTYRK
 di6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522339; x=1699127139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qd1KYkP1mjjPOSt2a57McXEK543XMiCskNaYfZeSrS0=;
 b=vlcBZCq+fbf29Emr9uZsqlrjR3Jrw4oki6V8eL7Gq/beHunUqlnaA/lPvl7x5gziGa
 2DG7TxMNJPq8fE6G5g+iMBznbFgo9D+Xt+PtMfUO/4TaIhR8fvekPRnZH/5321rVmz9l
 xiqJGqRWI6IUBojxhm3Yg7ZyhEZ98eLYuvT4od2bBGFJojrCjr62G93R/FqNcf31FKNa
 hFT+y6OF34/ePa0bBnbmzXwKMVuqOw/xuSwd5zTj5CyK2uBLPbmHyVyT/SHiOTnofanQ
 4YvpfyySQwRB1Bgy2k6Iqt114SQxDJGNPTi7708oVLbOAGRMSh3otW1T16Tm4xPT2Ae9
 4TyQ==
X-Gm-Message-State: AOJu0YzX3Oj/gm8q1GfqcW/hNPLqMl6JSIAEBxYDAs/VuLhh6dTMLckJ
 XcjVvGe9S00HnRHoxGMJdMvtcitcvRSKUJhpkBA=
X-Google-Smtp-Source: AGHT+IHv/y1an6nnroIbsp9aBHNVnHZg+N2BUFaJ9qscsj6haHYisWe5Pjv09Qs3Ml8KuceVxo3qRA==
X-Received: by 2002:a17:90a:f298:b0:280:2856:5eef with SMTP id
 fs24-20020a17090af29800b0028028565eefmr1073584pjb.22.1698522338811; 
 Sat, 28 Oct 2023 12:45:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 16/35] tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:03 -0700
Message-Id: <20231028194522.245170-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index 384d2ba342..7770e1bfa0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -556,6 +556,7 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
     case TCG_COND_GEU:   /* -> LTU */
     case TCG_COND_GT:    /* -> LE  */
     case TCG_COND_GTU:   /* -> LEU */
+    case TCG_COND_TSTEQ: /* -> TSTNE */
         cond = tcg_invert_cond(cond);
         flags ^= SETCOND_INV;
         break;
@@ -612,6 +613,18 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
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
@@ -696,29 +709,36 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
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


