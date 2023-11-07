Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1C7E3350
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9K-0008O1-Vt; Mon, 06 Nov 2023 21:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9I-0008Lh-RI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:04 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9H-0005tT-7h
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:04 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-49e15724283so2006049e0c.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325342; x=1699930142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QmgLQHRjVVBRPaZdvh0i8/8wa1sGosyB6yu2fFTSqQc=;
 b=JhvcgDVXldMNChA/jvrkCBd8HCjaVvrqwd8yectWOa+337m9Q/3hhu+lCHgHM2h4xq
 Ukhqf4R43knYgKGSpcv3DVZ8Dg9j6bwUZkrW3LNYJcmvcj7WIRPkEGikrCKWgMTEPQET
 gJfvjXldxw8bMSFJcnSsLMSZjfWTdu5wZRoVu0Z2CL1gOwqL8t6j+wG6hBEUq10Ols2X
 /b0YtfF16faClD2ixNrngURz1Wa6EGUciM2tlymNiLARF6+LYEoW0HvxsbvsQShQ0CqW
 vUs8hwmuKEOkpI4yMrHZD8k1EKtwkXUMDTzbq/R5mXa1sAiXbYEL8vcATlMSI+A9UPkD
 cFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325342; x=1699930142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmgLQHRjVVBRPaZdvh0i8/8wa1sGosyB6yu2fFTSqQc=;
 b=FUNhwi2dEG1q50gqpkcDhL5u1ND9fYrhaZRh4u9dPQ59PHxIpo3NUSJUhGRosyAXSt
 IKQ7/v6s63wwecH7MX4eeA8pr4TpdRZrSztzU8IItzWJX6NmaOZJIkagrvL9dv+imxy1
 chmOdIb89PBDhBQUyV3TKHZvvUmErJCNWpnvwNWqkB+l7USiVi5K619028z7yaN40vkf
 Rr7o75qOP3xzPWgvFIDph5aBQLOQqVJZhpSE43ReWR3OQYqMPIP1FuxoeS+pJ3CDa01z
 2WLNtIXpuqMTEKWVElXE5Hd3Lm8n6IeVdphy5ClTaIt5yOeCaQ7w3dJGcgRqnDMYKrgQ
 irPA==
X-Gm-Message-State: AOJu0Yx/6HbGKMCU7ghiWFaxvolEHFJz1u5LpHEl2KKBoJb7CDSIgK0t
 +g5JRUoiHPJSWCtaWtxywZChCfFk4IvCeqHuWko=
X-Google-Smtp-Source: AGHT+IGLCC9S6cuqLD6aGrWYkdBeTbNxUVMVW5xbH90EL7lQz1SOTsNCODnZBtG80nSKltTLqJoUuA==
X-Received: by 2002:a1f:aa0a:0:b0:4ac:6a9f:2bb4 with SMTP id
 t10-20020a1faa0a000000b004ac6a9f2bb4mr2499959vke.15.1699325341973; 
 Mon, 06 Nov 2023 18:49:01 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/35] tcg/mips: Implement neg opcodes
Date: Mon,  6 Nov 2023 18:48:30 -0800
Message-Id: <20231107024842.7650-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231026041404.1229328-5-richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.h     | 4 ++--
 tcg/mips/tcg-target.c.inc | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 5b3fdcc726..20c14224fb 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -184,12 +184,12 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_neg_i32          0 /* sub  rd, zero, rt   */
+#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_neg_i64          0 /* sub  rd, zero, rt   */
+#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 82b078b9c5..8328dbdecc 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1920,6 +1920,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
+    case INDEX_op_neg_i32:
+        i1 = OPC_SUBU;
+        goto do_unary;
+    case INDEX_op_neg_i64:
+        i1 = OPC_DSUBU;
+        goto do_unary;
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         i1 = OPC_NOR;
@@ -2144,6 +2150,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
+    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2157,6 +2164,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
+    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
-- 
2.34.1


