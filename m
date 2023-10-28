Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD77DA919
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG7-0005Ee-Q0; Sat, 28 Oct 2023 15:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFi-0004l1-Sv
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFh-00049G-DR
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:46 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3576121362eso9787735ab.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522344; x=1699127144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bILXU6Tv3/UsJC5IcZK0AlLd3YFdGLp0U4K4tlGQLvs=;
 b=wsKrDK4VxrHWc/x5L15gEIxQsQ6OUYWH9xdkpcl7YlmEftdoxImKEnQuKC4zet5Dsa
 oA3hIm0ocgYIsYt54oMPcxiq59t39aRwKHZU7q4WVvyuq/NAJVv+gGQA4kgcH/N5Dh9x
 UbDNIIvwv3rk8uCeTxSSogxG3cSBmOQtRdqJGGt5/yefQ1ez7shtPl+Ex01zCYnSAZYY
 3Twtj4U3SeZhjeVuy3vS+wiR5HfBxZX5tEmNMSf7lpa9OIOPWuJoxmUBdfZcUx/VXngH
 wjLI7DtM4x2K4vBNLZK8a18ZtsDzbPjos4loEiboD3bLuvA9/N7Da74QzF3jgQJeMJSv
 46yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522344; x=1699127144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bILXU6Tv3/UsJC5IcZK0AlLd3YFdGLp0U4K4tlGQLvs=;
 b=KoE8TX0HuOR5BNpwTP8HixorryJ4ZUCts8IPT+foY/gdrb7OnVKuFWJWMPJMpn+n0a
 ag5WcLzmY3Xw9lnaf56bJnDh+uB+/NrQPZq7u8aai4cncjiUB+YW93DdpJ5zD2y7yP2C
 5m6OpcvCg1DHVqyfJy4fJ0waQqxjeVm4HDpawj540vAkoa64KR3Q/SuTrwDigkyzme2t
 90VcGNg7UrMVMvTDARg6PHFwUptpeo4WCQsbqUXMySV4fqGxOK5domdWKPlaY6GS2fOy
 +jBoDv/8w6NrM/uG+4W9cHrPtAA/iC2bH5dI6sXo2lSt2OE+6nE6YngB+7Z8cz3LeCQM
 0/Hg==
X-Gm-Message-State: AOJu0Yyu1eGFiYmV3V6gaIjaFWVx9t5DpHD3kAazkB8EfFDP61PjhtkR
 1uHtkF171bAiDj3cgjtEeW5BxPW1ALG4p0tSNm4=
X-Google-Smtp-Source: AGHT+IGHNyki1/dZ+aQQuuXINUoht13lh1zGAnN/0t3QnilQ5GNYFlyPPKOdS8lJUH6So2tI9eqDxg==
X-Received: by 2002:a05:6e02:2163:b0:357:704a:8699 with SMTP id
 s3-20020a056e02216300b00357704a8699mr10683602ilv.8.1698522344165; 
 Sat, 28 Oct 2023 12:45:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 22/35] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:09 -0700
Message-Id: <20231028194522.245170-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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
 tcg/sparc64/tcg-target.c.inc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 10fb8a1a0d..176c98740b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -607,9 +607,11 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
                    uns ? ARITH_UDIV : ARITH_SDIV);
 }
 
-static const uint8_t tcg_cond_to_bcond[] = {
+static const uint8_t tcg_cond_to_bcond[16] = {
     [TCG_COND_EQ] = COND_E,
     [TCG_COND_NE] = COND_NE,
+    [TCG_COND_TSTEQ] = COND_E,
+    [TCG_COND_TSTNE] = COND_NE,
     [TCG_COND_LT] = COND_L,
     [TCG_COND_GE] = COND_GE,
     [TCG_COND_LE] = COND_LE,
@@ -649,7 +651,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
-    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
+    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const,
+                   is_tst_cond(cond) ? ARITH_ANDCC : ARITH_SUBCC);
 }
 
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -744,6 +747,15 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         cond = (cond == TCG_COND_EQ ? TCG_COND_GEU : TCG_COND_LTU);
 	break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Transform to inequality vs zero.  */
+        tcg_out_arithc(s, TCG_REG_T1, c1, c2, c2const, ARITH_AND);
+        c1 = TCG_REG_G0;
+        c2 = TCG_REG_T1, c2const = 0;
+        cond = (cond == TCG_COND_TSTEQ ? TCG_COND_GEU : TCG_COND_LTU);
+	break;
+
     case TCG_COND_GTU:
     case TCG_COND_LEU:
         /* If we don't need to load a constant into a register, we can
-- 
2.34.1


