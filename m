Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142887D7975
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6h-0002AW-Vh; Wed, 25 Oct 2023 20:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo61-0000qn-Ca
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5n-0006Yt-DR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso11225625ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279557; x=1698884357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+t3wVy/FdNCvxU+M502QkXc3hNFmFswkh6xHioaLL8=;
 b=LkIcs2R4+lDMocz4cT/MQkJZZJy0+SqxfU/x0BfGo3Y2hesmWPMRpMQ0WwYYc3c4h9
 wcmPCT4a/MpHjvXibfX0tZAdP7kqLZid9at4YQS31+vRKVEaeljVvu+70fCIxF7wo4q9
 vHMHyGvO/M2IW1iSRk34WU6urTTiyj+1794HkDXhHUxuTNjrNc75xk2GUODV0uX/73kJ
 w0c+0U/5oOoZjB3Oz0SDtp+lHXxSGCoF8xSA/n516XDManvh5SvZzD6ZAo3aETj1n1FL
 JRCcmXCcBLQu8C1zOX2hHtolr8NybBNTgMtUOMoiGVs6qGpxVxKAvC2a9owdj2mkmAkA
 tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279557; x=1698884357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+t3wVy/FdNCvxU+M502QkXc3hNFmFswkh6xHioaLL8=;
 b=V8TW2aLp8f8fZvV67+0vKI/C+HXw/D7MHFkE1CXttt1Cqbr4810zICQ0JTTs8Kd5Ev
 5aIz1j6uDTwSoljRCunOmOGRZppR26ala8YaiMXwT9tKApVgnpq9cbggsXJWJ84gdfgm
 7BgHjrAek0TwIADkvu+04ufkn1RfvWmWConKiFBbxqgZzrnW2LMWE3EGx0QxjKhXvWCX
 p7krnGtKOy+waQhenY3sXenDrLNP18uYpkUdKEQhdsE+TvDq/zoy8e9l/ZCucULTlvJv
 HzbPQmdniXI71qnbEvy4k6FMscEmOgy3YoY1tskzHHn72kxKcaAy0njuU8WE8yANutjT
 drhg==
X-Gm-Message-State: AOJu0Yzi7x/8pY0W0Dz4t937ncY916uZjW+fngz+lUYcUSQPZ31LVPRF
 Sn8TaKumEydj5FsdAuEGQY7F7pjSuya8EsT8pYI=
X-Google-Smtp-Source: AGHT+IFZRhJV3b1H9cELKCjJ290eAb/7DCAQZcuhm1x8z1jqsX5YibFUNdiW587p/NsbBLVsWjKCLQ==
X-Received: by 2002:a17:902:dad2:b0:1c0:cbaf:6954 with SMTP id
 q18-20020a170902dad200b001c0cbaf6954mr1590652plx.25.1698279557581; 
 Wed, 25 Oct 2023 17:19:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/29] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:19 -0700
Message-Id: <20231026001542.1141412-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index e958e3c242..feeb318c39 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -606,9 +606,11 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
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
@@ -648,7 +650,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
-    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
+    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const,
+                   is_tst_cond(cond) ? ARITH_ANDCC : ARITH_SUBCC);
 }
 
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -743,6 +746,15 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
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


