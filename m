Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E17E5F7D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pXs-0002dS-SM; Wed, 08 Nov 2023 15:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pXo-0002cB-Lw
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:53:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0pXn-0004jL-14
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:53:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso500435e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476777; x=1700081577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0rJMUi/gausB2354OHnP9/cZ1B+HNET88uH6ucO7Ao=;
 b=EBAC3S3MbnCiMn7olJrLvyGHpwuv9j0aOGv1W5G+tI5GOk9yZz2j23ZMzmrHsnIPpT
 0dSgk6IMV3bgt4fiyapPxZCKqYYULo11m8h4HXBLiYkRXQ7n7d92NHu5I/B8++gzsKN8
 VDramyyT2ys3mYs5kLIMq97Ihk22kCVSM4h9IjuXef73Jo9aAp4EU4R7dOyY/Mk8gVaN
 4UB8tp/Arj6UFbPRgQ7zZnGbbNwJWegNLsvS6ZAVlgV9QGv83WH2YCnwmR1fyL0E+vx8
 tFJ+DWsp4taOEQQ+Y+8G21QjsTLFN2LF0caVQuUgt8WSwLcegxFQt7aNB17zdO2KgyJE
 CYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476777; x=1700081577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0rJMUi/gausB2354OHnP9/cZ1B+HNET88uH6ucO7Ao=;
 b=pWf/sz70IDnLfwDF0wcCn99DmhuRI0lS2iRp+QcX05WwVTNY6lKZ9AFBx9Mo2LfPQh
 pOvWyWcJd3bmY6HK8wP09X0ZaK1ONpWfb8cnHPcRTl/F6VirgP1o0ER9ovEajbhIk1ju
 BWTh8nWiS2wt8+Qu54gb5xTeaNO87U4iHBypIyPUAXb4vaPl3uZ4GagTz5ceeRLa6UNC
 ybzy598dB7atE33E3Ynamcq8pRmeec/vroDsStpj22Z9KBdf3F8u/1X6ta16lHmjvXP2
 rj2jpBeWbdqt+CtoTZik8JdRgNPbbL5MhKTJrxagwkyggFY4K2jOC8lmP9cBd5BkrHO4
 oSdg==
X-Gm-Message-State: AOJu0YxwE86pmtEfgWVM+dSWQgAVMELc5DHcx+MdHhuBcnCjSEwI7/u7
 94TQJDe9nzC3ML6Lj1Gbjh5Q1mqyIScv/cCR2A0=
X-Google-Smtp-Source: AGHT+IFRfOpsVifgOaaT2VFV714uO3F/Qq6TVa6yhAVRSoeUEGNvpKONULIRtbabvvxkSnkydtulIg==
X-Received: by 2002:a05:600c:3553:b0:406:c6de:2bea with SMTP id
 i19-20020a05600c355300b00406c6de2beamr2775616wmq.17.1699476777096; 
 Wed, 08 Nov 2023 12:52:57 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a05600c1d0700b00405bbfd5d16sm20539774wms.7.2023.11.08.12.52.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Nov 2023 12:52:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 32/35 2/2] target/alpha: Use TCG_COND_TST{EQ, NE} for BLB{C,
 S}
Date: Wed,  8 Nov 2023 21:52:47 +0100
Message-ID: <20231108205247.83234-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028194522.245170-33-richard.henderson@linaro.org>
References: <20231028194522.245170-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 46efe1df7c..49e6a7b62d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -482,10 +482,10 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                               int32_t disp, int mask)
+                               int32_t disp)
 {
     return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
-                              !!mask, disp);
+                              is_tst_cond(cond), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -2820,35 +2820,35 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x38:
         /* BLBC */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTEQ, ra, disp21);
         break;
     case 0x39:
         /* BEQ */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x3A:
         /* BLT */
-        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x3B:
         /* BLE */
-        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x3C:
         /* BLBS */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTNE, ra, disp21);
         break;
     case 0x3D:
         /* BNE */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x3E:
         /* BGE */
-        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x3F:
         /* BGT */
-        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
-- 
2.41.0


