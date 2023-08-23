Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF07786184
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOf-0000DC-Vy; Wed, 23 Aug 2023 16:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008So-Qa
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOW-0005Xz-R9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso44715635ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822239; x=1693427039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4APNRLcVqhrba52FGEmqpjKXb1Xd90praU1zvb8ru8=;
 b=YiZDLOh7Lt9pPvVFkBEzQ/S5TqN4cW9tk2109wUVbLfA6PpyfTvyo23+YPwySmWc1p
 wKTkDndLGFBXCU5bURDRgzl6U3EUn1U7xW7tTyC4rcGk1X4nySdzFDK1bOIyVk57kolL
 lGdcoceh3YADZqzctdLSjW4TypwWK5HqXpyPyaWL3nf0pirHHDnOxoHz5SGoGm2pmpEL
 snTlPBUADa+1R3fj9XSocOMaqLZnD4HVXvz0It/Vw64/NJ3APIm+X+iTl5iH6a/K6v5J
 6auGv68mil4YFxGpkn6qY8eExyc6VcW9MwRoVwObTDQAuBW5lHKwNuUBStF0TvY0Y7U1
 Yg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822239; x=1693427039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4APNRLcVqhrba52FGEmqpjKXb1Xd90praU1zvb8ru8=;
 b=fl3tuBziNLjrUEink3qaEqzqUZ+kHVMUqQoYkqGjQRmwGk8AMQsXGRxhChIZN7QlwE
 7pCoyvgNP+Zn/hVTcwSJ7J4B4fCsH3oJ4p6ziSA7oDIbb9jBm8TCIjWYoEH0AyObBF0f
 X9rOu94yB4l6IDmP7Um/HKPcUpWewZmntEPaIoXBsmmqOHQvu4il2d3eSp+b5KqSYBAp
 Nic5wZZHlO624I39JHC4kFDCF9j9WuzmS6txXvHWh3inHSYhNBxhLvzY6TuC3UxG0314
 d4Olb1rko8HLCfsdPcERSw3mFgxXuc8HV6ljIU9cFXtKjEV1Blxfn6rJFWX4DDRUuDWF
 +R3g==
X-Gm-Message-State: AOJu0Ywu8YNR7kWGdaRwGsle7oxCf1ORtjKqLnj1VxXFWvs912DdzG39
 RgdYJOXp0eJB87E2D/vuhWqiHfp/V2mlnr4AQGI=
X-Google-Smtp-Source: AGHT+IHCV9N4VMvUtsi/qMEXoUCQncPq6c3xF0WaX2kW15Ko77t6bXYAOkstiUBFHfELLFrWMPEjvw==
X-Received: by 2002:a17:902:db05:b0:1c0:c1d7:64ae with SMTP id
 m5-20020a170902db0500b001c0c1d764aemr530316plx.43.1692822239246; 
 Wed, 23 Aug 2023 13:23:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 34/48] tcg/i386: Merge tcg_out_movcond{32,64}
Date: Wed, 23 Aug 2023 13:23:12 -0700
Message-Id: <20230823202326.1353645-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Pass a rexw parameter instead of duplicating the functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 010432d3a9..1542afd94d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1593,24 +1593,14 @@ static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
     }
 }
 
-static void tcg_out_movcond32(TCGContext *s, TCGCond cond, TCGReg dest,
-                              TCGReg c1, TCGArg c2, int const_c2,
-                              TCGReg v1)
+static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
+                            TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
+                            TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, 0);
-    tcg_out_cmov(s, cond, 0, dest, v1);
+    tcg_out_cmp(s, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, cond, rexw, dest, v1);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_movcond64(TCGContext *s, TCGCond cond, TCGReg dest,
-                              TCGReg c1, TCGArg c2, int const_c2,
-                              TCGReg v1)
-{
-    tcg_out_cmp(s, c1, c2, const_c2, P_REXW);
-    tcg_out_cmov(s, cond, P_REXW, dest, v1);
-}
-#endif
-
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
                         TCGArg arg2, bool const_a2)
 {
@@ -2564,8 +2554,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(setcond):
         tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
         break;
-    case INDEX_op_movcond_i32:
-        tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
+    OP_32_64(movcond):
+        tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
 
     OP_32_64(bswap16):
@@ -2714,10 +2704,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_movcond_i64:
-        tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
-        break;
-
     case INDEX_op_bswap64_i64:
         tcg_out_bswap64(s, a0);
         break;
-- 
2.34.1


