Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A467D6312
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIV-0000Cd-UK; Wed, 25 Oct 2023 03:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIT-0000Bc-Eg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIR-0004ff-QO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso35807685ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218838; x=1698823638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZENFqh4cY1cxr9SwQWDQ8KTGiGlTUEViewQDnyDP2A=;
 b=IIU1kLIORuaAeixKtganub6E69CAPyh/3JWbKPU6nDkvAJV1mLPNQYK10uXlPjOfiI
 k+XkauJe+caI6Z8G5LpdeHqjkDKljr3k5LstdGRFFjPZahy6YnAiBMYL9otVJ9+U7XnF
 Jvc9UVD9JaXNNqjnmk0o/7scpsHVMZK+/5rMqzoM3pVXOl5HGEIjxolyBFmZextzDUZe
 yZthwrrJSPajbBgDa2JChpltYYwFOfORR9snueR5f7qUbb4yiSXHAALrC0/W940PbbEg
 LEsOGQ2yKdwF390jRijboNRXwlWH9arxJ5ULJJX+/vzGk0PoScV3lIkQKUu5uIqNPusc
 yoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218838; x=1698823638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZENFqh4cY1cxr9SwQWDQ8KTGiGlTUEViewQDnyDP2A=;
 b=d7qX6OwW5M9Ocaw1YvDxONoQD7Pfs3N7ZcyFJ6JDdt2lu6WhxA0uDuI9PBQ0sBYAx4
 YhV3b/9rrZ4uJtDyyMg72ft7BvEAShF5yVSven2bvjiSoGwCjXllSNshGlQcAXXiGdza
 rVRP/dHDf2y+8fZgk73PU9xluYH2NGrJOODRgnqNspecBecICItmr1hIoul5nLf4zYvd
 tupL4KehfrmGLJye74L2gy/bm19by/ZevPt0wwTlkPx5g4x+50I253pWzy1IAAFFXmCg
 RLlp/+D2xucj1a82tSphIbZQrpUl8Avtf/RDIzz9PJsm2780jD87Z66wzJip1vTiHgEP
 +rTA==
X-Gm-Message-State: AOJu0YzYI3yriRrnMG1D3dc8O5JhOVvAQ1wL48cZSlCBBqxzw+wNMTlE
 aBom+IOy2YYwE1pkm803gZ8iMcUR2qSqhNVuXg0=
X-Google-Smtp-Source: AGHT+IFW+sMs2lsB1PIPkxhz7IslmAUw9mdIIDCWh/jtPF8e1DafykogFKgv26KYAZQAcyW6+tQlAg==
X-Received: by 2002:a17:902:dad1:b0:1c5:befa:d81d with SMTP id
 q17-20020a170902dad100b001c5befad81dmr15195157plx.10.1698218838331; 
 Wed, 25 Oct 2023 00:27:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 10/29] tcg/i386: Pass x86 condition codes to tcg_out_cmov
Date: Wed, 25 Oct 2023 00:26:48 -0700
Message-Id: <20231025072707.833943-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Hoist the tcg_cond_to_jcc index outside the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab30..0daffb0e70 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1668,14 +1668,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
         tcg_out_label(s, over);
     }
@@ -1686,7 +1686,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, cond, rexw, dest, v1);
+    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1698,12 +1698,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
@@ -1716,7 +1716,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(!const_a2);
@@ -1729,7 +1729,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
         tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1


